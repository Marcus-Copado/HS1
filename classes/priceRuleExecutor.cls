global class priceRuleExecutor implements Database.Batchable<SObject> {

    global final Set<String> quIds;
    global String qlQuery;

    global priceRuleExecutor(Set<String> quoteIdSet) {
        quIds = quoteIdSet;
        qlQuery = 'SELECT id FROM SBQQ__Quote__c WHERE id IN: quIds';
    }

    global Database.QueryLocator start(Database.BatchableContext info) {
        return Database.getQueryLocator(qlQuery);
    }

    global void execute(Database.BatchableContext info, List<SBQQ__Quote__c> scope) {
        List<SBQQ__Quote__c> qsToUpdate = new List<SBQQ__Quote__c>();
        for (SBQQ__Quote__c s : scope) {
            s.SBQQ__Primary__c = true;
            qsToUpdate.add(s);
        }
        try {
            update qsToUpdate;
        } catch (Exception e) {
            System.debug('ERROR Price Rule Trigger Failed. Exception: ' + e);
        }
    }

    global void finish(Database.BatchableContext info) {
        System.debug('priceRuleExecutor Finished');
    }
}