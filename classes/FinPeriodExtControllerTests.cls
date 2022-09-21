@isTest
private class FinPeriodExtControllerTests {
    
    testMethod static void testSubmit() {
        blng__FinancePeriod__c finPer = new blng__FinancePeriod__c();
        insert finPer;
        
        Test.startTest();
        FinPeriodExtController con = new FinPeriodExtController(new ApexPages.StandardController(finPer));
        con.onSubmit();
        finPer = [SELECT ApprovalStatus__c FROM blng__FinancePeriod__c WHERE Id = :finPer.Id LIMIT 1];
        Test.stopTest();
        
        System.assertEquals('Approved', finPer.ApprovalStatus__c);
    }
    
    testMethod static void testRecall() {
        blng__FinancePeriod__c finPer = new blng__FinancePeriod__c();
        insert finPer;
        
        Test.startTest();
        FinPeriodExtController con = new FinPeriodExtController(new ApexPages.StandardController(finPer));
        con.onRecall();
        finPer = [SELECT ApprovalStatus__c FROM blng__FinancePeriod__c WHERE Id = :finPer.Id LIMIT 1];
        Test.stopTest();
        
        System.assertEquals('Recalled', finPer.ApprovalStatus__c);
    }
}