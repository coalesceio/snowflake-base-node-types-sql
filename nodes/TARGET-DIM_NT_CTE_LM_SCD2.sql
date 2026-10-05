@id("1dd22998-dd20-4684-9bc1-e4c6ebb31523")
@nodeType("SQLDimension")
@mergeStrategy("lastModified")
WITH "NATION_SRC" AS (
    SELECT "NAtionKey", "name", "REGIONKEY", "CommenT", "N_Load_Timestamp"
    FROM {{ ref('SRC', 'Nation_Test') }}
)
SELECT
    0                                        AS "DIM_NT_CTE_LM_SCD2_KEY" @id("7af7a6") @isSurrogateKey,
    "NAtionKey"                              AS "NAtionKey"              @id("58d2e6") @isBusinessKey,
    "name"                                   AS "name"                   @id("8dc0bb") @isBusinessKey,
    "REGIONKEY"                              AS "REGIONKEY"              @id("1c9cfe"),
    "CommenT"                                AS "CommenT"                @id("5d596c"),
    "N_Load_Timestamp"                       AS "N_Load_Timestamp"       @id("b1528e") @lastModifiedTracking(2),
    1                                        AS "SYSTEM_VERSION"         @id("3c8ff1") @isSystemVersion,
    'Y'                                      AS "SYSTEM_CURRENT_FLAG"    @id("7d7ae7") @isSystemCurrentFlag,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_CREATE_DATE"     @id("ba140a") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_UPDATE_DATE"     @id("9ce498") @isSystemUpdateDate,
    CAST('2999-12-31 00:00:00' AS TIMESTAMP) AS "SYSTEM_END_DATE"        @id("44d450") @isSystemEndDate
FROM "NATION_SRC"
