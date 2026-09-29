@id("4a23c7f3-886f-4327-982e-d02415bfb865")
@nodeType("718")
@mergeStrategy("changeTracking")
SELECT
    0                                        AS "DIM_NT_CT_SCD2_KEY"  @id("76e88f") @isSurrogateKey,
    "NAtionKey"                              AS "NAtionKey"           @id("89a2f7") @isBusinessKey,
    "name"                                   AS "name"                @id("c5a8f2") @isBusinessKey,
    "REGIONKEY"                              AS "REGIONKEY"           @id("3161b5"),
    "CommenT"                                AS "CommenT"             @id("a8efdb"),
    "N_Load_Timestamp"                       AS "N_Load_Timestamp"    @id("2cca3f"),
    1                                        AS "SYSTEM_VERSION"      @id("b67c27") @isSystemVersion,
    'Y'                                      AS "SYSTEM_CURRENT_FLAG" @id("bae0c9") @isSystemCurrentFlag,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_CREATE_DATE"  @id("b8c7c6") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_UPDATE_DATE"  @id("6662b6") @isSystemUpdateDate,
    CAST('2999-12-31 00:00:00' AS TIMESTAMP) AS "SYSTEM_END_DATE"     @id("3c2ea9") @isSystemEndDate
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
