/**
 * Created by scheck on 10/25/18.
 */
({
    navToFeature: function (component, event, helper) {
        console.log('qtc_PreviewFeatureController | navToFeature');

        var navEvt = $A.get("e.force:navigateToSObject");
        navEvt.setParams({
            "recordId": component.get("v.featureModel.feature.record.Id")
        });

        navEvt.fire();
    },

    editFeature: function (component, event, helper) {
        console.log('qtc_PreviewFeatureController | editFeature');

        var editRecordEvent = $A.get("e.force:editRecord");
        editRecordEvent.setParams({
            "recordId": component.get("v.featureModel.feature.record.Id")
        });
        editRecordEvent.fire();
    },

    newFeatureOption: function (component, event, helper) {

        console.log('qtc_PreviewFeatureController | newFeatureOption');

        var featureModel = component.get("v.featureModel");
        var maxOption = 0;

        // map/reduce to get max feature number to default new record
        if (featureModel.options.length > 0) {
            maxOption = featureModel.options.map(function (option) {
                return option.record.SBQQ__Number__c
            }).reduce(function (a, b) {
                return Math.max(a, b);
            });
        }

        var modalBody;
        $A.createComponent("c:qtc_NewOption", {},
           function(content, status) {
               if (status === "SUCCESS") {
                   content.set("v.optNumber", (maxOption + 10));
                   content.set("v.featId", component.get("v.featureModel.feature.record.Id"));
                   content.set("v.configId", component.get("v.featureModel.feature.record.SBQQ__ConfiguredSKU__c"));
                   modalBody = content;
                   
                   component.find('overlayLib').showCustomModal({
                      header: "New Option",
                       body: modalBody, 
                       showCloseButton: true,
                       closeCallback: function(){
                            var compEvent = component.getEvent("reloadProduct");
                            compEvent.fire();
                       }
                   })
               }                               
           });

    },
})