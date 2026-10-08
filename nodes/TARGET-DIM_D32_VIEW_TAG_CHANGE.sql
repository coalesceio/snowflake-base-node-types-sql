@id("d5a70000-0000-4000-8000-000000000132")
@nodeType("SQLDimension")
@materializationType("view")
@tag("Cost_Centre", "FIN")
SELECT
     "NAtionKey" AS "NATION_KEY" @id("d32001") @isBusinessKey,
     "name" AS "NATION_NAME" @id("d32002") @tag("PII", "true"),
     "REGIONKEY" AS "REGION_KEY" @id("d32003"),
     "CommenT" AS "NATION_COMMENT" @id("d32004"),
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("d32008") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("d32009") @isSystemUpdateDate
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
