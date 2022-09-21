({
	doInit : function(component, event, helper) {
		console.log("Got here!");
	}, 
    
    handleClick : function(component, event, helper) {
       
        helper.createQuoteHelper(component);
       
    }
})