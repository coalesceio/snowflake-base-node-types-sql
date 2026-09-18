@id("86c044f2-9d13-44e3-8fd0-ea2bd96b1435")
@nodeType("718")
@mergeStrategy("changeTracking")
SELECT
    "NATION_TEST".N_NATIONKEY               AS "BUSINESS_KEY"        @isBusinessKey,
    "NATION_TEST".N_NAME                    AS "NATION_NAME",
    "NATION_TEST".N_REGIONKEY               AS "REGION_KEY",
    "NATION_TEST".N_COMMENT                 AS "COMMENT",
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)    AS "SYSTEM_CREATE_DATE"   @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)    AS "SYSTEM_UPDATE_DATE"   @isSystemUpdateDate
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"
