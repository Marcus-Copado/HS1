{
    "type" : "user",
    "state" : {
    "steps" : {
        "targetPercentMedianStep" : {
            "values" : [ "10" ],
                "metadata" : {
                "strings" : [ ],
                    "numbers" : [ ],
                    "groups" : [ "display" ]
            }
        },
        "normPercentMedianStep" : {
            "values" : [ "0" ],
                "metadata" : {
                "strings" : [ ],
                    "numbers" : [ ],
                    "groups" : [ "display" ]
            }
        },
        "generateIntermediateStep" : {
            "values" : [ ],
                "metadata" : {
                "strings" : [ ],
                    "numbers" : [ ],
                    "groups" : [ "Bin", "BinMeasure" ]
            }
        },
        "generateFinalPricingGuidanceStep" : {
            "values" : [ ],
                "metadata" : {
                "strings" : [ ],
                    "numbers" : [ ],
                    "groups" : [ "Quantity Lower Bound" ]
            }
        },
        "generateBinSizeStep" : {
            "values" : [ ],
                "metadata" : {
                "strings" : [ ],
                    "numbers" : [ ],
                    "groups" : [ ]
            }
        },
        "floorPercentMedianStep" : {
            "values" : [ "-10" ],
                "metadata" : {
                "strings" : [ ],
                    "numbers" : [ ],
                    "groups" : [ "display" ]
            }
        }
    },
    "datasets" : {
        "pricingGuidanceFilterData" : [ {
            "type" : "global",
            "filter" : {
                "values" : [ "Draft" ],
                "operator" : "in",
                "nestedValues" : null,
                "doubleNestedValues" : null
            },
            "fields" : [ "SBQQ__Quote__c.SBQQ__Status__c" ]
        }, {
            "type" : "global",
            "filter" : {
                "values" : [ "Bundle1", "Fixed Subscription0" ],
                "operator" : "in",
                "nestedValues" : null,
                "doubleNestedValues" : null
            },
            "fields" : [ "SBQQ__Product__c.Name" ]
        }, {
            "type" : "global",
            "filter" : {
                "values" : null,
                "operator" : "&gt;=",
                "nestedValues" : [ [ "0" ] ],
                "doubleNestedValues" : null
            },
            "fields" : [ "QuantitySum" ]
        }, {
            "type" : "global",
            "filter" : {
                "values" : null,
                "operator" : "&gt;=&lt;=",
                "nestedValues" : null,
                "doubleNestedValues" : [ [ [ "fiscal_year", "0" ], [ "day", "0" ] ] ]
            },
            "fields" : [ "SBQQ__Quote__c.CreatedDate" ]
        } ]
    }
},
    "label" : "view1",
    "isInitial" : false,
    "id" : "01"
}