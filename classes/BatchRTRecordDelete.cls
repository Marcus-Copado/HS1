global class BatchRTRecordDelete implements Database.Batchable<sObject> {
	global Integer recordsProcessed = 0;
        
	global Database.QueryLocator start(Database.BatchableContext bc) {
		return Database.getQueryLocator(
			'SELECT Id FROM blng__RevenueTransaction__c'
        );
    }
    global void execute(Database.BatchableContext bc, List<blng__RevenueTransaction__c> records){
        CPQB_RecordReset.disableBillingTriggers(true);
        recordsProcessed = records.size();
        delete records;
        CPQB_RecordReset.disableBillingTriggers(false);
    }    
    global void finish(Database.BatchableContext bc){
   		System.debug(recordsProcessed + ' RT records deleted. Shazam!');
    }    
}