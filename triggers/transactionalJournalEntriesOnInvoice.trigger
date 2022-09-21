trigger transactionalJournalEntriesOnInvoice on blng__Invoice__c (after update) {
    for(blng__Invoice__c invoice:trigger.new){
        // system.debug('OLD:::::' + JSON.serializePretty(trigger.oldmap.get(invoice.Id)));
        // system.debug('NEW:::::' + JSON.serializePretty(trigger.newmap.get(invoice.Id)));
        
        blng__Invoice__c oldInv = Trigger.oldMap.get(invoice.Id);
        Boolean oldInvIsPosted = oldInv.blng__InvoiceStatus__c.equals('Posted');
        Boolean newInvIsPosted = invoice.blng__InvoiceStatus__c.equals('Posted');
        Boolean createTJEs = invoice.Generate_TJEs__c ;
        
        if(!oldInvIsPosted && newInvIsPosted && createTJEs){
            // System.debug('Matched Conditions');
            transactionJournalEntryCreation.CreateTransactionJournalEntries(invoice.Id);
        }
    }
}