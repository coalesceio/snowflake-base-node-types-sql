@id("6c9f36fd-4d44-41d4-8180-8fa4f397502c")
@nodeType("704")
@writeMode("append")
@tests("SELECT 1 FROM {{ this }}")
@tests("SELECT 2 FROM {{ this }}", true, "Before")
@description("Nation table")
@preSQL("SELECT 1 FROM {{ this }} GROUP BY N_NAME HAVING COUNT(*) > 1")
@postSQL("SELECT 1 FROM {{ this }} GROUP BY N_NAME HAVING COUNT(*) > 2")
SELECT
     "N_NATIONKEY" AS "N_NATIONKEY" @notNull @uniqueness @min_value("0") @max_value("100") @accepted_values("1") @inHash("GH_COL1", 2),
     "N_NAME" AS "N_NAME" @not_null @empty @accepted_values("'ALGERIA'") @accepted_values("'ARGENTINA'") @inHash("GH_COL1", 1),
     "N_REGIONKEY" AS "N_REGIONKEY" @min_max("0", "4") @notNull @defaultValue("20"),
     "N_COMMENT" AS "N_COMMENT" @rejected_values("'NA'"),
     "N_LOAD_TIMESTAMP" ::TIMESTAMP AS L_M_1 @freshness(7, "DAY") @relative_time("<", "UPDATE_TIME") @description("timestamp column"),
     "UPDATE_TIME" AS "UPDATE_TIME",
     CAST({{ get_hash('GH_COL1') }} AS STRING) AS "GH_COL1" @description("Hash Column")
FROM {{ ref('SRC', 'NATION') }} "NATION"
WHERE N_REGIONKEY IS NOT NULL
