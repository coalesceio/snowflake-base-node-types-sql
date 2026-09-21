@id("9c9cae0d-d0ac-4ad0-b033-fd49d1f27971")
@nodeType("718")
-- WARNING: skips column ID checks. This stays as-is for the complete lifecycle of this node once created — don't remove unless every column has a real system-generated ID.
@disableIDs
@mergeStrategy("lastModified")
SELECT DISTINCT
    0 AS "DIM_NATION_KEY" @isSurrogateKey,
    N_NATIONKEY AS "N_NATIONKEY" @isBusinessKey @notNull @description("key") @defaultValue("0") @inHash("GH_COL", 2),
    N_NAME AS "N_NAME" @description("name"),
    N_REGIONKEY AS "N_REGIONKEY" @notNull @inHash("GH_COL", 1),
    N_COMMENT AS "N_COMMENT" @defaultValue("'NA'"),
    N_LOAD_TIMESTAMP AS "N_LOAD_TIMESTAMP" @lastModifiedTracking,
    {{get_hash("GH_COL")}}::STRING AS "GH_COL",
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @isSystemUpdateDate
FROM {{ ref("SRC", "NATION_TEST") }} "NATION_TEST_ALIAS"
