@id("40bac29e-2e0a-4880-bf90-103dfc90b785")
@nodeType("e35d8015-545b-4150-942f-5168dcd2bea8")

@preTests("SELECT 1 FROM {{ this }} GROUP BY N_COMMENT HAVING COUNT(*) > 1", "continuEOnFailure:SELECT 1 FROM {{ this }} GROUP BY N_COMMENT HAVING COUNT(*) > 1")
@postTests("continueOnFailure: SELECT * FROM {{ this }} WHERE N_NAME IS NULL", "SELECT * FROM {{ this }} WHERE N_REGIONKEY < 0")

SELECT
     NATION."N_NATIONKEY" AS "N_NATIONKEY" @isBusinessKey,
     NATION."N_NAME" AS "N_NAME"  @tests('NULL', 'unique'),
     NATION."N_REGIONKEY" AS "N_REGIONKEY",
     NATION."N_COMMENT" AS "N_COMMENT" @tests('unique'),
     NATION."N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP"  @tests('NULL'),
     0 AS "SYSTEM_VERSION" @isSystemVersion,
     '' AS "SYSTEM_CURRENT_FLAG" @isSystemCurrentFlag,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @isSystemUpdateDate
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION"