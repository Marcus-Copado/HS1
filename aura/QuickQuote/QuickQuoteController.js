({
	doInit : function(component, event, helper) {
		console.log("Initialized QuickQuote Component");
	}, 
    
    handleClick : function(component, event, helper) {
        helper.createQuoteHelper(component);
    },
})