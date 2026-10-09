@id("d5a70000-0000-4000-8000-000000000404")
@nodeType("SQLDimension")
@materializationType("table")
@zeroKey("-1", "'UNKNOWN'", "1900-01-01 00:00:00", false)
@tag("Cost_Centre", "FIN")
SELECT
     "NAtionKey" * 100 AS "DIM_SK" @id("d4000b") @isSurrogateKey,
     "NAtionKey" AS "NATION_KEY" @id("d40001") @isBusinessKey @clusterKey(1),
     "name" AS "NATION_NAME" @id("d40002") @isChangeTracking @zeroKey("'N/A'") @tag("PII", "true"),
     "REGIONKEY" AS "REGION_KEY" @id("d40003") @isChangeTracking,
     "CommenT" AS "NATION_COMMENT" @id("d40004"),
     "N_Load_Timestamp" AS "LOAD_TS" @id("d40005"),
     1 AS "SYSTEM_VERSION" @id("d4000c") @isSystemVersion,
     'Y' AS "SYSTEM_CURRENT_FLAG" @id("d4000d") @isSystemCurrentFlag,
     CAST('2999-12-31 00:00:00' AS TIMESTAMP) AS "SYSTEM_END_DATE" @id("d4000e") @isSystemEndDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("d40008") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("d40009") @isSystemUpdateDate
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
