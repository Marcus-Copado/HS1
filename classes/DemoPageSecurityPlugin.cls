global class DemoPageSecurityPlugin implements SBQQ.PageSecurityPlugin, SBQQ.PageSecurityPlugin2 {
    private Boolean isCostUser { get; set; }

    global DemoPageSecurityPlugin() {
        User currentUser = [SELECT Id, All_Costs_Visible__c FROM User WHERE Id = :UserInfo.getUserId() LIMIT 1];
        this.isCostUser = currentUser.All_Costs_Visible__c;

    }

    global Boolean isFieldEditable(String page, Schema.SObjectField field) {
        System.debug('***METHOD CALLED: isFieldEditable(String, Field');
        System.debug('***STRING PASSED: ' + page);
        System.debug('***FIELD PASSED: ' + String.valueOf(field));
        return null;
    }

    global Boolean isFieldEditable(String page, Schema.SObjectField field, SObject obj) {
        System.debug('***METHOD CALLED: isFieldEditable(String, Field, Object');
        System.debug('***STRING PASSED: ' + page);
        System.debug('***FIELD PASSED: ' + String.valueOf(field));
        System.debug('***OBJECT PASSED: ' + String.valueOf(obj));
        return null;
    }

    global Boolean isFieldVisible(String page, Schema.SObjectField field) {
        System.debug('***METHOD CALLED: isFieldVisible(String, Field');
        System.debug('***STRING PASSED: ' + page);
        System.debug('***FIELD PASSED: ' + String.valueOf(field));
        return null;
    }

    global Boolean isFieldVisible(String page, Schema.SObjectField field, SObject obj) {
        System.debug('***METHOD CALLED: isFieldVisible(String, Field, Object');
        System.debug('***STRING PASSED: ' + page);
        System.debug('***FIELD PASSED: ' + String.valueOf(field));
        System.debug('***OBJECT PASSED: ' + String.valueOf(obj));
        if (field == SBQQ__QuoteLine__c.SBQQ__UnitCost__c) {
            SBQQ__QuoteLine__c line = (SBQQ__QuoteLine__c) obj;
            Boolean isCostHidden = line.Cost_Hidden__c;
            return (this.isCostUser || !isCostHidden);
        }

        return null;
    }
}