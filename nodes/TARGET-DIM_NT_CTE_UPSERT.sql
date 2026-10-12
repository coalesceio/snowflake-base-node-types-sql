@id("5d2a2dac-e5b1-48fd-9611-206f38fff80e")
@nodeType("SQLDimension")
@mergeStrategy("upsert")
WITH "NATION_SRC" AS (
    SELECT "NAtionKey", "name", "REGIONKEY", "CommenT", "N_Load_Timestamp"
    FROM {{ ref('SRC', 'Nation_Test_CamelCase') }}
)
SELECT
    0                                        AS "DIM_NT_CTE_UPSERT_KEY" @id("aca460") @isSurrogateKey,
    "NAtionKey"                              AS "NAtionKey"             @id("9b76cc") @isBusinessKey,
    "name"                                   AS "name"                  @id("83e023") @isBusinessKey,
    "REGIONKEY"                              AS "REGIONKEY"             @id("bfb273"),
    "CommenT"                                AS "CommenT"               @id("032afd"),
    "N_Load_Timestamp"                       AS "N_Load_Timestamp"      @id("6af9f2"),
    1                                        AS "SYSTEM_VERSION"        @id("4352ce") @isSystemVersion,
    'Y'                                      AS "SYSTEM_CURRENT_FLAG"   @id("c4e0d2") @isSystemCurrentFlag,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_CREATE_DATE"    @id("5fc661") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_UPDATE_DATE"    @id("46c7be") @isSystemUpdateDate,
    CAST('2999-12-31 00:00:00' AS TIMESTAMP) AS "SYSTEM_END_DATE"       @id("a5d143") @isSystemEndDate
FROM "NATION_SRC"
