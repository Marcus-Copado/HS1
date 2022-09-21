({
    getApprovalsHelper : function(component) {
        var action=component.get("c.getCurrentUserApprovals");
        
        action.setCallback(this, function(response){
            var state=response.getState();
            var data=response.getReturnValue();
            if(state==="SUCCESS"){
				component.set('v.approvals', response.getReturnValue());
            }
            else{
                console.log("Error! Not data found");
            }
        });
        $A.enqueueAction(action); //performs the action        
    },
    
    getApprovalDetails: function(component, event) {
        var sobjectEvent=$A.get("e.force:navigateToSObject");
        sobjectEvent.setParams({
            "recordId": event.target.id
        })
        sobjectEvent.fire();
    },
        
    goToAllAssignedApprovals: function (component, event, helper) {
        var action = component.get("c.getListViews");
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                var listviews = response.getReturnValue();
				var navEvent = $A.get("e.force:navigateToList");
				navEvent.setParams({
                    "listViewId": listviews[0].Id,
                    "listViewName": null,
                    "scope": "sbaa__Approval__c"
                });
                navEvent.fire();
            }
        });
        $A.enqueueAction(action);
    }
})