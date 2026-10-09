@id("25ff7619-0229-415b-bee5-a448ad857253")
@nodeType("Latest220:::SQLDimension")
@mergeStrategy("changeTracking")
SELECT
    0                                        AS "DIM_NT_CT_SCD1_KEY"  @id("b080b3") @isSurrogateKey,
    "NAtionKey"                              AS "NAtionKey"           @id("46f09f") @isBusinessKey,
    "name"                                   AS "name"                @id("4e1754") @isBusinessKey,
    "REGIONKEY"                              AS "REGIONKEY"           @id("58f98a") @isChangeTracking,
    "CommenT"                                AS "CommenT"             @id("4eae04"),
    "N_Load_Timestamp"                       AS "N_Load_Timestamp"    @id("c76bfe"),
    1                                        AS "SYSTEM_VERSION"      @id("7762f4") @isSystemVersion,
    'Y'                                      AS "SYSTEM_CURRENT_FLAG" @id("423675") @isSystemCurrentFlag,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_CREATE_DATE"  @id("b7aec5") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_UPDATE_DATE"  @id("34567d") @isSystemUpdateDate,
    CAST('2999-12-31 00:00:00' AS TIMESTAMP) AS "SYSTEM_END_DATE"     @id("e1d5c1") @isSystemEndDate
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
