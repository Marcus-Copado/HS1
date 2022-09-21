({
    handleClickApprove: function(component, event, helper) {
        helper.updateToApproved(component, event);
    },
    
    handleClickReject: function(component, event, helper) {
        helper.updateToRejected(component, event);
    },
    
    handleClickGoToQuote: function(component, event, helper ) {
         helper.goToQuote(component, event);
    },
    
})