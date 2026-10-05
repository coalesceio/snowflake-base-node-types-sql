@id("f7f719bf-cd3e-49b7-8ae7-defffad9fe2f")
@nodeType("SQLFact")
@materializationType("view")
@writeMode("truncateInsert")
SELECT
    "NATION_TEST"."N_NATIONKEY"                 AS "N_NATIONKEY"        @id("0d0601"),
    "NATION_TEST"."N_NAME"                      AS "N_NAME"             @id("0d0602"),
    "NATION_TEST"."N_REGIONKEY"                 AS "N_REGIONKEY"        @id("0d0603"),
    "NATION_TEST"."N_COMMENT"                   AS "N_COMMENT"          @id("0d0604"),
    "NATION_TEST"."N_LOAD_TIMESTAMP"            AS "N_LOAD_TIMESTAMP"   @id("0d0605"),
    "NATION_TEST"."N_DATE"                      AS "N_DATE"             @id("0d0606"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("0d0607") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("0d0608") @isSystemUpdateDate
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"
