@id("d5a70000-0000-4000-8000-000000000503")
@nodeType("SQLFact")
@materializationType("view")
@description("K3 view - recreated")
@tag("Cost_Centre", "OPS")
@tag("PII", "true")
SELECT
     "NAtionKey" AS "NATION_KEY" @id("e30001") @isBusinessKey @tag("OWNER", "Keys"),
     UPPER("name") AS "NATION_NAME" @id("e30002") @tag("PII", "false"),
     "REGIONKEY" * 10 AS "REGION_SCORE" @id("e3000a") @tag("OWNER", "Data"),
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("e30008") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("e30009") @isSystemUpdateDate
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
