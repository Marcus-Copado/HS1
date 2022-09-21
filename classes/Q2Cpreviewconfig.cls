public class Q2Cpreviewconfig {
    public Product2 Prod;
  
    public Q2Cpreviewconfig(ApexPages.StandardController controller) {
        Prod = (Product2) controller.getRecord();
        
    }

   public PageReference preview(){
        Id CustomAction = [SELECT Id FROM SBQQ__CustomAction__c WHERE SBQQ__Action__c = 'Add Products' LIMIT 1].Id;
        Opportunity opp = new Opportunity(CloseDate = Date.today(), StageName = 'Qualification', Name = 'Opportunity');
        Database.insert(opp);
        SBQQ__Quote__c q = new SBQQ__Quote__c(SBQQ__Opportunity2__c=Opp.Id, SBQQ__Primary__c = true, SBQQ__SubscriptionTerm__c = 12, SBQQ__Status__c = 'Draft', SBQQ__Type__c = 'Quote');
        insert q;
        return new PageReference('/apex/sbqq__sb?scontrolCaching=1&id=' + q.id + '&scontrolCaching=1#/product/pc?qId=' + q.Id + '&aId=' + CustomAction + '&pId=' + Prod.Id + '&redirectUrl=LineEditor&open=0');
    }
}