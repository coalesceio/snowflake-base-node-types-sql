@id("8c51031b-383e-427b-b5af-386035acd330")
@nodeType("718")
@mergeStrategy("changeTracking")
SELECT
    N_NATIONKEY AS "N_NATIONKEY" @id("7f9534") @isBusinessKey,
    N_NAME AS "N_NAME" @id("ebd6b9"),
    N_REGIONKEY AS "N_REGIONKEY" @id("b62c1a"),
    N_COMMENT AS "N_COMMENT" @id("07c481"),
    N_LOAD_TIMESTAMP AS "N_LOAD_TIMESTAMP" @id("116378"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("599487") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("0b500c") @isSystemUpdateDate
FROM {{ ref("SRC", "NATION_TEST") }}
