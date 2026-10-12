@id("ac7b3e27-ad3e-4088-b0e8-956625d1248b")
@nodeType("SQLDimension")
@mergeStrategy("upsert")
SELECT
    0                                        AS "DIM_NT_UPSERT_KEY"   @id("275e2b") @isSurrogateKey,
    "NAtionKey"                              AS "NAtionKey"           @id("89da7e") @isBusinessKey,
    "name"                                   AS "name"                @id("bd39e4") @isBusinessKey,
    "REGIONKEY"                              AS "REGIONKEY"           @id("8c1e19"),
    "CommenT"                                AS "CommenT"             @id("8297ac"),
    "N_Load_Timestamp"                       AS "N_Load_Timestamp"    @id("90f066"),
    1                                        AS "SYSTEM_VERSION"      @id("de748f") @isSystemVersion,
    'Y'                                      AS "SYSTEM_CURRENT_FLAG" @id("863af0") @isSystemCurrentFlag,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_CREATE_DATE"  @id("fc776c") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_UPDATE_DATE"  @id("5719c4") @isSystemUpdateDate,
    CAST('2999-12-31 00:00:00' AS TIMESTAMP) AS "SYSTEM_END_DATE"     @id("369407") @isSystemEndDate
FROM {{ ref('SRC', 'Nation_Test_CamelCase') }} "Nation_Test_CamelCase"
