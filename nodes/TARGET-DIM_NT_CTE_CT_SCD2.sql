@id("15d51fc4-366d-4fd4-a546-e997a1226e01")
@nodeType("Latest220:::SQLDimension")
@mergeStrategy("changeTracking")
WITH "NATION_SRC" AS (
    SELECT "NAtionKey", "name", "REGIONKEY", "CommenT", "N_Load_Timestamp"
    FROM {{ ref('SRC', 'Nation_Test') }}
)
SELECT
    0                                        AS "DIM_NT_CTE_CT_SCD2_KEY" @id("338cff") @isSurrogateKey,
    "NAtionKey"                              AS "NAtionKey"              @id("eef9e5") @isBusinessKey,
    "name"                                   AS "name"                   @id("4ef3a9") @isBusinessKey,
    "REGIONKEY"                              AS "REGIONKEY"              @id("f294e3") @isChangeTracking,
    "CommenT"                                AS "CommenT"                @id("3fff66"),
    "N_Load_Timestamp"                       AS "N_Load_Timestamp"       @id("816cf2"),
    1                                        AS "SYSTEM_VERSION"         @id("2d0e7f") @isSystemVersion,
    'Y'                                      AS "SYSTEM_CURRENT_FLAG"    @id("341936") @isSystemCurrentFlag,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_CREATE_DATE"     @id("bc7b35") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_UPDATE_DATE"     @id("dfef0b") @isSystemUpdateDate,
    CAST('2999-12-31 00:00:00' AS TIMESTAMP) AS "SYSTEM_END_DATE"        @id("024c41") @isSystemEndDate
FROM "NATION_SRC"
