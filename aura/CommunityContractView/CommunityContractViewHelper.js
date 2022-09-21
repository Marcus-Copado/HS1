({
    // Fetch the contracts from the Apex controller
    getContractList: function(component) {
        console.log('In getContractList');
        var action = component.get('c.getContracts');
        // Set up the callback
        var self = this;
        action.setCallback(this, function(actionResult) {
            component.set('v.contracts', actionResult.getReturnValue());
        });
        $A.enqueueAction(action);
    }
   
    
})