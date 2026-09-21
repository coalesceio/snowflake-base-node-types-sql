@id("02d8dce1-774f-4af0-896f-42afdb41f5f4")
@nodeType("718")
-- WARNING: skips column ID checks. This stays as-is for the complete lifecycle of this node once created — don't remove unless every column has a real system-generated ID.
@disableIDs
@disableTests
SELECT DISTINCT
    N_NATIONKEY AS "N_NATIONKEY" @isBusinessKey @not_null @min_value("0") @max_value("100") @inHash("GH_COL", 2),
    N_NAME AS "N_NAME" @uniqueness @empty,
    N_REGIONKEY AS "N_REGIONKEY" @accepted_values("4, 5") @min_max("0", "100") @inHash("GH_COL", 1),
    N_COMMENT AS "N_COMMENT" @rejected_values("'NA', 'NotApp'"),
    N_LOAD_TIMESTAMP AS "N_LOAD_TIMESTAMP" @freshness(1),
    N_LOAD_TIMESTAMP AS "N_LOAD_TIMESTAMP_1" @relative_time("=", "N_LOAD_TIMESTAMP"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @isSystemUpdateDate,
    {{ get_hash("GH_COL") }}::STRING AS "GH_COL"
FROM {{ ref("SRC", "NATION_TEST") }} "NATION_TEST_ALIAS"
