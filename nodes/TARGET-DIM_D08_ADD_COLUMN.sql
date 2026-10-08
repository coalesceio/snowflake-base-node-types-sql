@id("d5a70000-0000-4000-8000-000000000108")
@nodeType("SQLDimension")
@materializationType("table")
SELECT
     "NAtionKey" AS "NATION_KEY" @id("d08001") @isBusinessKey,
     "name" AS "NATION_NAME" @id("d08002"),
     "REGIONKEY" AS "REGION_KEY" @id("d08003"),
     "CommenT" AS "NATION_COMMENT" @id("d08004"),
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("d08008") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("d08009") @isSystemUpdateDate,
     "N_Load_Timestamp" AS "LOAD_TS" @id("d0800a") @tag("PII", "false") @description("Added in phase 2")
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
