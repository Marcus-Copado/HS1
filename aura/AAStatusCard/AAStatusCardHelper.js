({
        
    updateToApproved: function(component, event) {
        var action=component.get("c.updateApprovalStatus");
        action.setParams({
            "Approval": event.target.id, 
            "Status": "Approved", 
            "Comments": component.find("comment").get("v.value")
        })
        
        action.setCallback(this, function(response){
            var state=response.getState();
            var data=response.getReturnValue();
            if(state==="SUCCESS"){
                component.getEvent("AAStatusRefresh").fire();
            }
            else{
                console.log("Error! Not data found");
            }
        });
        
        $A.enqueueAction(action); //performs the action
    },
    
    updateToRejected: function(component, event) {
        var action=component.get("c.updateApprovalStatus");
        action.setParams({
            "Approval": event.target.id, 
            "Status": "Rejected", 
            "Comments": component.find("comment").get("v.value")
        })
        
        action.setCallback(this, function(response){
            var state=response.getState();
            var data=response.getReturnValue();
            if(state==="SUCCESS"){
                component.getEvent("AAStatusRefresh").fire();
            }
            else{
                console.log("Error! Not data found");
            }
        });
        $A.enqueueAction(action); //performs the action        
    },
    
    goToQuote: function(component, event) {
        var sobjectEvent=$A.get("e.force:navigateToSObject");
        sobjectEvent.setParams({
            "recordId": event.target.id
        })
        sobjectEvent.fire();   
    },
})