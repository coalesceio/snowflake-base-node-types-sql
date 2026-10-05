@id("b2d4f6a8-1c3e-4a72-9b04-2d6f8b0c1e32")
@nodeType("SQLFact")
SELECT
    "N_NATIONKEY"                        AS "N_NATIONKEY"        @id("b20001"),
    "N_NAME"                             AS "N_NAME"             @id("b20001"),
    "N_REGIONKEY"                        AS "N_REGIONKEY"        @id("b20001"),
    "N_COMMENT"                          AS "N_COMMENT"          @id("b20004"),
    "N_LOAD_TIMESTAMP"                   AS "N_LOAD_TIMESTAMP"   @id("b20004"),
    "N_DATE"                             AS "N_DATE"             @id("b20006"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("b20007") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("b20008") @isSystemUpdateDate
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"
