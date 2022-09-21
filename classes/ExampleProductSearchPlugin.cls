/**
 * Implementation of Salesforce CPQ Product Search Plugin
 * Allows for more sophisticated Product Search (Search) or Guided Selling (Suggest)
 * 
 * There are 2 modes
 *
 * ENHANCED mode allows implementations to add additional search filters to the WHERE clause
 * of product search
 *
 * CUSTOM mode allows implementations to fully override the search and provide the result
 * list of a product search 
 *******************************************************************************
 * Salesforce CPQ will execute the implemented methods in this order for Search
 *******************************************************************************
 * 1.0 Constructor()
 * 2.0 FOREACH(Search Input Field){
 *      2.1 isFilterHidden()
 *      2.1 getFilterDefaultValue()
 * }
 * 3.0 isSearchCustom (CUSTOM vs ENHANCED)
 * IF(isCustom){
 *      4.0 search()
 * }
 * ELSE{
 *      4.0 FOREACH(Search Input Field){
 *          4.1 getAdditionalSearchFilters()
 *      }
 * }
 ***************************************************************************************
 * Salesforce CPQ will execute the implemented methods in this order for Guided Selling
 ***************************************************************************************
 * 1.0 Constructor()
 * 2.0 FOREACH(Guded Selling Input){
 *      2.1 isInputHidden()
 *      2.1 getInputDefaultValue()
 * }
 * 3.0 isSuggestCustom (CUSTOM vs ENHANCED)
 * IF(isCustom){
 *      4.0 suggest()
 * }
 * ELSE{
 *      4.0 FOREACH(Guided Selling Input){
 *          4.1 getAdditionalSuggestFilters()
 *      }
 * }
 *
 * @author  mseeger
 * @version v21.0.1
 * @since   v10.0
 */
