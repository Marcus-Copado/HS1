({
	doInit : function(component, event, helper) {
        var transactionParams = {};
        transactionParams.accountId = component.get("v.recordId");
        console.log('HERE HERE HERE');
       	console.log(transactionParams.accountId);
        console.log(component);
        console.log(event);
        transactionParams.gatewayId = component.get("v.gatewayId");
        console.log(transactionParams.gatewayId);
        transactionParams.amount = component.get("v.amount");
        
        component.set("v.transactionParams", transactionParams);
    },

    handleTransactionResponse : function(cmp, event, helper) {
        var response = event.getParam("response");
        if(response.isSuccess) {
            helper.displayToast('Success!', 'Success', 'success');
        } else if(response.gatewayResponse != null && response.gatewayResponse.message != null) {
			helper.displayToast('Failure!', response.gatewayResponse.message, 'error');
        } else if(response.errorDetails != null && response.errorDetails.message != null) {
            helper.displayToast('Failure!', response.errorDetails.message, 'error');
        } else {
            helper.displayToast('Failure!', 'Transaction failed', 'error');
        }
    }
})