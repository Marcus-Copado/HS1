({
    handleOnload : function(component, event, helper) {
        console.log('qtc_NewFeature | handleOnload');
        
        // requires inputFields to have aura:id
        component.find("featureNumber").set("v.value", component.get("v.featNumber"));
        component.find("configuredSKU").set("v.value", component.get("v.parentId"));
    },

    handleSuccess : function(component, event, helper) {
        console.log('qtc_NewFeature | handleSuccess');

        $A.get("e.force:showToast").setParams({
            "title": "Success!",
            "message": "New Feature created!",
            "type": "success"
        }).fire();
        
        component.find("overlayLib").notifyClose();
    },

})