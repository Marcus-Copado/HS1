public class SetInvoiceBatch2 {
  @InvocableMethod(label='SetInvoiceBatch Invoice Scheduler' description='SetInvoiceBatch INV')
  public static List<blng__InvoiceScheduler__c> SetInvoiceBatchNow(List<ID> ids) {
    List<blng__InvoiceScheduler__c> ords = [SELECT Id,blng__InvoiceBatches__c FROM blng__InvoiceScheduler__c WHERE Id in :ids];
    Schema.DescribeFieldResult F = Order.blng__InvoiceBatch__c.getDescribe();
    Schema.sObjectField T = F.getSObjectField();
    List<PicklistEntry> picklistentries = T.getDescribe().getPicklistValues();
    List<String> entries = new List<String>();
    
    for(PicklistEntry PLE : picklistentries){
    
        entries.add(PLE.getValue());
    
    }
    
    String Batch = 'Batch 6';
    String Alias = [Select Id, Alias from User WHERE Id = :Userinfo.getUserId()].Alias;

    if(entries.contains(Alias)){
      Batch = Alias;
    }
    for (blng__InvoiceScheduler__c ord : ords) {
        ord.blng__InvoiceBatches__c = Batch;
    }
    update Ords;
    return ords;
  }
}