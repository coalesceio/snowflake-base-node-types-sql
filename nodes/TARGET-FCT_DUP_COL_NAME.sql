@id("c3e5a7b9-2d4f-4b83-8c15-3e7a9c1d2f43")
@nodeType("SQLFact")
SELECT
    "N_NATIONKEY"                        AS "N_NATIONKEY"        @id("c30001"),
    "N_NAME"                             AS "N_NAME"             @id("c30002"),
    "N_REGIONKEY"                        AS "N_REGIONKEY"        @id("c30003"),
    "N_COMMENT"                          AS "N_COMMENT"          @id("c30004"),
    "N_LOAD_TIMESTAMP"                   AS "N_LOAD_TIMESTAMP"   @id("c30005"),
    "N_DATE"                             AS "N_DATE"             @id("c30006"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("c30007") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("c30008") @isSystemUpdateDate
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"
