public with sharing class FinPeriodExtController {
    private Id finPerId;
    public FinPeriodExtController(ApexPages.StandardController stdController) {
        finPerId = stdController.getId();
    }
    public PageReference onSubmit() {
        if (finPerId != null) {
            SBAA.ApprovalAPI.submit(finPerId, SBAA__Approval__c.Finance_Period__c);
        }
        return new PageReference('/' + finPerId);
    }
    public PageReference onRecall() {
        if (finPerId != null) {
            SBAA.ApprovalAPI.recall(finPerId, SBAA__Approval__c.Finance_Period__c);
        }
        return new PageReference('/' + finPerId);
    }
}