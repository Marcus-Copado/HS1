public class ProductSearcher {
    public List<PricebookEntry> orderedPBEs { get; set; }
    public Map<Id, Product2> productDetail { get; set; }

    private SBQQ__Quote__c quote { get; set; }
    private Map<String, Object> inFilters { get; set; }

    public ProductSearcher(SBQQ__Quote__c q, Map<String, Object> m) {
        this.quote = q;
        this.inFilters = m;
        this.executeLastOrderedSearch();
    }

    private void executeLastOrderedSearch() {

        Id accId = this.quote.SBQQ__Account__c;
        Id pbId = this.quote.SBQQ__PricebookId__c;

        //GRAB ALL POSSIBLE FILTER FIELDS FROM THE FIELD SET
        List<Schema.FieldSetMember> searchFilterFieldSetFields = SObjectType.Product2.fieldSets.SBQQ__SearchFilters.getFields();

        //GRAB ALL POSSIBLE RESULT FIELDS FROM THE FIELD SET
        List<Schema.FieldSetMember> searchResultFieldSetFields = SObjectType.Product2.fieldSets.SBQQ__SearchResults.getFields();

        //BUILD THE SELECT STRING
        String selectClause = 'SELECT ';

        for (Schema.FieldSetMember field : searchResultFieldSetFields) {
            selectClause += 'Product2.' + field.getFieldPath() + ', ';
        }
        selectClause += 'Id, UnitPrice, Pricebook2Id, Product2Id, Product2.Id';

        //START THE WHERE CLAUSE
        String whereClause = '';

        for (Schema.FieldSetMember field : searchFilterFieldSetFields) {
            if (!inFilters.containsKey(field.getFieldPath())) {
                continue;
            }

            if (field.getType() == Schema.DisplayType.STRING || field.getType() == Schema.DisplayType.PICKLIST) {
                whereClause += 'Product2.' + field.getFieldPath() + ' LIKE \'%' + inFilters.get(field.getFieldPath()) + '%\' AND ';
            }
        }

        whereClause += 'Pricebook2Id = \'' + pbId + '\'';

        //INITIALIZE THE RESULT LIST
        List<PricebookEntry> unsortedPbes = new List<PricebookEntry>();

        //BUILD THE QUERY
        String query = selectClause + ' FROM PricebookEntry WHERE ' + whereClause;

        //DO THE QUERY
        unsortedPbes = Database.query(query);

        //MAKE THE PRODUCT MAP
        Map<Id, Product2> prodMap = new Map<Id, Product2>();

        Set<Id> productIds = new Set<Id>();
        for (PricebookEntry pbe : unsortedPbes) {
            Product2 p = pbe.Product2;
            prodMap.put(p.Id, p);
            productIds.add(pbe.Product2.Id);
        }

        List<OrderItem> previousOrderItems = new List<OrderItem>();
        previousOrderItems = [SELECT Id, PricebookEntry.Product2.Id, ServiceDate FROM OrderItem WHERE PricebookEntry.Product2.Id IN :productIds AND Order.AccountId = :accId ORDER BY ServiceDate DESC];

        Map<Id, Date> productLastOrderedMap = new Map<Id, Date>();

        System.debug(previousOrderItems);

        for (OrderItem oi : previousOrderItems) {
            if (productLastOrderedMap.containsKey(oi.PricebookEntry.Product2Id)) {

                if (oi.ServiceDate > productLastOrderedMap.get(oi.PricebookEntry.Product2Id)) {
                    productLastOrderedMap.put(oi.PricebookEntry.Product2Id, oi.ServiceDate);
                }
            } else {
                productLastOrderedMap.put(oi.PricebookEntry.Product2Id, oi.ServiceDate);
            }
        }

        List<PricebookEntry> preOrderedPbes = new List<PricebookEntry>();
        List<PricebookEntry> unOrderedPbes = new List<PricebookEntry>();
        for (PricebookEntry pbe : unsortedPbes) {
            if (productLastOrderedMap.containsKey(pbe.Product2Id)) {
                Product2 prod = prodMap.get(pbe.Product2.Id);
                prod.Last_Ordered_Date__c = productLastOrderedMap.get(pbe.Product2Id);
                prodMap.put(prod.Id, prod);
                preOrderedPbes.add(pbe);
            } else {
                Product2 prod = prodMap.get(pbe.Product2.Id);
                prod.Last_Ordered_Date__c = null;
                unOrderedPbes.add(pbe);
            }
        }
        preOrderedPbes.addAll(unOrderedPbes);
        this.orderedPBEs = preOrderedPbes;
        this.productDetail = prodMap;
    }
}