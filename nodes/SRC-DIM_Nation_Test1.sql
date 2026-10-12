@id("e51881c2-225b-45bd-a2cc-3be37619b977")
@nodeType("SQLDimension")
SELECT
    0                                        AS "DIM_Nation_Test1_KEY" @id("6f6621") @isSurrogateKey,
    "NAtionKey"                              AS "NAtionKey"            @id("723dc8") @isBusinessKey,
    "name"                                   AS "name"                 @id("b26918"),
    "REGIONKEY"                              AS "REGIONKEY"            @id("02e4cd"),
    "CommenT"                                AS "CommenT"              @id("823510"),
    "N_Load_Timestamp"                       AS "N_Load_Timestamp"     @id("26f2e5"),
    1                                        AS "SYSTEM_VERSION"       @id("0efa64") @isSystemVersion,
    'Y'                                      AS "SYSTEM_CURRENT_FLAG"  @id("eb82ff") @isSystemCurrentFlag,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_CREATE_DATE"   @id("de219d") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_UPDATE_DATE"   @id("940807") @isSystemUpdateDate,
    CAST('2999-12-31 00:00:00' AS TIMESTAMP) AS "SYSTEM_END_DATE"      @id("64aef0") @isSystemEndDate
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"