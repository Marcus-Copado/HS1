trigger InvoiceTriggerGenBilling on blng__Invoice__c(after insert,after update) {if(Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate))dfsle.GenInvoiceTriggerHandler.onAfterUpdate(trigger.newMap, trigger.oldMap);}