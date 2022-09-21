({
	createQuoteHelper : function(component, event, helper) {
        var start = new Date(component.find("StartDate").get("v.value"));
        var StartDate=(start.getMonth() + 1 < 10? "0" : "") + (start.getMonth() + 1)+"/"+(start.getDate() < 10? "0" : "") + (start.getDate())+"/"+start.getFullYear();
        console.log("start = "+start);
        
        console.log("Start Date = "+StartDate);
        var SubscriptionTerm=component.find("SubscriptionTerm").get("v.value");
      	var action=component.get("c.createQuote");
        action.setParams({
            StartDate:StartDate,
            SubscriptionTerm:SubscriptionTerm
            
        });
        action.setCallback(this, function(response){
            var state=response.getState();
            var data=response.getReturnValue();
            if(state==="SUCCESS"){
                //
                //var url = window.location.href;
                location.href = '/s/sfdcpage/%2Fapex%2FSBQQ__sb%3F%26id%3D'+data;
            }
            else{
                console.log("Error! Quote not created");
            }
        });
        $A.enqueueAction(action); //performs the action
	},

})