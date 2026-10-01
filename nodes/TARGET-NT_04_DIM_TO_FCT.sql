@id("67cc5955-a223-40d1-873e-4345169dce42")
@nodeType("724")
@description("Node-type switch test: 718 -> 724, combined Work/Dimension/Fact annotation set")
@mergeStrategy("changeTracking")
@writeMode("append")
@zeroKey("0")
@tests("SELECT 1 FROM {{ this }} GROUP BY C_CUSTKEY HAVING COUNT(*) > 1")
@preSQL("SELECT CURRENT_TIMESTAMP AS PRE_SQL_RAN")
@postSQL("SELECT COUNT(*) AS POST_SQL_ROWS FROM {{ this }}")
SELECT
    0                                        AS "NT_04_DIM_TO_FCT_KEY" @id("8100ac") @isSurrogateKey,
    "C"."C_CUSTKEY"                          AS "C_CUSTKEY"            @id("28dcf3") @description("Customer identifier") @isBusinessKey @notNull @not_null @uniqueness @inHash("GH", 1),
    "C"."C_NAME"                             AS "C_NAME"               @id("1b9df6") @description("Customer name") @inHash("GH", 2) @zeroKey("'N/A'"),
    "C"."C_MKTSEGMENT"                       AS "C_MKTSEGMENT"         @id("c65759") @isChangeTracking @accepted_values("'AUTOMOBILE', 'BUILDING', 'FURNITURE', 'HOUSEHOLD', 'MACHINERY'"),
    "C"."C_ACCTBAL"                          AS "C_ACCTBAL"            @id("b465d9") @defaultValue("0") @min_value("-1000"),
    "N"."name"                               AS "NATION_NAME"          @id("111d03") @description("Nation name"),
    "N"."N_Load_Timestamp"                   AS "N_Load_Timestamp"     @id("771877") @lastModifiedTracking,
    {{ get_hash('GH') }}::STRING             AS "GH"                   @id("59e1a8") @description("Hash of C_CUSTKEY and C_NAME"),
    1                                        AS "SYSTEM_VERSION"       @id("a55b38") @isSystemVersion,
    'Y'                                      AS "SYSTEM_CURRENT_FLAG"  @id("a6b362") @isSystemCurrentFlag,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_CREATE_DATE"   @id("455f6d") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_UPDATE_DATE"   @id("671791") @isSystemUpdateDate,
    CAST('2999-12-31 00:00:00' AS TIMESTAMP) AS "SYSTEM_END_DATE"      @id("ee7f8e") @isSystemEndDate
FROM {{ ref('SRC', 'CUSTOMER') }} "C"
INNER JOIN {{ ref('SRC', 'Nation_Test') }} "N"
    ON "C"."C_NATIONKEY" = "N"."NAtionKey"
