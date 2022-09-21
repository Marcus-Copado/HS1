{
  "action": "query",
  "responseId": "01",
  "results": {
    "metadata": [
      {
        "lineage": {
          "type": "foreach",
          "projections": [
            {
              "field": {
                "id": "finalResult.Quantity Lower Bound",
                "type": "numeric"
              },
              "inputs": [
                "finalResult.Quantity Lower Bound"
              ]
            },
            {
              "field": {
                "id": "finalResult.Quantity Upper Bound",
                "type": "numeric"
              },
              "inputs": [
                "finalResult.Quantity Lower Bound"
              ]
            },
            {
              "field": {
                "id": "finalResult.Median Discount %",
                "type": "numeric"
              },
              "inputs": [
                "finalResult.Median Discount"
              ]
            },
            {
              "field": {
                "id": "finalResult.Target %",
                "type": "numeric"
              },
              "inputs": [
                "finalResult.Target"
              ]
            },
            {
              "field": {
                "id": "finalResult.Norm %",
                "type": "numeric"
              },
              "inputs": [
                "finalResult.Norm"
              ]
            },
            {
              "field": {
                "id": "finalResult.Floor %",
                "type": "numeric"
              },
              "inputs": [
                "finalResult.Floor"
              ]
            }
          ],
          "input": {
            "type": "group",
            "groups": [
              {
                "id": "finalResult.Bin"
              },
              {
                "id": "finalResult.Quantity Lower Bound"
              },
              {
                "id": "finalResult.Median Discount"
              },
              {
                "id": "finalResult.Target"
              },
              {
                "id": "finalResult.Norm"
              },
              {
                "id": "finalResult.Floor"
              }
            ]
          }
        }
      }
    ],
    "records": [
      {
        "Floor %": 10.0,
        "Median Discount %": 50.0,
        "Norm %": 10.0,
        "Quantity Lower Bound": 1,
        "Quantity Upper Bound": 10,
        "Target %": 10.0
      },
      {
        "Floor %": 10.0,
        "Median Discount %": 33.333,
        "Norm %": 10.0,
        "Quantity Lower Bound": 10,
        "Quantity Upper Bound": 15,
        "Target %": 10.0
      },
      {
        "Floor %": 10.0,
        "Median Discount %": 10.0,
        "Norm %": 10.0,
        "Quantity Lower Bound": 15,
        "Quantity Upper Bound": 20,
        "Target %": 10.0
      },
      {
        "Floor %": 10.0,
        "Median Discount %": 40.0,
        "Norm %": 10.0,
        "Quantity Lower Bound": 20,
        "Quantity Upper Bound": 30,
        "Target %": 10.0
      },
      {
        "Floor %": 10.0,
        "Median Discount %": 27.0,
        "Norm %": 10.0,
        "Quantity Lower Bound": 30,
        "Quantity Upper Bound": 50,
        "Target %": 10.0
      },
      {
        "Floor %": 10.0,
        "Median Discount %": 40.0,
        "Norm %": 10.0,
        "Quantity Lower Bound": 50,
        "Quantity Upper Bound": 60,
        "Target %": 10.0
      },
      {
        "Floor %": 10.0,
        "Median Discount %": 65.0,
        "Norm %": 10.0,
        "Quantity Lower Bound": 60,
        "Quantity Upper Bound": 100,
        "Target %": 10.0
      }
    ]
  },
  "query": "q = load \"0Fb0v0000004eclCAA/0Fc0v000001NMJACA4\";q = filter q by 'SBQQ__Quote__c.SBQQ__Status__c' in [\"Draft\"];q = filter q by 'SBQQ__Product__c.Name' in [\"Bundle1\", \"Fixed Subscription0\"];q = filter q by 'QuantitySum' >= 0;q = filter q by date('SBQQ__Quote__c.CreatedDate_Year', 'SBQQ__Quote__c.CreatedDate_Month', 'SBQQ__Quote__c.CreatedDate_Day') in [\"current fiscal_year\"..\"current day\"];\nq = foreach q generate 'QuantitySum' as 'QuantitySum', 'SBQQ__TotalDiscountRate__c' as 'SBQQ__TotalDiscountRate__c',\n( case\n    when 'QuantitySum' >= 1 and 'QuantitySum' <= 1 then \"0\"\n    when 'QuantitySum' >= -1 and 'QuantitySum' <= -1 then \"1\"\n    when 'QuantitySum' >= -1 and 'QuantitySum' <= -1 then \"2\"\n    when 'QuantitySum' >= -1 and 'QuantitySum' <= -1 then \"3\"\n    when 'QuantitySum' >= -1 and 'QuantitySum' <= -1 then \"4\"\n    when 'QuantitySum' >= -1 and 'QuantitySum' <= -1 then \"5\"\n    when 'QuantitySum' >= -1 and 'QuantitySum' <= -1 then \"6\"\n    when 'QuantitySum' >= -1 and 'QuantitySum' <= -1 then \"7\"\n    when 'QuantitySum' >= 10 and 'QuantitySum' <= 10 then \"8\"\n    when 'QuantitySum' >= -1 and 'QuantitySum' <= -1 then \"9\"\n    when 'QuantitySum' >= -1 and 'QuantitySum' <= -1 then \"10\"\n    when 'QuantitySum' >= -1 and 'QuantitySum' <= -1 then \"11\"\n    when 'QuantitySum' >= -1 and 'QuantitySum' <= -1 then \"12\"\n    when 'QuantitySum' >= -1 and 'QuantitySum' <= -1 then \"13\"\n    when 'QuantitySum' >= -1 and 'QuantitySum' <= -1 then \"14\"\n    when 'QuantitySum' >= -1 and 'QuantitySum' <= -1 then \"15\"\n    when 'QuantitySum' >= -1 and 'QuantitySum' <= -1 then \"16\"\n    when 'QuantitySum' >= 15 and 'QuantitySum' <= 15 then \"17\"\n    when 'QuantitySum' >= -1 and 'QuantitySum' <= -1 then \"18\"\n    when 'QuantitySum' >= -1 and 'QuantitySum' <= -1 then \"19\"\n    when 'QuantitySum' >= -1 and 'QuantitySum' <= -1 then \"20\"\n    when 'QuantitySum' >= -1 and 'QuantitySum' <= -1 then \"21\"\n    when 'QuantitySum' >= -1 and 'QuantitySum' <= -1 then \"22\"\n    when 'QuantitySum' >= -1 and 'QuantitySum' <= -1 then \"23\"\n    when 'QuantitySum' >= -1 and 'QuantitySum' <= -1 then \"24\"\n    when 'QuantitySum' >= -1 and 'QuantitySum' <= -1 then \"25\"\n    when 'QuantitySum' >= -1 and 'QuantitySum' <= -1 then \"26\"\n    when 'QuantitySum' >= -1 and 'QuantitySum' <= -1 then \"27\"\n    when 'QuantitySum' >= -1 and 'QuantitySum' <= -1 then \"28\"\n    when 'QuantitySum' >= -1 and 'QuantitySum' <= -1 then \"29\"\n    when 'QuantitySum' >= -1 and 'QuantitySum' <= -1 then \"30\"\n    when 'QuantitySum' >= -1 and 'QuantitySum' <= -1 then \"31\"\n    when 'QuantitySum' >= -1 and 'QuantitySum' <= -1 then \"32\"\n    when 'QuantitySum' >= -1 and 'QuantitySum' <= -1 then \"33\"\n    when 'QuantitySum' >= -1 and 'QuantitySum' <= -1 then \"34\"\n    when 'QuantitySum' >= -1 and 'QuantitySum' <= -1 then \"35\"\n    when 'QuantitySum' >= -1 and 'QuantitySum' <= -1 then \"36\"\n    when 'QuantitySum' >= -1 and 'QuantitySum' <= -1 then \"37\"\n    when 'QuantitySum' >= -1 and 'QuantitySum' <= -1 then \"38\"\n    when 'QuantitySum' >= -1 and 'QuantitySum' <= -1 then \"39\"\n    when 'QuantitySum' >= 20 and 'QuantitySum' <= 20 then \"40\"\n    when 'QuantitySum' >= -1 and 'QuantitySum' <= -1 then \"41\"\n    when 'QuantitySum' >= -1 and 'QuantitySum' <= -1 then \"42\"\n    when 'QuantitySum' >= -1 and 'QuantitySum' <= -1 then \"43\"\n    when 'QuantitySum' >= -1 and 'QuantitySum' <= -1 then \"44\"\n    when 'QuantitySum' >= -1 and 'QuantitySum' <= -1 then \"45\"\n    when 'QuantitySum' >= -1 and 'QuantitySum' <= -1 then \"46\"\n    when 'QuantitySum' >= -1 and 'QuantitySum' <= -1 then \"47\"\n    when 'QuantitySum' >= -1 and 'QuantitySum' <= -1 then \"48\"\n    when 'QuantitySum' >= -1 and 'QuantitySum' <= -1 then \"49\"\n    when 'QuantitySum' >= -1 and 'QuantitySum' <= -1 then \"50\"\n    when 'QuantitySum' >= -1 and 'QuantitySum' <= -1 then \"51\"\n    when 'QuantitySum' >= -1 and 'QuantitySum' <= -1 then \"52\"\n    when 'QuantitySum' >= -1 and 'QuantitySum' <= -1 then \"53\"\n    when 'QuantitySum' >= -1 and 'QuantitySum' <= -1 then \"54\"\n    when 'QuantitySum' >= -1 and 'QuantitySum' <= -1 then \"55\"\n    when 'QuantitySum' >= -1 and 'QuantitySum' <= -1 then \"56\"\n    when 'QuantitySum' >= -1 and 'QuantitySum' <= -1 then \"57\"\n    when 'QuantitySum' >= -1 and 'QuantitySum' <= -1 then \"58\"\n    when 'QuantitySum' >= -1 and 'QuantitySum' <= -1 then \"59\"\n    when 'QuantitySum' >= -1 and 'QuantitySum' <= -1 then \"60\"\n    when 'QuantitySum' >= -1 and 'QuantitySum' <= -1 then \"61\"\n    when 'QuantitySum' >= 30 and 'QuantitySum' <= 30 then \"62\"\n    when 'QuantitySum' >= -1 and 'QuantitySum' <= -1 then \"63\"\n    when 'QuantitySum' >= -1 and 'QuantitySum' <= -1 then \"64\"\n    when 'QuantitySum' >= -1 and 'QuantitySum' <= -1 then \"65\"\n    when 'QuantitySum' >= -1 and 'QuantitySum' <= -1 then \"66\"\n    when 'QuantitySum' >= -1 and 'QuantitySum' <= -1 then \"67\"\n    when 'QuantitySum' >= -1 and 'QuantitySum' <= -1 then \"68\"\n    when 'QuantitySum' >= -1 and 'QuantitySum' <= -1 then \"69\"\n    when 'QuantitySum' >= -1 and 'QuantitySum' <= -1 then \"70\"\n    when 'QuantitySum' >= -1 and 'QuantitySum' <= -1 then \"71\"\n    when 'QuantitySum' >= -1 and 'QuantitySum' <= -1 then \"72\"\n    when 'QuantitySum' >= -1 and 'QuantitySum' <= -1 then \"73\"\n    when 'QuantitySum' >= -1 and 'QuantitySum' <= -1 then \"74\"\n    when 'QuantitySum' >= -1 and 'QuantitySum' <= -1 then \"75\"\n    when 'QuantitySum' >= -1 and 'QuantitySum' <= -1 then \"76\"\n    when 'QuantitySum' >= -1 and 'QuantitySum' <= -1 then \"77\"\n    when 'QuantitySum' >= -1 and 'QuantitySum' <= -1 then \"78\"\n    when 'QuantitySum' >= -1 and 'QuantitySum' <= -1 then \"79\"\n    when 'QuantitySum' >= -1 and 'QuantitySum' <= -1 then \"80\"\n    when 'QuantitySum' >= -1 and 'QuantitySum' <= -1 then \"81\"\n    when 'QuantitySum' >= -1 and 'QuantitySum' <= -1 then \"82\"\n    when 'QuantitySum' >= -1 and 'QuantitySum' <= -1 then \"83\"\n    when 'QuantitySum' >= -1 and 'QuantitySum' <= -1 then \"84\"\n    when 'QuantitySum' >= -1 and 'QuantitySum' <= -1 then \"85\"\n    when 'QuantitySum' >= -1 and 'QuantitySum' <= -1 then \"86\"\n    when 'QuantitySum' >= 50 and 'QuantitySum' <= 50 then \"87\"\n    when 'QuantitySum' >= -1 and 'QuantitySum' <= -1 then \"88\"\n    when 'QuantitySum' >= -1 and 'QuantitySum' <= -1 then \"89\"\n    when 'QuantitySum' >= -1 and 'QuantitySum' <= -1 then \"90\"\n    when 'QuantitySum' >= -1 and 'QuantitySum' <= -1 then \"91\"\n    when 'QuantitySum' >= -1 and 'QuantitySum' <= -1 then \"92\"\n    when 'QuantitySum' >= -1 and 'QuantitySum' <= -1 then \"93\"\n    when 'QuantitySum' >= -1 and 'QuantitySum' <= -1 then \"94\"\n    when 'QuantitySum' >= -1 and 'QuantitySum' <= -1 then \"95\"\n    when 'QuantitySum' >= -1 and 'QuantitySum' <= -1 then \"96\"\n    when 'QuantitySum' >= -1 and 'QuantitySum' <= -1 then \"97\"\n    when 'QuantitySum' >= -1 and 'QuantitySum' <= -1 then \"98\"\n    when 'QuantitySum' >= 60 and 'QuantitySum' <= 60 then \"99\"\n    else \"100\"\n end ) as 'BinGroup';\nq = order q by 'QuantitySum';\nresult = group q by 'BinGroup';\nresult = foreach result generate 'BinGroup' as 'BinGroup', min('QuantitySum') as 'Quantity Lower Bound', max('QuantitySum') as 'Quantity Upper Bound',  median('SBQQ__TotalDiscountRate__c') as 'Median Discount';\nresult = foreach result generate 'BinGroup' as 'Bin', 'Quantity Lower Bound' as 'Quantity Lower Bound', 'Quantity Upper Bound' as 'Quantity Upper Bound', 'Median Discount' as 'Median Discount', 'Median Discount' + ('Median Discount'*(-100/100)) as 'Target', 'Median Discount' + ('Median Discount'*(-100/100)) as 'Norm', 'Median Discount' + ('Median Discount'*(-100/100)) as 'Floor';\nresult = order result by 'Quantity Lower Bound' asc;\n--Combine upper and lower bounds to create ranges\nfinalResult = group result by ('Bin','Quantity Lower Bound', 'Median Discount', 'Target', 'Norm', 'Floor');\nfinalResult = foreach finalResult generate 'Quantity Lower Bound' as 'Quantity Lower Bound', max('Quantity Lower Bound') over([0..1] partition by all order by 'Quantity Lower Bound') as 'Quantity Upper Bound', 'Median Discount' as 'Median Discount %', 'Target' as 'Target %', 'Norm' as 'Norm %', 'Floor' as 'Floor %';"
}
