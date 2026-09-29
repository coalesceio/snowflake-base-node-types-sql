@id("360ab446-eadc-432e-985a-8f2a7408109e")
@nodeType("718")
@mergeStrategy("changeTracking")
@zeroKey("0")
SELECT
    0                                        AS "DIM_NT_CT_SCD1_ZEROKEY_KEY" @id("44cea6") @isSurrogateKey,
    "NAtionKey"                              AS "NAtionKey"                  @id("60237d") @isBusinessKey,
    "name"                                   AS "name"                       @id("0a6511") @isBusinessKey,
    "REGIONKEY"                              AS "REGIONKEY"                  @id("1ac61d"),
    "CommenT"                                AS "CommenT"                    @id("c07a35") @zeroKey("'N/A'"),
    "N_Load_Timestamp"                       AS "N_Load_Timestamp"           @id("911607"),
    1                                        AS "SYSTEM_VERSION"             @id("b73fa2") @isSystemVersion,
    'Y'                                      AS "SYSTEM_CURRENT_FLAG"        @id("4d2c5c") @isSystemCurrentFlag,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_CREATE_DATE"         @id("deee36") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_UPDATE_DATE"         @id("9ddee6") @isSystemUpdateDate,
    CAST('2999-12-31 00:00:00' AS TIMESTAMP) AS "SYSTEM_END_DATE"            @id("e29d96") @isSystemEndDate
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
