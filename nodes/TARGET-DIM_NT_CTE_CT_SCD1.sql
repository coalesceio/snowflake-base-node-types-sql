@id("3433e5b9-15a4-4b02-a530-802eb2155ac8")
@nodeType("Latest220:::SQLDimension")
@mergeStrategy("lastModified")
WITH "NATION_SRC" AS (
    SELECT "NAtionKey", "name", "REGIONKEY", "CommenT", "N_Load_Timestamp"
    FROM {{ ref('SRC', 'Nation_Test') }}
)
SELECT
    0                                        AS "DIM_NT_CTE_CT_SCD1_KEY" @id("5f0720") @isSurrogateKey,
    "NAtionKey"                              AS "NAtionKey"              @id("41e885") @isBusinessKey,
    "name"                                   AS "name"                   @id("9d6c5f") @isBusinessKey,
    "REGIONKEY"                              AS "REGIONKEY"              @id("cf532a"),
    "CommenT"                                AS "CommenT"                @id("deb3b5"),
    "N_Load_Timestamp"                       AS "N_Load_Timestamp"       @id("b05f4f") @lastModifiedTracking(1),
    1                                        AS "SYSTEM_VERSION"         @id("8276d2") @isSystemVersion,
    'Y'                                      AS "SYSTEM_CURRENT_FLAG"    @id("37b5fb") @isSystemCurrentFlag,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_CREATE_DATE"     @id("eaf9bb") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_UPDATE_DATE"     @id("312658") @isSystemUpdateDate,
    CAST('2999-12-31 00:00:00' AS TIMESTAMP) AS "SYSTEM_END_DATE"        @id("b2fe32") @isSystemEndDate
FROM "NATION_SRC"
