@id("7a5ba443-2500-4319-a6bc-08489d706a2e")
@nodeType("718")
SELECT
    0                                        AS "DIM_NT_DEFAULT_KEY"  @id("f261b5") @isSurrogateKey,
    "NAtionKey"                              AS "NAtionKey"           @id("672f16") @isBusinessKey,
    "name"                                   AS "name"                @id("0ae366") @isBusinessKey,
    "REGIONKEY"                              AS "REGIONKEY"           @id("5130ad"),
    "CommenT"                                AS "CommenT"             @id("4c5776"),
    "N_Load_Timestamp"                       AS "N_Load_Timestamp"    @id("be94dd"),
    1                                        AS "SYSTEM_VERSION"      @id("397e40") @isSystemVersion,
    'Y'                                      AS "SYSTEM_CURRENT_FLAG" @id("782928") @isSystemCurrentFlag,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_CREATE_DATE"  @id("7fc576") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_UPDATE_DATE"  @id("5f418f") @isSystemUpdateDate,
    CAST('2999-12-31 00:00:00' AS TIMESTAMP) AS "SYSTEM_END_DATE"     @id("7f502f") @isSystemEndDate
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
