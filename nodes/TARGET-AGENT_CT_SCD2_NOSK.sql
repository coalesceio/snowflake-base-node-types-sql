@id("306ecbc9-cb3d-407b-89e9-1f2b2fca24eb")
@nodeType("718")
-- WARNING: skips column ID checks. This stays as-is for the complete lifecycle of this node once created — don't remove unless every column has a real system-generated ID.
@disableIDs
@mergeStrategy("changeTracking")
SELECT DISTINCT
    {{ ref('SRC', 'DIM_NATION_TEST_SEQ') }}.NEXTVAL::STRING AS "DIM_NATION_KEY",
    N_NATIONKEY AS "N_NATIONKEY" @isBusinessKey,
    N_NAME AS "N_NAME" @isChangeTracking,
    N_REGIONKEY AS "N_REGIONKEY",
    N_COMMENT AS "N_COMMENT",
    N_LOAD_TIMESTAMP AS "N_LOAD_TIMESTAMP",
    1 AS "SYSTEM_VERSION" @isSystemVersion,
    'Y' AS "SYSTEM_CURRENT_FLAG" @isSystemCurrentFlag,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @isSystemUpdateDate,
    CAST('2999-12-31 00:00:00' AS TIMESTAMP) AS "SYSTEM_END_DATE" @isSystemEndDate
FROM {{ ref("SRC", "NATION_TEST") }} "NATION_TEST_ALIAS"
