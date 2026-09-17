@id("a1d4e8f6-3b2c-4f19-9e7a-5c8b6d0f2a41")
@nodeType("4a720337-2713-45a5-b3f2-2d47d7abe3e5")
@mergeStrategy("lastModified")
SELECT
    "NATION_TEST".N_NATIONKEY               AS "BUSINESS_KEY"        @isBusinessKey,
    "NATION_TEST".N_NAME                    AS "NATION_NAME",
    "NATION_TEST".N_REGIONKEY               AS "REGION_KEY",
    "NATION_TEST".N_COMMENT                 AS "COMMENT",
    "NATION_TEST".N_LOAD_TIMESTAMP          AS "LOAD_TIMESTAMP"      @lastModifiedTracking(1),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)    AS "SYSTEM_CREATE_DATE"  @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)    AS "SYSTEM_UPDATE_DATE"  @isSystemUpdateDate
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"
