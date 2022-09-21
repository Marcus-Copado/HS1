({
    generateDocusignDoc : function(component, event, helper) {
		 //window.open("/apex/dfsle__gendocumentgenerator?sId=" + component.get("v.recordId") + "&templateId=a3x3t000007tyK5AAG&recordId=" + component.get("v.recordId") ,'_blank');
         window.open('/apex/dfsle__gendocumentgenerator', null, [sId = SBQQ__Quote__c.Id, templateId = 'a3x3t000007tyK5AAG', recordId = SBQQ__Quote__c.Id, recordName = SBQQ__Quote__c.Name, title = 'Generate Quote-Proposal']);
       /* URLFOR('/apex/dfsle__gendocumentgenerator', null, [sId = quoteId, templateId = 'a3x3t000007tyK5AAG', recordId = quoteId, recordName = quoteId, title = 'Generate Quote-Proposal']) */
    }
})