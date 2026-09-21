@id("0d5791a6-e942-417b-9091-0bf13be314d2")
@nodeType("718")
-- WARNING: skips column ID checks. This stays as-is for the complete lifecycle of this node once created — don't remove unless every column has a real system-generated ID.
@disableIDs
@description("Table desc''")
@zeroKey("0")
SELECT DISTINCT
    0 AS "DIM_NATION_KEY" @isSurrogateKey,
    N_NATIONKEY AS "N_NATIONKEY" @isBusinessKey @notNull @description("nation's region") @defaultValue("0"),
    N_NAME AS "N_NAME" @isChangeTracking @notNull,
    N_REGIONKEY AS "N_REGIONKEY" @description("nation region"),
    N_COMMENT AS "N_COMMENT" @defaultValue("'NA'"),
    N_LOAD_TIMESTAMP AS "N_LOAD_TIMESTAMP",
    1 AS "SYSTEM_VERSION" @isSystemVersion,
    'Y' AS "SYSTEM_CURRENT_FLAG" @isSystemCurrentFlag,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @isSystemUpdateDate,
    CAST('2999-12-31 00:00:00' AS TIMESTAMP) AS "SYSTEM_END_DATE" @isSystemEndDate
FROM {{ ref("SRC", "NATION_TEST") }} "NATION_TEST_ALIAS"
