public class Q2CUsageUploader {

/**
* Create a new Usage Record
*
*/
    @AuraEnabled
    public static void createRecord(blng__Usage__c usageRecord) {

        try {
            System.debug('CreateCandidateRecord::createRecord::usageRecord' + usageRecord);

            if (usageRecord != null) {
                insert usageRecord;
            }
        } catch (Exception ex) {
        }
    }
    
/**
* Pull up all related product orders for picklist
*
*/
	@AuraEnabled
    public static Order fetchRelatedOrderItems(String orderId) {
        return [SELECT Id, (SELECT Id, OrderItemNumber , Order.Account.Name, Order.Account.AccountNumber, Product2Id, Product2.Name FROM OrderItems WHERE SBQQ__ChargeType__c = 'Usage') FROM Order WHERE Id = :orderId];
    }
}