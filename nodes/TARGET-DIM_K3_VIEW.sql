@id("d5a70000-0000-4000-8000-000000000403")
@nodeType("SQLDimension")
@materializationType("view")
@description("K3 view - recreated")
@tag("Cost_Centre", "OPS")
@tag("PII", "true")
SELECT
     "NAtionKey" AS "NATION_KEY" @id("d30001") @isBusinessKey @tag("OWNER", "Keys"),
     UPPER("name") AS "NATION_NAME" @id("d30002") @tag("PII", "false"),
     "REGIONKEY" * 10 AS "REGION_SCORE" @id("d3000a") @tag("OWNER", "Data"),
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("d30008") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("d30009") @isSystemUpdateDate
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
