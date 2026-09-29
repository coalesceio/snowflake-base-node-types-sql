@id("2c17272f-c5bd-41c5-ba10-958c63d7d6ae")
@nodeType("718")
@description("TC36 - @disableTests: every node and column test below would fail, so none of them should run")
@mergeStrategy("changeTracking")
@disableTests
@tests("SELECT 1", true, "After")
@tests("SELECT 1", true, "Before")
SELECT
     0 AS "DIM_TC36_DISABLE_TESTS_KEY" @id("cb66b9") @isSurrogateKey,
     "N_NATIONKEY" AS "N_NATIONKEY" @id("98f53e") @isBusinessKey @max_value("-100"),
     "N_NAME" AS "N_NAME" @id("b67374") @accepted_values("'NOT_A_NATION'") @empty,
     "N_REGIONKEY" AS "N_REGIONKEY" @id("f5b2c9") @rejected_values("0, 1, 2, 3, 4"),
     "N_COMMENT" AS "N_COMMENT" @id("0d4207"),
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP" @id("01239d"),
     "N_DATE" AS "N_DATE" @id("7ce2df"),
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("b36142") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("aa1e58") @isSystemUpdateDate
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"
