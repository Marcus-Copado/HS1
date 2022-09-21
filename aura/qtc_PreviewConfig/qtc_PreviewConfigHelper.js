/**
 * Created by scheck on 10/25/18.
 */
({

    handleProductStringLoad: function (args) {
        console.log('qtc_PreviewConfigHelper | handleProductStringLoad');
        let [component, event, helper] = args;
        var action = component.get("c.getProductString");
        action.setParams({
            "productId": component.get("v.recordId"),
        });

        action.setCallback(this, function (response) {
            let data = response.getReturnValue();
            let state = response.getState();
            if (state === "SUCCESS") {

                var productModel = JSON.parse(data);
                console.log("Product Model: ");
                console.log(productModel);

                var featureModel = [];

                productModel.features.forEach(function (feature) {

                    console.log('Feature: ', feature.record.Name);
                    var featureOptions = [];
                    productModel.options.forEach(function (option) {

                        if (feature.record.Id == option.record.SBQQ__Feature__c) {
                            console.log('-- Option: ', option.record.Name);
                            featureOptions.push(option);
                        }
                    });

                    featureModel.push({
                        feature: feature,
                        options: featureOptions
                    });

                });
                console.log(featureModel);
                component.set("v.featureModel", featureModel);
                component.set("v.productModel", productModel);
                component.set("v.productJSON", data);
                component.set("v.showSpinner", false);
            }
        });
        $A.enqueueAction(action);
    },

    handleNavToConfig: function (args) {
        console.log('qtc_PreviewConfigHelper | handleNavToConfig');
        let [component, event, helper] = args;
        var urlEvent = $A.get("e.force:navigateToURL");

        var action = component.get("c.getConfigURL");
        action.setParams({
            "productId": component.get("v.recordId"),
        });

        action.setCallback(this, function (response) {
            let data = response.getReturnValue();
            let state = response.getState();
            if (state === "SUCCESS") {
                console.log(`Config URL: ${data}`);
                var configURL = data;

                urlEvent.setParams({
                    "url": configURL
                });
                urlEvent.fire();

            }
        });
        $A.enqueueAction(action);
    },

})