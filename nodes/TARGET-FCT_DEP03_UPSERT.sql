@id("49f38673-0249-4f71-ad3c-50c2bc956fdb")
@nodeType("SQLFact")
@mergeStrategy("upsert")
SELECT
    "NATION_TEST"."N_NATIONKEY"                 AS "N_NATIONKEY"        @id("0d0301") @isBusinessKey,
    "NATION_TEST"."N_NAME"                      AS "N_NAME"             @id("0d0302"),
    "NATION_TEST"."N_REGIONKEY"                 AS "N_REGIONKEY"        @id("0d0303"),
    "NATION_TEST"."N_COMMENT"                   AS "N_COMMENT"          @id("0d0304"),
    "NATION_TEST"."N_LOAD_TIMESTAMP"            AS "N_LOAD_TIMESTAMP"   @id("0d0305"),
    "NATION_TEST"."N_DATE"                      AS "N_DATE"             @id("0d0306"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("0d0307") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("0d0308") @isSystemUpdateDate
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"
