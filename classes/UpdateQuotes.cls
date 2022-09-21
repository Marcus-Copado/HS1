global class UpdateQuotes implements
                Database.Batchable<SObject>, Database.Stateful {

    // instance member to retain state across transactions
    global Integer recordsProcessed = 0;

    global Database.QueryLocator start(Database.BatchableContext bc) {
        SObjectType objToken = Schema.getGlobalDescribe().get('SBQQ__QuoteLine__c');
        DescribeSObjectResult objDef = objToken.getDescribe();
        Map<String, SObjectField> fields = objDef.fields.getMap();
        List<String> fieldslist = new List<String>();
        for (String s : fields.keySet()) {
            fieldslist.add(s);
        }
        String q = 'SELECT ' + String.join(fieldslist, ',') + ' FROM SBQQ__QuoteLine__c WHERE SBQQ__Quote__c=:quotetocopy';
        System.debug(q);

        return Database.getQueryLocator(
                q
        );
    }

    global void execute(Database.BatchableContext bc, List<Account> scope) {
        // process each batch of records
        List<Contact> contacts = new List<Contact>();
        for (Account account : scope) {
            for (Contact contact : account.Contacts) {
                contact.MailingStreet = account.BillingStreet;
                contact.MailingCity = account.BillingCity;
                contact.MailingState = account.BillingState;
                contact.MailingPostalCode = account.BillingPostalCode;
                // add contact to list to be updated
                contacts.add(contact);
                // increment the instance member counter
                recordsProcessed = recordsProcessed + 1;
            }
        }
        update contacts;
    }

    global void finish(Database.BatchableContext bc) {

    }
}