/************************************************************
 Lightning Controller  Details
 Name: CreateUsageRecordController.js
 Type: Lightning Controller 
 Purpose: Controller for  lightning component 
		  CreateUsageRecordController.cmp
 ***********************************************************/
({
    init : function(component, event, helper) {
		console.log("UsageUploaderController | init");
        let dt = new Date();
        let today = dt.getFullYear() + '-' + dt.getMonth() + 1 + '-' + dt.getDate() + 'T18:30:00.000Z';
        console.log(today);
        component.set("v.defaultUsageDate", today);
        let newUsage = component.get("v.usageRecord");
        newUsage.blng__StartDateTime__c = today;
        newUsage.blng__EndDateTime__c = today;
        component.set("v.usageRecord", newUsage);
        console.log(JSON.stringify(newUsage));
        
        let action = component.get("c.fetchRelatedOrderItems");
        action.setParams({"orderId": component.get("v.recordId")});
        action.setCallback(this, function(response) {
            let state = response.getState();
            let data = response.getReturnValue();
            if(state === "SUCCESS") {
                if(data.OrderItems) {
                    component.set("v.orderItems", data.OrderItems);
                }
            }
        });
        $A.enqueueAction(action);
    },

	create : function(component, event, helper) {
		console.log('Create record');
       
        //getting the candidate information
        var usageRecord = component.get("v.usageRecord");
        
        //Validation
        if($A.util.isEmpty(usageRecord.blng__StartDateTime__c) || $A.util.isUndefined(usageRecord.blng__StartDateTime__c)){
            alert('Start Date is Required');
            return;
        }            
        if($A.util.isEmpty(usageRecord.blng__EndDateTime__c) || $A.util.isUndefined(usageRecord.blng__EndDateTime__c)){
            alert('End Date is Required');
            return;
        }
        if($A.util.isEmpty(usageRecord.blng__Quantity__c) || $A.util.isUndefined(usageRecord.blng__Quantity__c)){
            alert('Quantity is Required');
            return;
        }
        if($A.util.isEmpty(usageRecord.blng__MatchingId__c) || $A.util.isUndefined(usageRecord.blng__MatchingId__c)){
            alert('Matching ID is Required');
            return;
        }
        console.log(usageRecord.blng__StartDateTime__c);
        console.log(usageRecord.blng__EndDateTime__c);
        console.log(usageRecord.blng__Quantity__c);
        console.log(usageRecord.blng__MatchingId__c);
        
        //Calling the Apex Function
        var action = component.get("c.createRecord");
        
        //Setting the Apex Parameter
        action.setParams({
            usageRecord : usageRecord
        });
        
        //Setting the Callback
        action.setCallback(this,function(a){
            //get the response state
            var state = a.getState();
            
            //check if result is successfull
            if(state == "SUCCESS"){
                //Reset Form
                var newUsage = {'sobjectType': 'blng__Usage__c',
                                    'blng__StartDateTime__c': '',
                                    'blng__EndDateTime__c': '',
                                    'blng__Quantity__c': '', 
                                    'blng__MatchingId__c': ''
                                   };
                //resetting the Values in the form
                component.set("v.usageRecord",newUsage);
                alert('Record is Created Successfully');
            } else if(state == "ERROR"){
                alert('Error in calling server side action');
            }
        });
        
		//adds the server-side action to the queue        
        $A.enqueueAction(action);

	},
    
    updateUsageDate : function(component, event, helper) {
        console.log("UsageUploaderController | updateUsageDate");
        let newUsage = component.get("v.usageRecord");
        let val = component.find("usageDate").get("v.value");
        console.log("VALUE:::", val);
        newUsage.blng__StartDateTime__c = val;
        newUsage.blng__EndDateTime__c = val;
        component.set("v.usageRecord", newUsage);
        console.log(JSON.stringify(newUsage));
    },
    
    updateOrderProduct : function(component, event, helper) {
        console.log("UsageUploaderController | updateOrderProduct");
        let newUsage = component.get("v.usageRecord");
        newUsage.blng__MatchingId__c = component.find("orderProduct").get("v.value");
        console.log(newUsage.blng__MatchingId__c);
        component.set("v.usageRecord", newUsage);
    }
})