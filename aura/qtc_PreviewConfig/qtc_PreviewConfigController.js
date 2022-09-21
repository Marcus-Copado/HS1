/**
 * Created by scheck on 10/25/18.
 */
({
  doInit: function (component, event, helper) {
    console.log('qtc_PreviewConfig | init');
    helper.handleProductStringLoad(arguments);

  },

  reloadProduct: function (component, event, helper) {
    console.log('qtc_PreviewConfig | reloadProduct');
    component.set("v.featureModel", null);
    component.set("v.showSpinner", true);

    helper.handleProductStringLoad(arguments);

  },

  newFeature: function (component, event, helper) {
    console.log('qtc_PreviewConfig | newFeature');
    
    var productModel = component.get("v.productModel");
    var maxFeature = 0;

    // map/reduce to get max feature number to default new record
    if (productModel.features.length > 0) {
      maxFeature = productModel.features.map(function (feature) {
        return feature.record.SBQQ__Number__c
      }).reduce(function (a, b) {
        return Math.max(a, b);
      });
    }

    var modalBody;
    $A.createComponent("c:qtc_NewFeature", {},
       function(content, status) {
           if (status === "SUCCESS") {
               content.set("v.featNumber", (maxFeature + 10));
               content.set("v.parentId", component.get("v.recordId"));
               modalBody = content;
               
               component.find('overlayLib').showCustomModal({
                  header: "New Feature",
                   body: modalBody, 
                   showCloseButton: true,
                   closeCallback: function(){
                      var reload = component.get('c.reloadProduct');
                      $A.enqueueAction(reload);
                   }
               })
           }                               
       });

  },

  newOption: function (component, event, helper) {

    console.log('qtc_PreviewConfig | newOption');

    var productModel = component.get("v.productModel");
    var maxOption = 0;

    // map/reduce to get max feature number to default new record
    if (productModel.options.length > 0) {
      maxOption = productModel.options.map(function (option) {
        return option.record.SBQQ__Number__c
      }).reduce(function (a, b) {
        return Math.max(a, b);
      });
    }

    var createRecordEvent = $A.get("e.force:createRecord");
    createRecordEvent.setParams({
      "entityApiName": "SBQQ__ProductOption__c",
      "defaultFieldValues": {
        'SBQQ__ConfiguredSKU__c': component.get("v.recordId"),
        'SBQQ__Number__c': (maxOption + 10)
      }
    });
    createRecordEvent.fire();

  },

  previewConfig: function (component, event, helper) {
    console.log('qtc_PreviewConfig | previewConfig');

    helper.handleNavToConfig(arguments);

  }
})