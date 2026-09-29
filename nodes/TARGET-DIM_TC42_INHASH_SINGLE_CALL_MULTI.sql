@id("5c87ae2d-16cc-43c9-8957-5b921302428c")
@nodeType("718")
@description("TC42 - README form: one @inHash call carrying two hash groups (GH_A position 1, GH_B position 2)")
@mergeStrategy("changeTracking")
SELECT
     0 AS "DIM_TC42_INHASH_SINGLE_CALL_MULTI_KEY" @id("3d393d") @isSurrogateKey,
     "N_NATIONKEY" AS "N_NATIONKEY" @id("04cc34") @isBusinessKey @not_null,
     "N_NAME" AS "N_NAME" @id("a29f03") @inHash("GH_A", 1, "GH_B", 2),
     "N_REGIONKEY" AS "N_REGIONKEY" @id("b49e65") @inHash("GH_A", 2),
     "N_COMMENT" AS "N_COMMENT" @id("4ec45b") @inHash("GH_B", 1),
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP" @id("5b2dd1"),
     "N_DATE" AS "N_DATE" @id("b25a78"),
     {{ get_hash('GH_A') }}::STRING AS "GH_A" @id("4380f1") @not_null,
     {{ get_hash('GH_B', delimiter='~') }}::STRING AS "GH_B" @id("a0a32c") @not_null,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("251455") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("2d38ab") @isSystemUpdateDate
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"
