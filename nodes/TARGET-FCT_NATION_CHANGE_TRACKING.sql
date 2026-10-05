@id("f6b8d0e2-5a7c-4eb6-9f48-6b0d2f4a5c76")
@nodeType("SQLFact")
@mergeStrategy("changeTracking")
SELECT
    "N_NATIONKEY"                        AS "N_NATIONKEY"        @id("f60001") @isBusinessKey,
    "N_NAME"                             AS "N_NAME"             @id("f60002"),
    "N_REGIONKEY"                        AS "N_REGIONKEY"        @id("f60003"),
    "N_COMMENT"                          AS "N_COMMENT"          @id("f60004"),
    "N_LOAD_TIMESTAMP"                   AS "N_LOAD_TIMESTAMP"   @id("f60005"),
    "N_DATE"                             AS "N_DATE"             @id("f60006"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("f60007") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("f60008") @isSystemUpdateDate
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"
