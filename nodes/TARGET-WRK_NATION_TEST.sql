@id("16cfea76-6d05-419f-b365-85883aa9b6f1")
@nodeType("704")
@testsEnabled
@truncateBefore
@tests("SELECT 1 FROM {{ this }}")
@tests("SELECT 2 FROM {{ this }}", "Before", true)
@tests("SELECT 3 FROM {{ this }}", "After", true)
@tests("SELECT 4 FROM {{ this }}", "After", true)
@preSQL("SELECT 1 FROM {{ this }} GROUP BY N_COMMENT HAVING COUNT(*) > 1")
@postSQL("SELECT 1 FROM {{ this }} GROUP BY N_COMMENT HAVING COUNT(*) > 2")
@preSQL("SELECT 1 FROM {{ this }} GROUP BY N_COMMENT HAVING COUNT(*) > 3")
@postSQL("SELECT 1 FROM {{ this }} GROUP BY N_COMMENT HAVING COUNT(*) > 4")
@description("Table comment ''ahdflj")
SELECT
     "N_NATIONKEY" AS "N_NATIONKEY" @tests("unique") @inHash("GH_COL1", 2),
     "N_NAME" AS "N_NAME" @inHash("GH_COL2", 1),
     "N_REGIONKEY" AS "N_REGIONKEY"  @tests("null") @tests("unique") @inHash("GH_COL1", 1) @inHash("GH_COL2", 2),
     "N_COMMENT" AS "N_COMMENT" @description("'Nation Comment'") @defaultValue("'NA'") @notNull,
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP" @tests("null") @defaultValue("current_timestamp()"),
     {{ get_hash('GH_COL1') }}::STRING AS "GH_COL1" @defaultValue("NULL"),
     {{ get_hash('GH_COL2') }}::STRING AS "GH_COL2"
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"
WHERE N_NATIONKEY > {{ parameters.nationkey }}