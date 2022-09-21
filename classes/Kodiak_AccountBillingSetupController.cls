public with sharing class Kodiak_AccountBillingSetupController { 

    @AuraEnabled
    public static Boolean showAlert(Id recordId){
        Account thisAccount = [SELECT 
                                    Id,
                                    Accounting_Finance_Book__c,
                                    Legal_Entity__c,
                                    blng__BillToContact__c
                                FROM Account
                                WHERE Id = :recordId];
        if(thisAccount.Accounting_Finance_Book__c == null || thisAccount.Legal_Entity__c == null || thisAccount.blng__BillToContact__c == null) {
            System.debug('Missing Account Finance Book, Legal Entity, or Bill To Contact');
            return true;
        }
        System.debug('Account has Finance Book, Legal Entity, and Bill To Contact');
        return false;
    }

    @AuraEnabled
    public static Account getAccountDetails(Id recordId){
        system.debug('Alex Account Record ID:' + recordId);
        Account thisAccount = [SELECT 
                                    Id,
                                    Accounting_Finance_Book__c,
                                    Accounting_Finance_Book__r.Name,
                                    Legal_Entity__c,
                                    Legal_Entity__r.Name,
                                    blng__BillToContact__c,
                                    blng__BillToContact__r.Name
                                FROM Account
                                WHERE Id = :recordId];
                                return thisAccount;
    }

    @AuraEnabled
    public static List<blng__LegalEntity__c> getLegalEntities(){
        return [SELECT 
                    Id,
                    Name,
                    blng__Active__c
                FROM blng__LegalEntity__c
                WHERE blng__Active__c = true];
    }

    @AuraEnabled
    public static List<blng__FinanceBook__c> getFinanceBooks(){
        return [SELECT 
                    Id,
                    Name,
                    blng__Active__c,
                    blng__PeriodType__c
                FROM blng__FinanceBook__c
                WHERE blng__Active__c = true
                AND blng__PeriodType__c = 'Accounting'];
    }

    @AuraEnabled
    public static List<Contact> getBillToContacts(Id recordId){
        System.debug('getBillToContacts: recordId = ' + recordId);
        return [SELECT 
                    Id, 
                    AccountId,
                    Name
                FROM Contact
                WHERE AccountId = :recordId]; // hardcoded for now...WHERE AccountId = '0013c00001rTZQ8AAO'
    }

    @AuraEnabled
    public static void saveAccountBilling(Id recordId, Id legalEntityId, Id financeBookId, Id billToContactId){
        Account thisAccount = [SELECT 
                                    Id,
                                    Accounting_Finance_Book__c,
                                    Legal_Entity__c,
                                    blng__BillToContact__c
                                FROM Account
                                WHERE Id = :recordId];

        if(legalEntityId != null) {
            thisAccount.Legal_Entity__c = legalEntityId;
        }

        if(financeBookId != null) {
            thisAccount.Accounting_Finance_Book__c = financeBookId;
        }

        if(billToContactId != null) {
            thisAccount.blng__BillToContact__c = billToContactId;
        }

        try {
            Database.update(thisAccount);
        } catch (DmlException e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}