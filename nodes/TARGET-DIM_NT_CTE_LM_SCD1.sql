@id("318a874f-be4c-4b27-9ea5-ccd6b068f64b")
@nodeType("718")
@mergeStrategy("lastModified")
WITH "NATION_SRC" AS (
    SELECT "NAtionKey", "name", "REGIONKEY", "CommenT", "N_Load_Timestamp"
    FROM {{ ref('SRC', 'Nation_Test') }}
)
SELECT
    0                                        AS "DIM_NT_CTE_LM_SCD1_KEY" @id("abe2c5") @isSurrogateKey,
    "NAtionKey"                              AS "NAtionKey"              @id("914de2") @isBusinessKey,
    "name"                                   AS "name"                   @id("2c2817") @isBusinessKey,
    "REGIONKEY"                              AS "REGIONKEY"              @id("cda434"),
    "CommenT"                                AS "CommenT"                @id("84477a"),
    "N_Load_Timestamp"                       AS "N_Load_Timestamp"       @id("737d79") @lastModifiedTracking(1),
    1                                        AS "SYSTEM_VERSION"         @id("0f09c2") @isSystemVersion,
    'Y'                                      AS "SYSTEM_CURRENT_FLAG"    @id("36a4da") @isSystemCurrentFlag,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_CREATE_DATE"     @id("45a459") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_UPDATE_DATE"     @id("699bff") @isSystemUpdateDate
FROM "NATION_SRC"
