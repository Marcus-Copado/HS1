{
  "action": "query",
  "responseId": "4NMKV4WEmU4kmP-qbvx20-",
  "results": {
    "metadata": [
      {
        "lineage": {
          "type": "foreach",
          "projections": [
            {
              "field": {
                "id": "q.binsize",
                "type": "numeric"
              }
            }
          ]
        }
      }
    ],
    "records": [
      {
        "binsize": 100
      }
    ]
  },
  "query": "q = load \"0Fb0v0000004eclCAA/0Fc0v000001N5MlCAK\";\nq = group q by all;\nq = foreach q generate case when ceil(count()/100) < 30 then 30 else ceil(count()/100) end as 'binsize';\nq = limit q 1;",
  "responseTime": 1
}
