@id("a1c3e5f7-0b2d-4f61-8a93-1c5e7a9b0d21")
@nodeType("SQLFact")
SELECT
    "N_NATIONKEY"                        AS "N_NATIONKEY"        @id("a10001"),
    "N_NAME"                             AS "N_NAME"             @id("a10002"),
    "N_REGIONKEY"                        AS "N_REGIONKEY"        @id("a10002"),
    "N_COMMENT"                          AS "N_COMMENT"          @id("a10004"),
    "N_LOAD_TIMESTAMP"                   AS "N_LOAD_TIMESTAMP"   @id("a10005"),
    "N_DATE"                             AS "N_DATE"             @id("a10006"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("a10007") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("a10008") @isSystemUpdateDate
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"
