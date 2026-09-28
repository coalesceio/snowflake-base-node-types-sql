@id("650cec96-6ff7-4c9c-acd8-1c8e7a064dda")
@nodeType("718")
@mergeStrategy("lastModified")
SELECT
    0                                        AS "DIM_NT_LM_SCD2_KEY"  @id("41bba9") @isSurrogateKey,
    "NAtionKey"                              AS "NAtionKey"           @id("53a14b") @isBusinessKey,
    "name"                                   AS "name"                @id("8c65b0") @isBusinessKey,
    "REGIONKEY"                              AS "REGIONKEY"           @id("229643"),
    "CommenT"                                AS "CommenT"             @id("9d21e3"),
    "N_Load_Timestamp"                       AS "N_Load_Timestamp"    @id("39a701") @lastModifiedTracking(2),
    1                                        AS "SYSTEM_VERSION"      @id("1256f6") @isSystemVersion,
    'Y'                                      AS "SYSTEM_CURRENT_FLAG" @id("fa5338") @isSystemCurrentFlag,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_CREATE_DATE"  @id("9544fd") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_UPDATE_DATE"  @id("e1ee65") @isSystemUpdateDate,
    CAST('2999-12-31 00:00:00' AS TIMESTAMP) AS "SYSTEM_END_DATE"     @id("79c87c") @isSystemEndDate
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
