({
    doInit: function(component, event, helper) {
	helper.getApprovalsHelper(component);
    },
    
    handleClickDetails: function(component, event, helper) {
	helper.getApprovalDetails(component, event);
    },
    
    handleClickApprove: function(component, event, helper) {
        helper.updateToApproved(component, event);
        helper.getApprovalsHelper(component);
    },
    
    handleClickReject: function(component, event, helper) {
        helper.updateToRejected(component, event);
        helper.getApprovalsHelper(component);
    },
    
    handleClickGoToQuote: function(component, event, helper ) {
        helper.goToQuote(component, event);
    },
    
    handleViewAllApprovals: function(component, event, helper) {
        helper.goToAllAssignedApprovals(component, event, helper);
    }
    
})