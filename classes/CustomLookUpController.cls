public class CustomLookUpController {
    @AuraEnabled
    public static List < sObject > fetchLookUpValues(String searchKeyWord, String ObjectName) {
        system.debug('ObjectName-->' + ObjectName);
        String searchKey = searchKeyWord + '%';
        
        List < sObject > returnList = new List < sObject > ();
      
        // Create a Dynamic SOQL Query For Fetch Record List with LIMIT 5  
        String sQuery; 
        if(ObjectName == 'product2') {
            sQuery =  'select id, Name, ProductCode, SBQQ__ChargeType__c, SBQQ__BillingFrequency__c, SBQQ__BillingType__c, Standard_Pricebook_Price__c, SBQQ__SubscriptionTerm__c from ' + ObjectName + ' where Name LIKE: searchKey order by createdDate DESC limit 5';
        } else{
            sQuery =  'select id, Name from ' +ObjectName + ' where Name LIKE: searchKey order by createdDate DESC limit 5';    
        }
        List < sObject > lstOfRecords = Database.query(sQuery);
        
        for (sObject obj: lstOfRecords) {
            returnList.add(obj);
        }
        return returnList;
    } 
}