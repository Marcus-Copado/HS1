/**
 * Created by scheck on 10/25/18.
 * CPQ Product Models packaged interally
 */

public with sharing class qtc_PreviewConfigCTRL {

    @AuraEnabled
    public static String getProductString(Id productId){

        List<Product2> productList = [
                SELECT
                        Id, (SELECT
                            UnitPrice,
                            Pricebook2.IsStandard,
                            Pricebook2.Name,
                            Pricebook2.Id,
                            Pricebook2.CurrencyIsoCode,
                            CurrencyIsoCode
                    FROM PricebookEntries
                    WHERE Pricebook2.IsStandard = TRUE AND Pricebook2.CurrencyIsoCode = 'USD')
                FROM Product2 WHERE Id =: productId];

        List<PricebookEntry> pbes = new List<PricebookEntry>();

        //This record will now have the correct type to be added to the list
        pbes.add(productList[0].PricebookEntries[0]);
        Id standardPricebookId = pbes[0].Pricebook2.Id;
        String currencyCode = pbes[0].Pricebook2.CurrencyIsoCode;

        // Use CPQ APIs to read in product from Id, Pricebook Id and Currency Code.
        PreviewProductReader reader = new PreviewProductReader();
        PreviewProductModel product = reader.read(productId,standardPricebookId,currencyCode);
        System.debug(product);
        String productString = JSON.serializePretty(product);


        return productString;
    }

    @AuraEnabled
    public static String getConfigURL(Id productId){

        // Get the Add Products Custom Action
        Id customActionId = [
                SELECT
                        Id,
                        SBQQ__EventHandlerName__c
                FROM SBQQ__CustomAction__c
                WHERE SBQQ__EventHandlerName__c = 'onAddProducts'
                LIMIT 1].Id;

        // Insert Test Opp
        Opportunity opp = new Opportunity(CloseDate = Date.today(),
                StageName = 'Qualification',
                Name = 'Opportunity');

        Database.insert(opp);

        // Insert Test Quote
        SBQQ__Quote__c q = new SBQQ__Quote__c(SBQQ__Opportunity2__c=opp.Id,
                SBQQ__Primary__c = true,
                SBQQ__SubscriptionTerm__c = 12,
                SBQQ__Status__c = 'Draft',
                SBQQ__Type__c = 'Quote');

        Database.insert(q);

        // add the aloha redirect to stay in lightning
        String configURL = '/one/one.app#/alohaRedirect/apex/sbqq__sb?scontrolCaching=1&id=' + q.id + '&scontrolCaching=1#/product/pc?qId=' + q.Id + '&aId=' + customActionId + '&pId=' + productId + '&redirectUrl=LineEditor&open=0';

        return configURL;

    }

    /*
    *  Create all models needed for Product API privately
    */

    // Reader class to load model from Salesforce CPQ API
    private class PreviewProductReader {
        private PreviewProductModel read(Id productId, Id pricebookId, String currencyCode) {
            ProductReaderContext ctx = new ProductReaderContext(pricebookId, currencyCode);
            String productJSON = SBQQ.ServiceRouter.load('SBQQ.ProductAPI.ProductLoader', productId, JSON.serialize(ctx));
            return (PreviewProductModel) JSON.deserialize(productJSON, PreviewProductModel.class);
        }
    }
    
    // Product Reader Context (pricebook + currency code)
    private class ProductReaderContext {
        private Id pricebookId;
        private String currencyCode;

        private ProductReaderContext(Id pricebookId, String currencyCode) {
            this.pricebookId = pricebookId;
            this.currencyCode = currencyCode;
        }
    }

    // Product Model
    private class PreviewProductModel {
        private Product2 record;
        private Id upgradedAssetId;
        private String currencySymbol;
        private String currencyCode;
        private String[] featureCategories;
        private PreviewOptionModel[] options;
        private PreviewFeatureModel[] features;
        private PreviewConfigurationModel configuration;
        private PreviewConfigAttributeModel[] configurationAttributes;
        private PreviewConfigAttributeModel[] inheritedConfigurationAttributes;
        private PreviewConstraintModel[] constraints;

    }

    // Feature Model
    private class PreviewFeatureModel {
        private SBQQ__ProductFeature__c record;
        private String instructionsText;
        private Boolean containsUpgrades;

    }

    // Option Model
    private class PreviewOptionModel {
        private SBQQ__ProductOption__c record;
        private Map<String,String> externalConfigurationData;
        private Boolean configurable;
        private Boolean configurationRequired;
        private Boolean quantityEditable;
        private Boolean priceEditable;
        private Decimal productQuantityScale;
        private Boolean priorOptionExists;
        private Set<Id> dependentIds;
        private Map<String,Set<Id>> controllingGroups;
        private Map<String,Set<Id>> exclusionGroups;
        private String reconfigureDimensionWarning;
        private Boolean hasDimension;
        private Boolean isUpgrade;
        private String dynamicOptionKey;

    }


    // Constraint Model
    private class PreviewConstraintModel {
        private SBQQ__OptionConstraint__c record;
        private Boolean priorOptionExists;

    }

    // Configuration Model
    private class PreviewConfigurationModel {
        private Id configuredProductId;
        private Id optionId;
        private SBQQ__ProductOption__c optionData; // Editable data about the option in question, such as quantity or discount
        private SBQQ__ProductOption__c configurationData;
        private SBQQ__ProductOption__c inheritedConfigurationData;
        private PreviewConfigurationModel[] optionConfigurations;
        private Boolean configured;
        private Boolean changedByProductActions;
        private Boolean isDynamicOption;
        private Boolean isUpgrade;
        private Set<Id> disabledOptionIds;
        private Set<Id> hiddenOptionIds;
        private Decimal listPrice;
        private Boolean priceEditable;
        private String[] validationMessages;
        private String dynamicOptionKey;

    }

    // Configuration Attribute Model
    private class PreviewConfigAttributeModel {
        private String name;
        private String targetFieldName;
        private Decimal displayOrder;
        private String colmnOrder;
        private Boolean required;
        private Id featureId;
        private String position;
        private Boolean appliedImmediately;
        private Boolean applyToProductOptions;
        private Boolean autoSelect;
        private String[] shownValues;
        private String[] hiddenValues;
        private Boolean hidden;
        private String noSuchFieldName;
        private Id myId;

    }
}