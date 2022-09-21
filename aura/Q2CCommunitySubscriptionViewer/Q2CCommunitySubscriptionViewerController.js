({
    doInit: function(component, event, helper) {      
        // Fetch the sub list from the Apex controller   
        helper.getSubList(component);
    }
    
    })