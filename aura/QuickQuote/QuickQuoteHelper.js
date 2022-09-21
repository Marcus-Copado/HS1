({
	createQuoteHelper : function(component, event, helper) {
	    console.log('QuickQuote | createQuoteHelper')
	    var urlEvent = $A.get("e.force:navigateToURL");
	    component.set("v.showSpinner", true);
        var start = new Date(component.find("StartDate").get("v.value"));
        console.log(start.getTime());
        var StartDate=(start.getMonth() + 1 < 10? "0" : "") + (start.getMonth() + 1)+"/"+(start.getDate() < 10? "0" : "") + (start.getDate())+"/"+start.getFullYear();

        console.log("start = " + start);
        console.log("Start Date = "+StartDate);

        var SubscriptionTerm=component.find("SubscriptionTerm").get("v.value");
      	var action=component.get("c.createQuote");

        action.setParams({
            StartDate:StartDate,
            SubscriptionTerm:SubscriptionTerm
        });

        action.setCallback(this, function(response){
            var state=response.getState();
            console.log(response.getReturnValue());
            if(state==="SUCCESS"){
                setTimeout(function() {
                    component.set("v.showSpinner", false);
                    }, 1500);
                // If the quote is successfully created, load it into the SBQQ.ServiceRouter page
                // to redirect to the Quote Line Editor.
                urlEvent.setParams({"url": "/sfdcpage/%2Fapex%2FSBQQ__sb%3F%26id%3D"+response.getReturnValue()});
                urlEvent.fire();
            }
            else{
                console.log("Error! Quote not created");
                setTimeout(function() {
                    component.set("v.showSpinner", false);
                    }, 1500);
            }
        });

        $A.enqueueAction(action); //performs the action
	},

})