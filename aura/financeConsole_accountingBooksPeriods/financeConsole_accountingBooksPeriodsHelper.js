({
      // Fetch the accounting periods from the Apex controller
      getAccountingPeriodsList: function(component) {
        var action = component.get('c.getAccountingPeriods');
        // Set up the callback
        action.setCallback(this, function(actionResult) {
         component.set('v.periods', actionResult.getReturnValue());
        });

        $A.enqueueAction(action);  
        
      },
   
      // Fetch the revenue periods from the Apex controller
      getRevenuePeriodsList: function(component) {
		var action2 = component.get('c.getRevenuePeriods'); 
        // Set up the callback
        action2.setCallback(this, function(actionResult) {
         component.set('v.revperiods', actionResult.getReturnValue());
        });

		$A.enqueueAction(action2);
          
      },
   
      // Fetch the finance books from the Apex controller
      getFinanceBookList: function(component) {
		var action3 = component.get('c.getDemBooks'); 
        // Set up the callback
        action3.setCallback(this, function(actionResult) {
         component.set('v.finBooks', actionResult.getReturnValue());
        });

		$A.enqueueAction(action3);
          
      },
    
      // Fetch the Legal Entities from the Apex controller
      getLegalEntityList: function(component) {
		var action4 = component.get('c.getDemEntities'); 
        // Set up the callback
        action4.setCallback(this, function(actionResult) {
         component.set('v.legalEnts', actionResult.getReturnValue());
        });

		$A.enqueueAction(action4);
          
      }
    
})