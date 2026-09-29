@id("12eb4389-375f-4cca-bdca-e44cc6e96a35")
@nodeType("718")
@description("TC04 - lastModified SCD2 on N_LOAD_TIMESTAMP with DQ tests and two overlapping hash groups")
@mergeStrategy("lastModified")
@tests("SELECT N_NATIONKEY FROM {{ this }} WHERE SYSTEM_CURRENT_FLAG = 'Y' GROUP BY N_NATIONKEY HAVING COUNT(*) > 1", false, "After")
@tests("SELECT 1 FROM {{ this }} WHERE SYSTEM_CURRENT_FLAG = 'N' AND SYSTEM_END_DATE >= CURRENT_TIMESTAMP()", true)
SELECT
     0 AS "DIM_TC04_LM_SCD2_TESTS_KEY" @id("76e696") @isSurrogateKey @not_null @uniqueness,
     "N_NATIONKEY" AS "N_NATIONKEY" @id("16b1e6") @isBusinessKey @not_null @inHash("GH_NATION_ALL", 1),
     "N_NAME" AS "N_NAME" @id("fd77cd") @empty @inHash("GH_NATION_ALL", 2) @inHash("GH_NATION_ATTR", 1),
     "N_REGIONKEY" AS "N_REGIONKEY" @id("1946d7") @accepted_values(0, 1, 2, 3, 4) @inHash("GH_NATION_ALL", 3) @inHash("GH_NATION_ATTR", 2),
     "N_COMMENT" AS "N_COMMENT" @id("330bba") @inHash("GH_NATION_ATTR", 3),
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP" @id("6cf308") @lastModifiedTracking(2) @not_null @freshness(1, "MONTH"),
     "N_DATE" AS "N_DATE" @id("4324fd") @min_value("'1900-01-01'"),
     {{ get_hash('GH_NATION_ALL') }}::STRING AS "GH_NATION_ALL" @id("fb8626") @not_null,
     {{ get_hash('GH_NATION_ATTR', 'SHA256', '|') }}::STRING AS "GH_NATION_ATTR" @id("d55d4d"),
     1 AS "SYSTEM_VERSION" @id("cd0efc") @isSystemVersion @min_value(1),
     'Y' AS "SYSTEM_CURRENT_FLAG" @id("d58a5e") @isSystemCurrentFlag @accepted_values("'Y'", "'N'"),
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("bd7a26") @isSystemCreateDate @relative_time("<=", "SYSTEM_END_DATE"),
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("771a74") @isSystemUpdateDate @not_null,
     CAST('2999-12-31 00:00:00' AS TIMESTAMP) AS "SYSTEM_END_DATE" @id("3eff44") @isSystemEndDate @not_null
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"
