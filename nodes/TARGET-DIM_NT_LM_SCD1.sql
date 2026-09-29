@id("4d5e9bda-180b-4845-ab81-214fd52c4564")
@nodeType("718")
@mergeStrategy("lastModified")
SELECT
    0                                        AS "DIM_NT_LM_SCD1_KEY"  @id("eb0696") @isSurrogateKey,
    "NAtionKey"                              AS "NAtionKey"           @id("9700dc") @isBusinessKey,
    "name"                                   AS "name"                @id("9d8cdd") @isBusinessKey,
    "REGIONKEY"                              AS "REGIONKEY"           @id("ea2d5e"),
    "CommenT"                                AS "CommenT"             @id("ca2ca9"),
    "N_Load_Timestamp"                       AS "N_Load_Timestamp"    @id("8bdecf") @lastModifiedTracking(2),
    1                                        AS "SYSTEM_VERSION"      @id("a1388a") @isSystemVersion,
    'Y'                                      AS "SYSTEM_CURRENT_FLAG" @id("498a84") @isSystemCurrentFlag,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_CREATE_DATE"  @id("db4e08") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_UPDATE_DATE"  @id("7d2867") @isSystemUpdateDate,
    CAST('2999-12-31 00:00:00' AS TIMESTAMP) AS "SYSTEM_END_DATE"     @id("8f56fe") @isSystemEndDate
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
