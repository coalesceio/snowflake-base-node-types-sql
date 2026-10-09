@id("d5a70000-0000-4000-8000-000000000301")
@nodeType("SQLWork")
@materializationType("view")
@description("K: every annotation, phase 2 - changed")
@tag("Cost_Centre", "HR")
@tag("PII", "false", "SRC")
@tag("OWNER", "Ops", "SRC")
@tests("SELECT 1 FROM {{ this }} WHERE 1 = 0", false, "Before")
SELECT
     "NAtionKey" AS "NATION_ID" @id("c10001") @not_null @inHash("HK", 1),
     CAST("name" AS VARCHAR(60)) AS "NATION_NAME" @id("c10002") @description("Nation name - widened") @tag("PII", "false") @tag("Cost_Centre", "HR") @inHash("HK", 2),
     "CommenT" AS "COMMENT_TEXT" @id("c10004") @description("Renamed from NATION_COMMENT") @tag("PII", "true"),
     "N_Load_Timestamp" AS "LOAD_TS" @id("c10005") @freshness(200, "YEAR") @description("Load timestamp"),
     {{ get_hash('HK') }}::STRING AS "HASH_KEY" @id("c10006") @description("Hash of key and name"),
     "REGIONKEY" * 10 AS "REGION_SCORE" @id("c1000a") @tag("OWNER", "Data")
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
