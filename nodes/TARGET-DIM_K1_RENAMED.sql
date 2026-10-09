@id("d5a70000-0000-4000-8000-000000000401")
@nodeType("SQLDimension")
@materializationType("view")
@description("K: every annotation, phase 2 - changed")
@tag("Cost_Centre", "HR")
@tag("PII", "false", "SRC")
@tag("OWNER", "Ops", "SRC")
@tests("SELECT 1 FROM {{ this }} WHERE 1 = 0", false, "Before")
SELECT
     "NAtionKey" AS "NATION_ID" @id("d10001") @isBusinessKey @not_null @inHash("HK", 1),
     CAST("name" AS VARCHAR(60)) AS "NATION_NAME" @id("d10002") @description("Nation name - widened") @tag("PII", "false") @tag("Cost_Centre", "HR") @inHash("HK", 2),
     "CommenT" AS "COMMENT_TEXT" @id("d10004") @description("Renamed from NATION_COMMENT") @tag("PII", "true"),
     "N_Load_Timestamp" AS "LOAD_TS" @id("d10005") @freshness(200, "YEAR") @description("Load timestamp"),
     {{ get_hash('HK') }}::STRING AS "HASH_KEY" @id("d10006") @description("Hash of key and name"),
     "REGIONKEY" * 10 AS "REGION_SCORE" @id("d1000a") @tag("OWNER", "Data"),
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("d10008") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("d10009") @isSystemUpdateDate
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
