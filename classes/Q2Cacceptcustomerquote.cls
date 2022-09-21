public class Q2Cacceptcustomerquote {

    //Public String Name  {get;set;}
// This is an Extension Controller. Thus, we must invoke the standard controller.
    public Q2Cacceptcustomerquote(ApexPages.StandardController controller) {
    }

// Method for creating Quote 
    public PageReference genOpp() {
        SBQQ__Quote__c Quote = [SELECT Id FROM SBQQ__Quote__c WHERE Id =:ApexPages.currentPage().getParameters().get('id')];
    
        String Name = [SELECT SBQQ__Account__r.name FROM SBQQ__Quote__c WHERE Id =:ApexPages.currentPage().getParameters().get('id')].SBQQ__Account__r.name;
        Id Acct = [SELECT SBQQ__Account__c FROM SBQQ__Quote__c WHERE Id =:ApexPages.currentPage().getParameters().get('id')].SBQQ__Account__c;
    
       Opportunity NewOpp = New Opportunity(Name = 'Customer Self Service Quote for ' + Name ,StageName='Qualification', CloseDate = Date.Today(), AccountId=Acct);
       insert NewOpp;
       Quote.SBQQ__Opportunity2__c = NewOpp.Id;
       Quote.SBQQ__Primary__c= True;
       update Quote;
    return new PageReference('/'+NewOpp.Id);
}
}