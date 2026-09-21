@id("6be73b19-cac2-403f-bc16-a1115eeb235a")
@nodeType("718")
@deployDisabled
-- WARNING: skips column ID checks. This stays as-is for the complete lifecycle of this node once created — don't remove unless every column has a real system-generated ID.
@disableIDs
-- Load history before loading change tracked load into target
@preSQL('INSERT INTO {{ ref("SRC", "NATION_TEST_HISTORY") }} SELECT * FROM {{ ref("SRC", "NATION_TEST") }}')
SELECT DISTINCT
    N_NATIONKEY AS "N_NATIONKEY" @isBusinessKey,
    N_NAME AS "N_NAME",
    N_REGIONKEY AS "N_REGIONKEY",
    N_COMMENT AS "N_COMMENT",
    N_LOAD_TIMESTAMP AS "N_LOAD_TIMESTAMP",
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @isSystemUpdateDate
FROM {{ ref("SRC", "NATION_TEST") }} "NATION_TEST_ALIAS"
