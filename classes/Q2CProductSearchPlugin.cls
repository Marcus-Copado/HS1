global class Q2CProductSearchPlugin implements SBQQ.ProductSearchPlugin {
    public String type1 { get; set; }

    global Q2CProductSearchPlugin() {
        System.debug('METHOD CALLED: customSearchFilter Constructor');
    }

    global String getAdditionalSearchFilters(SObject so, Map<String, Object> ma) {
        System.debug('METHOD CALLED: getAdditionalSearchFilters');
        //System.debug('Sobject Passed: ' + so.getSObjectType().getDescribe().getName());
        System.debug('Map Passed:');
        System.debug(ma);
        return null;
    }

    global String getAdditionalSuggestFilters(SObject so, Map<String, Object> ma) {
        System.debug('METHOD CALLED: getAdditionalSuggestFilters');
        //System.debug('Sobject Passed: ' + so.getSObjectType().getDescribe().getName());
        System.debug('Map Passed:');
        System.debug(ma);
        return null;
    }

    global String getFilterDefaultValue(SObject so, String st) {
        System.debug('METHOD CALLED: getFilterDefaultValue');
        //System.debug('Sobject Passed: ' + so.getSObjectType().getDescribe().getName());
        System.debug('String Passed: ' + st);
        return st == 'Name' ? 'Hello' : null;
    }

    global String getInputDefaultValue(SObject so, String st) {
        System.debug('METHOD CALLED: getInputDefaultValue');
        //System.debug('Sobject Passed: ' + so.getSObjectType().getDescribe().getName());
        System.debug('String Passed: ' + st);
        return null;
    }

    global Boolean isFilterHidden(SObject so, String st) {
        System.debug('METHOD CALLED: isFilterHidden');
        //System.debug('Sobject Passed: ' + so.getSObjectType().getDescribe().getName());
        System.debug('String Passed: ' + st);
        return false;
    }

    global Boolean isInputHidden(SObject so, String st) {
        System.debug('METHOD CALLED: isInputHidden');
        //System.debug('Sobject Passed: ' + so.getSObjectType().getDescribe().getName());
        System.debug('String Passed: ' + st);
        return false;
    }

    global Boolean isSearchCustom(SObject so, Map<String, Object> ma) {
        System.debug('METHOD CALLED: isSearchCustom');
        //System.debug('Sobject Passed: ' + so.getSObjectType().getDescribe().getName());
        System.debug(ma);
        type1 = 'Search';
        return true;
    }

    global Boolean isSuggestCustom(SObject so, Map<String, Object> ma) {
        System.debug('METHOD CALLED: isSuggestCustom');
        //System.debug('Sobject Passed: ' + so.getSObjectType().getDescribe().getName());
        System.debug(ma);
        type1 = 'Guided Selling';
        return true;
    }

    global List<PricebookEntry> search(SObject quote, Map<String, Object> ma) {
        System.debug('YOU ARE DOING: ' + type1);
        System.debug('METHOD CALLED: search');
        System.debug('Sobject Passed: ' + quote.getSObjectType().getDescribe().getName());
        System.debug('Map Passed:');
        System.debug(ma);
        ProductSearcher searcher = new ProductSearcher((SBQQ__Quote__c) quote, ma);

        List<PricebookEntry> pbes = new List<PricebookEntry>();
        for (PricebookEntry pbe : searcher.orderedPBEs) {
            Product2 prod = searcher.productDetail.get(pbe.Product2Id);
            pbe.getSObject('Product2');
            pbe.Product2 = prod;
            pbe.UnitPrice = 1234.56;
            pbes.add(pbe);

        }

        return pbes;
    }

    global List<PricebookEntry> suggest(SObject so, Map<String, Object> ma) {
        System.debug('YOU ARE DOING: ' + type1);
        System.debug('METHOD CALLED: suggest');
        //System.debug('Sobject Passed: ' + so.getSObjectType().getDescribe().getName());
        System.debug(ma);

        List<PricebookEntry> pbes = [SELECT Id, PricebookEntry.Product2Id FROM PricebookEntry LIMIT 1];
        return pbes;
    }
}