({
    doInit: function(component, event, helper) {      
        // Fetch the contract list from the Apex controller   
        helper.getContractList(component);
        // helper.getSubList(component);
    },
    
    viewContract: function(component, event, helper) {
        // Prevent the form from getting submitted
        //event.preventDefault();
        // Get the value from the field that's in the form
        var contractId = event.target.id;

        //var contractId = component.getElementsByClassName('contract-number')[0].value;//event.target.getElementsByClassName('contract-number')[0].value;
        //confirm('Amend contract ' + contractId + ' ?');
        console.log('------ New Run ------')
        console.log('viewContract');
        console.log(contractId);
        var action = component.get('c.fireAmend');
     
        action.setParams({
            "contractId": contractId
        });
      
        action.setCallback(this, function(response) {
            let data = response.getReturnValue();
            let state = response.getState();
            component.set('v.quoteId', response.getReturnValue());
            console.log(data);
            
         var navEvent = $A.get("e.force:navigateToSObject");
         navEvent.setParams({
              recordId: v.quoteId,
              slideDevName: "detail"
         });
         navEvent.fire(); 
    
            console.log('------ Finished ------')
        });
        
        console.log('enqueue action');
        $A.enqueueAction(action);     
    }
    
    })