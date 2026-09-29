@id("99ee30b6-68a3-4530-b3f6-708231e5dc1f")
@nodeType("718")
@description("TC03 - lastModified SCD1 on N_LOAD_TIMESTAMP with DQ tests and SHA256 hash of the business key")
@mergeStrategy("lastModified")
@tests("SELECT 1 FROM {{ this }} GROUP BY N_NATIONKEY HAVING COUNT(*) > 1", false)
@tests("SELECT 1 FROM {{ this }} WHERE N_LOAD_TIMESTAMP > CURRENT_TIMESTAMP()", true, "After")
SELECT
     0 AS "DIM_TC03_LM_SCD1_TESTS_KEY" @id("b1943e") @isSurrogateKey @uniqueness,
     "N_NATIONKEY" AS "N_NATIONKEY" @id("944698") @isBusinessKey @not_null @uniqueness @inHash("GH_NATION_BK", 1),
     "N_NAME" AS "N_NAME" @id("3fa6df") @not_null @rejected_values("''") @inHash("GH_NATION_BK", 2),
     "N_REGIONKEY" AS "N_REGIONKEY" @id("5bcd50") @min_max(0, 4),
     "N_COMMENT" AS "N_COMMENT" @id("9ef3e3") @empty,
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP" @id("d52dd6") @lastModifiedTracking(1) @not_null @freshness(7, "DAY") @relative_time("<=", "SYSTEM_UPDATE_DATE"),
     "N_DATE" AS "N_DATE" @id("e2458a") @not_null,
     {{ get_hash('GH_NATION_BK', 'SHA256') }}::STRING AS "GH_NATION_BK" @id("43834a") @not_null @uniqueness,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("0096cf") @isSystemCreateDate @not_null,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("5c5ebd") @isSystemUpdateDate @not_null
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"
