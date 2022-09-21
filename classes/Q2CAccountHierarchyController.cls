public with sharing class Q2CAccountHierarchyController {
    public Account acc { get; private set; }
    public List<Account> accountList { get; private set; }
    public ApexPages.StandardController controller { get; private set; }
    public Q2CAccountHierarchyController(ApexPages.StandardController controller) {
        this.acc = (Account)controller.getRecord();
        this.accountList = new List<Account>();
        
        Id TopParent=GetTopLevleElement(acc.Id);
        
        Account baseAccount = [SELECT Id, 
                               ParentId, 
                               Name,
                               Parent.Name,
                                (SELECT Id, SBQQ__Product__c, SBQQ__Price__c, SBQQ__Discount__c FROM SBQQ__R00N70000001olI5EAI__r),
                               (SELECT Id, Name FROM ChildAccounts)
                               FROM Account 
                               WHERE Id = :TopParent];
        accountList.add(baseAccount);
        // Traverse the hierarchy downwards
        Set<Id> accountsToQuery = new Map<Id, Account>(baseAccount.ChildAccounts).keySet();
        while (accountsToQuery.size() > 0) {
            List<Account> thisLevelAccounts = [SELECT Id, Name, Parent.Name,
                                               (SELECT Id, SBQQ__Product__c, SBQQ__Price__c, SBQQ__Discount__c FROM SBQQ__R00N70000001olI5EAI__r),
                                               (SELECT Id, Name FROM ChildAccounts)
                                               FROM Account
                                               WHERE Id IN :accountsToQuery];
            accountsToQuery = new Set<Id>();
            for (Account a : thisLevelAccounts) {
                // Add this Account (with its Contacts) to the list.
                accountList.add(a);
                // Add this Account's children to the query for the next level.
                for (Account child : a.ChildAccounts) {
                    accountsToQuery.add(child.Id);
                }
            }
        }
    }
    public String GetTopLevleElement( String objId ){
        Boolean topLevelParent = false;
        while ( !topLevelParent ) {
            Account a = [ Select Id, ParentId From Account where Id =: objId limit 1 ];
            if ( a.ParentID != null ) {
                objId = a.ParentID;
            }
            else {
                topLevelParent = true;
            }
        }
        return objId ;
    }
}