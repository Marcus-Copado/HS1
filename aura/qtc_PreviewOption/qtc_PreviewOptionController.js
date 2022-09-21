/**
 * Created by scheck on 10/25/18.
 */
({
    navToOption: function (component, event, helper) {
        console.log('qtc_PreviewOptionController | navToOption');
        var navEvt = $A.get("e.force:navigateToSObject");
        navEvt.setParams({
            "recordId": component.get("v.optionModel.record.Id")
        });

        navEvt.fire();
    },

    navToProduct: function (component, event, helper) {
        console.log('qtc_PreviewOptionController | navToProduct');

        var navEvt = $A.get("e.force:navigateToSObject");
        navEvt.setParams({
            "recordId": component.get("v.optionModel.record.SBQQ__OptionalSKU__c")
        });

        navEvt.fire();
    },

    editOption: function (component, event, helper) {
        console.log('qtc_PreviewOptionController | editOption');

        var editRecordEvent = $A.get("e.force:editRecord");
        editRecordEvent.setParams({
            "recordId": component.get("v.optionModel.record.Id")
        });
        editRecordEvent.fire();
    },
})