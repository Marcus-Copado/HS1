public class QuickQuoteCTRL {
	
    @AuraEnabled // Annotation that makes the method available to Lightning Components
    
    public static Id createQuote(String StartDate, Integer SubscriptionTerm){
      
        Id p = [select Id from PriceBook2 limit 1].Id;
        
        SBQQ__Quote__c q = new SBQQ__Quote__c();
        q.SBQQ__ExpirationDate__c=system.today()+60;
        q.SBQQ__Type__c='Quote';
        q.SBQQ__Primary__c=true;
        q.SBQQ__SubscriptionTerm__c=SubscriptionTerm;
        q.SBQQ__StartDate__c=Date.parse(StartDate).addDays(1);//system.today()+31;
        q.SBQQ__Status__c='Draft';
        
        q.SBQQ__PricebookId__c =p;
        
        
		insert q;        
        return q.id;
        
    }
    
 
}