global class ExampleProductSearchPlugin implements SBQQ.ProductSearchPlugin {

    /**
     * Constructor. Not required for implementation
     */
    global ExampleProductSearchPlugin() {
        System.debug('METHOD CALLED: ExampleProductSearchPlugin Constructor');
    }

    /** 
     * When Using Search, Determines the visibility of a Filter in the UI
     * salesforce CPQ will call this implemented method for each input field.
     *
     * @param   quote       Current Quote Object
     * @param   fieldName   API Name of the Product2 Field
     * @return  true if the field should be hidden in the UI, false otherwise
     */
    global Boolean isFilterHidden(SObject quote, String fieldName) {
        System.debug('METHOD CALLED: isFilterHidden');
        /*
        // This would hide Product Code filter if Quote Status is Approved
        return fieldName == 'ProductCode' && quote.SBQQ__Status__c. == 'Approved';
        */
        return false;
    }

    /** 
     * When Using Search, Determines the field value for the initial search
     * salesforce CPQ will call this implemented method for each input field.
     *
     * @param   quote       Current Quote Object
     * @param   fieldName   API Name of the Product2 Field
     * @return  Value to pass for this field in initial search. null if none.
     */
    global String getFilterDefaultValue(SObject quote, String fieldName) {
        System.debug('METHOD CALLED: getFilterDefaultValue');
        /*
        // This would set Product Family filter to Service if Quote Type is Quote
        return (fieldName == 'Family' && quote.SBQQ__Type__c. == 'Quote') ? 'Service' : NULL;
        */
        return null;
    }

    /** 
     * When Using Search, Determines if mode is CUSTOM or ENHANCED
     *
     * CUSTOM - Full control of Query
     * ENHANCED - Append additional criteria to WHERE clause
     *
     * @param   quote           Current Quote Object
     * @param   fieldValuesMap  Map of search criteria. Key is Product2 API Name. Value is Value
     * @return  true for CUSTOM mode. false for ENHANCED mode.
     */
    global Boolean isSearchCustom(SObject quote, Map<String, Object> fieldValuesMap) {
        System.debug('METHOD CALLED: isSearchCustom');
        /*
        // This would use CUSTOM mode if a Search filed for sorting was definied and used
        return fieldValuesMap.get('Sort_By__c') != '';
        */
        return true;
    }

    /** 
     * When Using Search in ENHANCED mode, appends additional WHERE clause text.
     * SOQL Query is FROM the Pricebook entry table
     *
     * @param   quote           Current Quote Object
     * @param   fieldValuesMap  Map of search criteria. Key is Product2 API Name. Value is Value
     * @return  String to be appended to WHERE Clause. null if none.
     */
    global String getAdditionalSearchFilters(SObject quote, Map<String, Object> fieldValuesMap) {
        System.debug('METHOD CALLED: getAdditionalSearchFilters');
        /*
        // This would add an additional inventory filter if the family is Hardware
        String additionalFilter = NULL;

        if(fieldValuesMap.get('Family') == 'Hardware'){
            additionalFilter = 'AND Product2.Inventory_Level__c > 3';
        }

        return additionalFilter;
        */
        return null;
    }

    /** 
     * When Using Search in CUSTOM mode, Over-Ride entire search
     * Product2 Fields in the Search Results Field Set should be Set.
     *
     * @param   quote           Current Quote Object
     * @param   fieldValuesMap  Map of search criteria. Key is Product2 API Name. Value is Value. 
     *                          Only Contains Keys for non-null Values
     * @return  List of Pricebook Entries with Product2 External lookup set
     */
    global List<PricebookEntry> search(SObject quote, Map<String, Object> fieldValuesMap) {
        System.debug('METHOD CALLED: search');
        //GET ALL POSSIBLE FILTER FIELDS FROM THE SEARCH FILTER FIELD SET
        List<Schema.FieldSetMember> searchFilterFieldSetFields = SObjectType.Product2.fieldSets.SBQQ__SearchFilters.getFields();

        //GET ALL POSSIBLE FIELDS FROM THE SEARCH RESULTS FIELD SET
        List<Schema.FieldSetMember> searchResultFieldSetFields = SObjectType.Product2.fieldSets.SBQQ__SearchResults.getFields();

        //BUILD THE SELECT STRING
        String selectClause = 'SELECT ';

        for (Schema.FieldSetMember field : searchResultFieldSetFields) {
            selectClause += 'Product2.' + field.getFieldPath() + ', ';
        }
        selectClause += 'Id, UnitPrice, Pricebook2Id, Product2Id, Product2.Id';

        //BUILD THE WHERE CLAUSE
        String whereClause = '';

        for (Schema.FieldSetMember field : searchFilterFieldSetFields) {
            if (!fieldValuesMap.containsKey(field.getFieldPath())) {
                continue;
            }

            if (field.getType() == Schema.DisplayType.STRING || field.getType() == Schema.DisplayType.PICKLIST) {
                whereClause += 'Product2.' + field.getFieldPath() + ' LIKE \'%' + fieldValuesMap.get(field.getFieldPath()) + '%\' AND ';
            }
        }

        whereClause += 'Pricebook2Id = \'' + quote.get('SBQQ__Pricebook__c') + '\'';

        //BUILD THE QUERY
        String query = selectClause + ' FROM PricebookEntry WHERE ' + whereClause;

        //DO THE QUERY
        List<PricebookEntry> pbes = new List<PricebookEntry>();
        pbes = Database.query(query);

        return pbes;
    }

    /** 
     * When Using Guided Selling, Determines the visibility of an Input in the UI
     * salesforce CPQ will call this implemented method for each 
     *
     * @param   quote       Current Quote Object
     * @param   input       Name of the Quote Process Input
     * @return  true if the field should be hidden in the UI, false otherwise
     */
    global Boolean isInputHidden(SObject quote, String input) {
        System.debug('METHOD CALLED: isInputHidden');
        /*
        // This would hide an Input called 'Urgent Shipment' on Fridays.
        return input == 'Urgent Shipment' && Datetime.now().format('F') == 5;
        */
        return false;
    }

    /** 
     * When Using Guided Selling, Determines the Input value for the initial search
     * salesforce CPQ will call this implemented method for each Quote Process Input.
     *
     * @param   quote       Current Quote Object
     * @param   input       Name of the Quote Process Input
     * @return  Value to pass for this field in initial search. null if none.
     */
    global String getInputDefaultValue(SObject quote, String input) {
        System.debug('METHOD CALLED: getInputDefaultValue');

        return null;
    }

    /** 
     * When Using Guided Selling, Determines if mode is CUSTOM or ENHANCED
     *
     * CUSTOM - Full control of Query
     * ENHANCED - Append additional criteria to WHERE clause
     *
     * @param   quote           Current Quote Object
     * @param   inputValuesMap  Map of search criteria. Key is Process Input Name. Value is Value. 
     *                          Only Contains Keys for !null Values
     *                          Includes additional key, 'qpid' for the Quote Process ID
     * @return  true for CUSTOM mode. false for ENHANCED mode.
     */
    global Boolean isSuggestCustom(SObject quote, Map<String, Object> inputValuesMap) {
        System.debug('METHOD CALLED: isSuggestCustom');
        return true;
    }

    /** 
     * When Using Guided Selling in ENHANCED mode, appends additional WHERE clause text.
     * SOQL Query is FROM the Pricebook entry table
     *
     * @param   quote           Current Quote Object
     * @param   inputValuesMap  Map of search criteria. Key is Process Input Name. Value is Value. 
     *                          Only Contains Keys for !null Values
     *                          Includes additional key, 'qpid' for the Quote Process ID
     * @return  String to be appended to WHERE Clause. null if none.
     */
    global String getAdditionalSuggestFilters(SObject quote, Map<String, Object> inputValuesMap) {
        System.debug('METHOD CALLED: getAdditionalSuggestFilters');
        /*
        // This would add an inventory check if a Input for Urgent Shipment was Yes
        String additionalFilter = NULL;
        String isUrgent = 'No'
        if(inputValuesMap.containsKey('Urgent Shipment')){
            isUrgent = (String) inputValuesMap.get('Urgent Shipment');
        }
        if(isUrgent == 'Yes'){
            additionalFilter = 'AND Product2.Inventory_Level__c > 3';
        }
        return additionalFilter;
        */
        return null;
    }

    /** 
     * When Using Guided Selling in CUSTOM mode, Over-Ride entire search
     * Product2 Fields in the Search Results Field Set should be Set.
     *
     * @param   quote           Current Quote Object
     * @param   inputValuesMap  Map of search criteria. Key is Process Input Name. Value is Value. 
     *                          Only Contains Keys for !null Values
     *                          Includes additional key, 'qpid' for the Quote Process ID
     * @return  List of Pricebook Entries with Product2 External lookup set
     */
    global List<PricebookEntry> suggest(SObject quote, Map<String, Object> inputValuesMap) {
        System.debug('METHOD CALLED: suggest');
        //GET ALL POSSIBLE FIELDS FROM THE SEARCH RESULTS FIELD SET
        List<Schema.FieldSetMember> searchResultFieldSetFields = SObjectType.Product2.fieldSets.SBQQ__SearchResults.getFields();

        //BUILD THE SELECT STRING
        String selectClause = 'SELECT ';

        for (Schema.FieldSetMember field : searchResultFieldSetFields) {
            selectClause += 'Product2.' + field.getFieldPath() + ', ';
        }
        selectClause += 'Id, UnitPrice, Pricebook2Id, Product2Id, Product2.Id';

        //BUILD THE WHERE CLAUSE
        String whereClause = '';

        whereClause += 'Pricebook2Id = \'' + quote.get('SBQQ__Pricebook__c') + '\'';

        //BUILD THE QUERY
        String query = selectClause + ' FROM PricebookEntry WHERE ' + whereClause;

        //DO THE QUERY
        List<PricebookEntry> pbes = new List<PricebookEntry>();
        pbes = Database.query(query);

        return pbes;
    }
}