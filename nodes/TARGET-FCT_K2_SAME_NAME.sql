@id("d5a70000-0000-4000-8000-000000000502")
@nodeType("SQLFact")
@materializationType("table")
@description("K: every annotation, phase 2 - changed")
@tag("Cost_Centre", "HR")
@tag("PII", "false", "SRC")
@tag("OWNER", "Ops", "SRC")
@writeMode("append")
@tests("SELECT 1 FROM {{ this }} WHERE 1 = 0", false, "Before")
@preSQL("SELECT 11 AS PRE_TWO")
@postSQL("SELECT 22 AS POST_TWO")
@postSQL("SELECT 23 AS POST_THREE")
SELECT
     "NAtionKey" AS "NATION_ID" @id("e20001") @isBusinessKey @clusterKey(1) @not_null @inHash("HK", 1),
     CAST("name" AS VARCHAR(60)) AS "NATION_NAME" @id("e20002") @description("Nation name - widened") @tag("PII", "false") @tag("Cost_Centre", "HR") @clusterKey(2, "substr(""NATION_NAME"", 1, 3)") @inHash("HK", 2),
     "CommenT" AS "COMMENT_TEXT" @id("e20004") @description("Renamed from NATION_COMMENT") @tag("PII", "true"),
     "N_Load_Timestamp" AS "LOAD_TS" @id("e20005") @freshness(200, "YEAR") @description("Load timestamp"),
     {{ get_hash('HK') }}::STRING AS "HASH_KEY" @id("e20006") @description("Hash of key and name"),
     "REGIONKEY" * 10 AS "REGION_SCORE" @id("e2000a") @defaultValue("0") @clusterKey(3) @tag("OWNER", "Data"),
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("e20008") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("e20009") @isSystemUpdateDate
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
