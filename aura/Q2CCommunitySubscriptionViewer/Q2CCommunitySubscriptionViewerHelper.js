({
    // Fetch the subs from the Apex controller
    getSubList: function(component) {
        console.log('In getSubList');
        var action = component.get('c.getSubs');
        // Set up the callback
        var self = this;
        action.setCallback(this, function(actionResult) {
            component.set('v.subs', actionResult.getReturnValue());
        });
        $A.enqueueAction(action);
    }

    
})