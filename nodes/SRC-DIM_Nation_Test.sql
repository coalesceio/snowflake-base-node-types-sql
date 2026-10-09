@id("1e527d31-c17b-477c-8220-2128fc924540")
@nodeType("Latest220:::SQLDimension")
SELECT
    0                                        AS "DIM_Nation_Test_KEY" @id("327e7e") @isSurrogateKey,
    "NAtionKey"                              AS "NAtionKey"           @id("4273a2") @isBusinessKey,
    "name"                                   AS "name"                @id("7b4073"),
    "REGIONKEY"                              AS "REGIONKEY"           @id("ffa1b9"),
    "CommenT"                                AS "CommenT"             @id("279334"),
    "N_Load_Timestamp"                       AS "N_Load_Timestamp"    @id("759b69"),
    1                                        AS "SYSTEM_VERSION"      @id("94f23a") @isSystemVersion,
    'Y'                                      AS "SYSTEM_CURRENT_FLAG" @id("0eaa67") @isSystemCurrentFlag,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_CREATE_DATE"  @id("0246d4") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_UPDATE_DATE"  @id("b92e26") @isSystemUpdateDate,
    CAST('2999-12-31 00:00:00' AS TIMESTAMP) AS "SYSTEM_END_DATE"     @id("f8e539") @isSystemEndDate
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"