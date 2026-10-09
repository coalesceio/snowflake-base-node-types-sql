@id("d5a70000-0000-4000-8000-000000000501")
@nodeType("SQLFact")
@materializationType("table")
@description("K: every annotation, phase 1")
@tag("Cost_Centre", "FIN")
@tag("OWNER", "Tanvi")
@tag("PII", "false", "SRC")
@writeMode("truncateInsert")
@tests("SELECT 1 FROM {{ this }} WHERE 1 = 0", true, "After")
@preSQL("SELECT 1 AS PRE_ONE")
@postSQL("SELECT 2 AS POST_ONE")
SELECT
     "NAtionKey" AS "NATION_KEY" @id("e10001") @isBusinessKey @notNull @clusterKey(1) @not_null @uniqueness @inHash("HK", 1),
     CAST("name" AS VARCHAR(25)) AS "NATION_NAME" @id("e10002") @description("Nation name") @tag("PII", "true") @tag("OWNER", "Data") @clusterKey(2, "substr(""NATION_NAME"", 1, 2)") @inHash("HK", 2) @empty,
     "REGIONKEY" AS "REGION_KEY" @id("e10003") @defaultValue("0") @min_max(0, 10) @tag("Cost_Centre", "FIN") @clusterKey(3),
     "CommenT" AS "NATION_COMMENT" @id("e10004") @rejected_values("'NA'"),
     "N_Load_Timestamp" AS "LOAD_TS" @id("e10005") @freshness(100, "YEAR"),
     {{ get_hash('HK') }}::STRING AS "HASH_KEY" @id("e10006") @description("Hash of key and name"),
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("e10008") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("e10009") @isSystemUpdateDate
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
