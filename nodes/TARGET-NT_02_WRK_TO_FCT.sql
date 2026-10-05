@id("9de6f258-3917-42ac-80d6-edf01264ee58")
@nodeType("SQLFact")
@description("Node-type switch test: 707 -> 724, combined Work/Dimension/Fact annotation set")
@mergeStrategy("lastModified")
@writeMode("append")
@zeroKey("0")
@tests("SELECT 1 FROM {{ this }} GROUP BY C_CUSTKEY HAVING COUNT(*) > 1")
@preSQL("SELECT CURRENT_TIMESTAMP AS PRE_SQL_RAN")
@postSQL("SELECT COUNT(*) AS POST_SQL_ROWS FROM {{ this }}")
SELECT
    0                                        AS "NT_02_WRK_TO_FCT_KEY" @id("7f50a7") @isSurrogateKey,
    "C"."C_CUSTKEY"                          AS "C_CUSTKEY"            @id("32175d") @description("Customer identifier") @isBusinessKey @notNull @not_null @uniqueness @inHash("GH", 1),
    "C"."C_NAME"                             AS "C_NAME"               @id("58e596") @description("Customer name") @inHash("GH", 2) @zeroKey("'N/A'"),
    "C"."C_MKTSEGMENT"                       AS "C_MKTSEGMENT"         @id("919882") @isChangeTracking @accepted_values("'AUTOMOBILE', 'BUILDING', 'FURNITURE', 'HOUSEHOLD', 'MACHINERY'"),
    "C"."C_ACCTBAL"                          AS "C_ACCTBAL"            @id("a0c835") @defaultValue("0") @min_value("-1000"),
    "N"."name"                               AS "NATION_NAME"          @id("adc9c1") @description("Nation name"),
    "N"."N_Load_Timestamp"                   AS "N_Load_Timestamp"     @id("01dce3") @lastModifiedTracking,
    {{ get_hash('GH') }}::STRING             AS "GH"                   @id("7cfb72") @description("Hash of C_CUSTKEY and C_NAME"),
    1                                        AS "SYSTEM_VERSION"       @id("4c15c4") @isSystemVersion,
    'Y'                                      AS "SYSTEM_CURRENT_FLAG"  @id("49bda4") @isSystemCurrentFlag,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_CREATE_DATE"   @id("3e7677") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_UPDATE_DATE"   @id("53a215") @isSystemUpdateDate,
    CAST('2999-12-31 00:00:00' AS TIMESTAMP) AS "SYSTEM_END_DATE"      @id("cb47c7") @isSystemEndDate
FROM {{ ref('SRC', 'CUSTOMER') }} "C"
INNER JOIN {{ ref('SRC', 'Nation_Test') }} "N"
    ON "C"."C_NATIONKEY" = "N"."NAtionKey"
