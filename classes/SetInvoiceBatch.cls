public class SetInvoiceBatch {
  @InvocableMethod(label='SetInvoiceBatch Order' description='SetInvoiceBatch')
  public static List<Order> SetInvoiceBatchNow(List<ID> ids) {
    List<Order> ords = [SELECT Id,blng__InvoiceBatch__c FROM Order WHERE Id in :ids];
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
    for (Order ord : ords) {
        ord.blng__InvoiceBatch__c = Batch;
    }
    update Ords;
    return ords;
  }
}