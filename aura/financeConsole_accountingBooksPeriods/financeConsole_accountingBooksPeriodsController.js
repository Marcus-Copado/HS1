({
      doInit: function(component, event, helper) {
        // Fetch the account list from the Apex controller
        helper.getAccountingPeriodsList(component);
        helper.getRevenuePeriodsList(component);
        helper.getFinanceBookList(component);
        helper.getLegalEntityList(component);
      },
      
      manageAccountingPeriod: function(component, event, helper) {
		// Navigate to Finance Period
        var navEvt = $A.get("e.force:navigateToSObject");
        navEvt.setParams({
            "recordId": event.getSource().get("v.value")
        });
        navEvt.fire();
    	}
})