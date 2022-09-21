/**
 * Created by scheck on 12/18/18.
 */

public with sharing class QTC_CancelContractCTRL {
    public Id conId { get; set; }
    public List<SBQQ__Subscription__c> contractSubscriptions {get;set;}
    public Contract cancellationContract {get; set;}
    private ApexPages.StandardController controller;

    public QTC_CancelContractCTRL(ApexPages.StandardController stdController) {
        this.conId = stdController.getId();
        this.controller = stdController;
        this.contractSubscriptions = new List<SBQQ__Subscription__c>([
                SELECT
                        Id,
                        Name,
                        SBQQ__Account__c,
                        SBQQ__AdditionalDiscountAmount__c,
                        SBQQ__BillingFrequency__c,
                        SBQQ__BillingType__c,
                        SBQQ__Bundle__c,
                        SBQQ__Bundled__c,
                        SBQQ__BundledQuantity__c,
                        SBQQ__ChargeType__c,
                        SBQQ__ComponentDiscountedByPackage__c,
                        SBQQ__ComponentSubscriptionScope__c,
                        SBQQ__Contract__c,
                        SBQQ__ContractNumber__c,
                        SBQQ__CreditProductId__c,
                        SBQQ__CustomerPrice__c,
                        SBQQ__Dimension__c,
                        SBQQ__DimensionType__c,
                        SBQQ__Discount__c,
                        SBQQ__DiscountSchedule__c,
                        SBQQ__DiscountScheduleType__c,
                        SBQQ__DistributorDiscount__c,
                        SBQQ__DynamicOptionId__c,
                        SBQQ__EndDate__c,
                        SBQQ__ListPrice__c,
                        SBQQ__MarkupAmount__c,
                        SBQQ__MarkupRate__c,
                        SBQQ__NetPrice__c,
                        SBQQ__Number__c,
                        SBQQ__OptionDiscount__c,
                        SBQQ__OptionDiscountAmount__c,
                        SBQQ__OptionLevel__c,
                        SBQQ__OptionType__c,
                        SBQQ__OrderProduct__c,
                        SBQQ__OriginalQuoteLine__c,
                        SBQQ__OriginalUnitCost__c,
                        SBQQ__PartnerDiscount__c,
                        SBQQ__PricingMethod__c,
                        SBQQ__Product__c,
                        SBQQ__ProductId__c,
                        SBQQ__ProductName__c,
                        SBQQ__ProductOption__c,
                        SBQQ__ProrateMultiplier__c,
                        SBQQ__Quantity__c,
                        SBQQ__QuoteLine__c,
                        SBQQ__RegularPrice__c,
                        SBQQ__RenewalPrice__c,
                        SBQQ__RenewalProductId__c,
                        SBQQ__RenewalProductOptionId__c,
                        SBQQ__RenewalProductOptionProductId__c,
                        SBQQ__RenewalProductOptionSubscriptionPricing__c,
                        SBQQ__RenewalQuantity__c,
                        SBQQ__RenewalUpliftRate__c,
                        SBQQ__RenewedDate__c,
                        SBQQ__RequiredById__c,
                        SBQQ__RequiredByProduct__c,
                        SBQQ__RevisedSubscription__c,
                        SBQQ__RootId__c,
                        SBQQ__SegmentEndDate__c,
                        SBQQ__SegmentIndex__c,
                        SBQQ__SegmentKey__c,
                        SBQQ__SegmentLabel__c,
                        SBQQ__SegmentQuantity__c,
                        SBQQ__SegmentStartDate__c,
                        SBQQ__SegmentUplift__c,
                        SBQQ__SegmentUpliftAmount__c,
                        SBQQ__SpecialPrice__c,
                        SBQQ__StartDate__c,
                        SBQQ__SubscriptionEndDate__c,
                        SBQQ__SubscriptionStartDate__c,
                        SBQQ__TermDiscountSchedule__c,
                        SBQQ__TerminatedDate__c,
                        SBQQ__UnitCost__c
                FROM SBQQ__Subscription__c
                WHERE SBQQ__Contract__c =: conId]);

        this.cancellationContract = [
                SELECT
                        AccountId,
                        ActivatedById,
                        ActivatedDate,
                        BillingAddress,
                        BillingCity,
                        BillingCountry,
                        BillingGeocodeAccuracy,
                        BillingLatitude,
                        BillingLongitude,
                        BillingPostalCode,
                        BillingState,
                        BillingStreet,
                        CompanySignedDate,
                        CompanySignedId,
                        ContractNumber,
                        ContractTerm,
                        CreatedById,
                        CreatedDate,
                        CurrencyIsoCode,
                        CustomerSignedDate,
                        CustomerSignedId,
                        CustomerSignedTitle,
                        Description,
                        EndDate,
                        Id,
                        Name,
                        SBQQ__Quote__r.SBQQ__Account__r.Name,
                        ShippingAddress,
                        ShippingCity,
                        ShippingCountry,
                        ShippingGeocodeAccuracy,
                        ShippingLatitude,
                        ShippingLongitude,
                        ShippingPostalCode,
                        ShippingState,
                        ShippingStreet,
                        SpecialTerms,
                        StartDate,
                        Status
                FROM Contract
                WHERE Id =: conId];

    }

    public PageReference returnToContract(){
        return new PageReference('/' + conId);
    }

    public PageReference cancelContract(){
        Id quoteId = fireCancel(conId);
        SBQQ__Quote__c cancelQuote = [SELECT Id, SBQQ__Opportunity2__c, SBQQ__PriceBook__c FROM SBQQ__Quote__c WHERE Id =: quoteId];
        Opportunity cancelOpp = [SELECT Name, Id, Pricebook2Id FROM Opportunity WHERE Id =:cancelQuote.SBQQ__Opportunity2__c];
        String oppName = cancelOpp.Name;
        cancelOpp.Name = oppName.replace('Amendment', 'Cancellation');
        cancelOpp.Pricebook2Id = cancelQuote.SBQQ__PriceBook__c;
        try {
            Database.update(cancelOpp);
            System.debug('Opp updated');
        } catch (DmlException e) {
            System.debug('Error updating Opp: ' + e);
        }
        // '/apex/sbqq__sb?scontrolCaching=1&id='
        //return new PageReference('/apex/sbqq__sb?scontrolCaching=1&id=' + quoteId);
        return new PageReference('/' + cancelOpp.Id);
    }

    @AuraEnabled
    public static Id fireCancel(String contractId) {
        System.debug('inside fireCancel');

        QTC_CancelContractCTRL.QuoteModel amendModel = createAmendment(contractId);
        Id amendmentId = amendModel.record.Id;
        List<SBQQ__QuoteLine__c> updateLines = zeroQuoteLines(amendmentId);

        try {
            Database.update(updateLines);
            System.debug('Zeroed out QuoteLines and updated');
        } catch (DmlException e) {
            System.debug('Error zeroing out QuoteLines: ' + e);
        }

        // read in and get a new Quote Model

        QuoteReader reader = new QuoteReader();
        QTC_CancelContractCTRL.QuoteModel quoteModel = reader.read(amendmentId);

        // calculation of new Quote
        QuoteCalculator calculator = new QuoteCalculator();
        calculator.calculate(quoteModel, 'QTC_CancelContractCallback');

        return amendmentId;
    }


    private static QTC_CancelContractCTRL.QuoteModel createAmendment(String contractId) {

        System.debug('Creating Amendment for: ' + contractId);
        String quoteModelJSON = SBQQ.ServiceRouter.load('SBQQ.ContractManipulationAPI.ContractAmender', contractId, null);
        QTC_CancelContractCTRL.QuoteModel qModel = (QTC_CancelContractCTRL.QuoteModel)JSON.deserialize(quoteModelJSON, QTC_CancelContractCTRL.QuoteModel.class);
        System.debug('--- Quote Model from Amendment ---');
        //System.debug(JSON.serializePretty(qModel));

        return qModel;
    }

    // Method to zero out any quote lines
    private static List<SBQQ__QuoteLine__c> zeroQuoteLines(String qId) {

        List<SBQQ__QuoteLine__c> qLines = [SELECT
                Id,
                SBQQ__Quote__c,
                SBQQ__Quantity__c,
                SBQQ__Product__c,
                SBQQ__AllowAssetRefund__c,
                SBQQ__SubscriptionPricing__c,
                SBQQ__Product__r.SBQQ__AssetAmendmentBehavior__c,
                SBQQ__Product__r.SBQQ__SubscriptionPricing__c,
                SBQQ__Product__r.Name
        FROM SBQQ__QuoteLine__c
        WHERE SBQQ__Quote__c =: qId];

        System.debug('--- Total number of QuoteLines ---');
        System.debug(qLines.size());

        List<SBQQ__QuoteLine__c> zeroLines = new List<SBQQ__QuoteLine__c>();
        for (SBQQ__QuoteLine__c qLine : qLines){
            System.debug('Product: ' + qLine.SBQQ__Product__r.Name);
            System.debug('Qty: ' + qLine.SBQQ__Quantity__c);
            // Only zero out lines that we can refund. Relevant for POT with subscribed assets
            if(qLine.SBQQ__AllowAssetRefund__c == true) {
                System.debug('-----------------');
                System.debug('Allow Asset Refund: ' + qLine.SBQQ__Product__r.Name);
                qLine.SBQQ__Quantity__c = 0;
                zeroLines.add(qLine);
            }
            // Check if subscription pricing is filled out. (Confirms it is a subscription)
            if(qLine.SBQQ__SubscriptionPricing__c != null){
                System.debug('**********************');
                System.debug('Subscription Refund: ' + qLine.SBQQ__Product__r.Name);
                qLine.SBQQ__Quantity__c = 0;
                zeroLines.add(qLine);
            }
        }

        System.debug('--- Lines to update ---');
        System.debug('Number of Lines: ' + zeroLines.size());
        //System.debug(JSON.serializePretty(zeroLines));

        return zeroLines;

    }


    // Private QuoteLineGroup Model
    private class QuoteLineGroupModel {
        public SBQQ__QuoteLineGroup__c record;
        public Decimal netNonSegmentTotal;
        public Integer key;
    }


    // Private QuoteLineModel
    private class QuoteLineModel {
        public SBQQ__QuoteLine__c record;
        public Boolean amountDiscountProrated;
        public Integer parentGroupKey;
        public Integer parentItemKey;
        public Integer key;
        public Boolean upliftable;
        public String configurationType;
        public String configurationEvent;
        public Boolean reconfigurationDisabled;
        public Boolean descriptionLocked;
        public Boolean productQuantityEditable;
        public Decimal productQuantityScale;
        public String dimensionType;
        public Boolean productHasDimensions;
        public Decimal targetCustomerAmount;
        public Decimal targetCustomerTotal;
    }


    // Private QuoteModel
    private class QuoteModel {
        public SBQQ__Quote__c record;
        public QuoteLineModel[] lineItems;
        public QuoteLineGroupModel[] lineItemGroups;
        public Integer nextKey;
        public Boolean applyAdditionalDiscountLast;
        public Boolean applyPartnerDiscountFirst;
        public Boolean channelDiscountsOffList;
        public Decimal customerTotal;
        public Decimal netTotal;
        public Decimal netNonSegmentTotal;
    }

    public with sharing class QuoteCalculator {
        public void calculate(QuoteModel quote, String callbackClass) {
            QuoteCalculatorContext ctx = new QuoteCalculatorContext(quote, callbackClass);
            SBQQ.ServiceRouter.load('SBQQ.QuoteAPI.QuoteCalculator', null, JSON.serialize(ctx));
        }
    }

    public class QuoteCalculatorContext {
        private QuoteModel quote;
        private String callbackClass;
        private QuoteCalculatorContext(QuoteModel quote, String callbackClass) {
            this.quote = quote;
            this.callbackClass = callbackClass;
        }
    }

    // CPQ API QuoteSaver
    public with sharing class QuoteSaver {
        public QuoteModel save(QuoteModel quote) {
            String quoteJSON = SBQQ.ServiceRouter.save('SBQQ.QuoteAPI.QuoteSaver',
                    JSON.serialize(quote));
            return (QuoteModel) JSON.deserialize(quoteJSON, QuoteModel.class);
        }
    }

    // CPQ API Quote Reader
    public with sharing class QuoteReader {
        public QTC_CancelContractCTRL.QuoteModel read(String quoteId) {
            String quoteJSON = SBQQ.ServiceRouter.read('SBQQ.QuoteAPI.QuoteReader', quoteId);
            return (QTC_CancelContractCTRL.QuoteModel) JSON.deserialize(quoteJSON, QTC_CancelContractCTRL.QuoteModel.class);
        }
    }
}