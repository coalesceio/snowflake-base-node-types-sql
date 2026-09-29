@id("5a7c2e91-4b3d-4f60-9a1e-2c8d7f0b6e34")
@nodeType("718")
@description("Nation dimension (SCD2 change tracking) built from two CTEs")
@mergeStrategy("changeTracking")
WITH "NATION_SRC" AS (
    SELECT "NAtionKey", "name", "REGIONKEY", "CommenT", "N_Load_Timestamp"
    FROM {{ ref('SRC', 'Nation_Test') }}
),
"NATION_CLEAN" AS (
    SELECT "NAtionKey", UPPER(TRIM("name")) AS "NATION_NAME", "REGIONKEY", "CommenT", "N_Load_Timestamp"
    FROM "NATION_SRC"
    WHERE "NAtionKey" IS NOT NULL
)
SELECT
    0                                        AS "DIM_NT_2CTE_CT_SCD2_KEY" @id("a71c01") @description("Surrogate key, one per nation version") @isSurrogateKey,
    "NAtionKey"                              AS "NAtionKey"               @id("a71c02") @description("Nation identifier") @isBusinessKey,
    "NATION_NAME"                            AS "NATION_NAME"             @id("a71c03") @description("Nation name, trimmed and upper-cased") @isChangeTracking,
    "REGIONKEY"                              AS "REGIONKEY"               @id("a71c04") @description("Region the nation belongs to") @isChangeTracking,
    "CommenT"                                AS "CommenT"                 @id("a71c05") @description("Free-text comment"),
    "N_Load_Timestamp"                       AS "N_Load_Timestamp"        @id("a71c06") @description("Source load timestamp"),
    1                                        AS "SYSTEM_VERSION"          @id("a71c07") @isSystemVersion,
    'Y'                                      AS "SYSTEM_CURRENT_FLAG"     @id("a71c08") @isSystemCurrentFlag,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_CREATE_DATE"      @id("a71c09") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_UPDATE_DATE"      @id("a71c0a") @isSystemUpdateDate,
    CAST('2999-12-31 00:00:00' AS TIMESTAMP) AS "SYSTEM_END_DATE"         @id("a71c0b") @isSystemEndDate
FROM "NATION_CLEAN"
