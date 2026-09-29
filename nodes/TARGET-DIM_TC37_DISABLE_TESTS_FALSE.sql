@id("393a7706-3ff8-4aff-802b-7c7d23392a98")
@nodeType("718")
@description("TC37 - @disableTests set to false: same failing tests as TC36 must now run and report failures (continue on failure)")
@mergeStrategy("changeTracking")
@disableTests("false")
@tests("SELECT 1", true, "After")
@tests("SELECT 1", true, "Before")
SELECT
     0 AS "DIM_TC37_DISABLE_TESTS_FALSE_KEY" @id("ea950b") @isSurrogateKey,
     "N_NATIONKEY" AS "N_NATIONKEY" @id("06b631") @isBusinessKey @max_value("-100"),
     "N_NAME" AS "N_NAME" @id("785a95") @accepted_values("'NOT_A_NATION'") @empty,
     "N_REGIONKEY" AS "N_REGIONKEY" @id("647f95") @rejected_values("0, 1, 2, 3, 4"),
     "N_COMMENT" AS "N_COMMENT" @id("7791ad"),
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP" @id("e2ec71"),
     "N_DATE" AS "N_DATE" @id("6ffed8"),
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("3905bb") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("62f23c") @isSystemUpdateDate
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"
