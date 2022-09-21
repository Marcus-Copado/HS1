({
    handleOnload : function(component, event, helper) {
        console.log('qtc_NewOption | handleOnload');
        
        // requires inputFields to have aura:id
        component.find("optionNumber").set("v.value", component.get("v.optNumber"));
        component.find("configuredSKU").set("v.value", component.get("v.configId"));
        component.find("featureId").set("v.value", component.get("v.featId"));
        
    },

    handleSuccess : function(component, event, helper) {
        console.log('qtc_NewOption | handleSuccess');

        $A.get("e.force:showToast").setParams({
            "title": "Success!",
            "message": "New Option created!",
            "type": "success"
        }).fire();

        component.find("overlayLib").notifyClose();
    },

})