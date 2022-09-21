public with sharing class CreditNoteExtController {
	private Id recordId;
	public CreditNoteExtController(ApexPages.StandardController stdController) {
		recordId = stdController.getId();
	}
	public PageReference onSubmit() {
		if (recordId != null) {
			SBAA.ApprovalAPI.submit(recordId, SBAA__Approval__c.CreditNote__c);
		}
		return new PageReference('/' + recordId);
	}
	public PageReference onRecall() {
		if (recordId != null) {
			SBAA.ApprovalAPI.recall(recordId, SBAA__Approval__c.CreditNote__c);
		}
		return new PageReference('/' + recordId);
	}
}