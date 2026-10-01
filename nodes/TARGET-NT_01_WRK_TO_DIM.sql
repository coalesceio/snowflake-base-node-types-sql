@id("ff768c61-e32f-4627-8fd4-1b93660d8d54")
@nodeType("718")
@description("Node-type switch test: 707 -> 718, combined Work/Dimension/Fact annotation set")
@mergeStrategy("changeTracking")
@writeMode("append")
@zeroKey("0")
@tests("SELECT 1 FROM {{ this }} GROUP BY C_CUSTKEY HAVING COUNT(*) > 1")
@preSQL("SELECT CURRENT_TIMESTAMP AS PRE_SQL_RAN")
@postSQL("SELECT COUNT(*) AS POST_SQL_ROWS FROM {{ this }}")
SELECT
    0                                        AS "NT_01_WRK_TO_DIM_KEY" @id("16b100") @isSurrogateKey,
    "C"."C_CUSTKEY"                          AS "C_CUSTKEY"            @id("33683a") @description("Customer identifier") @isBusinessKey @notNull @not_null @uniqueness @inHash("GH", 1),
    "C"."C_NAME"                             AS "C_NAME"               @id("518e31") @description("Customer name") @inHash("GH", 2) @zeroKey("'N/A'"),
    "C"."C_MKTSEGMENT"                       AS "C_MKTSEGMENT"         @id("d93eb5") @isChangeTracking @accepted_values("'AUTOMOBILE', 'BUILDING', 'FURNITURE', 'HOUSEHOLD', 'MACHINERY'"),
    "C"."C_ACCTBAL"                          AS "C_ACCTBAL"            @id("625a78") @defaultValue("0") @min_value("-1000"),
    "N"."name"                               AS "NATION_NAME"          @id("6dee72") @description("Nation name"),
    "N"."N_Load_Timestamp"                   AS "N_Load_Timestamp"     @id("eb979d") @lastModifiedTracking,
    {{ get_hash('GH') }}::STRING             AS "GH"                   @id("0c28e1") @description("Hash of C_CUSTKEY and C_NAME"),
    1                                        AS "SYSTEM_VERSION"       @id("d65b87") @isSystemVersion,
    'Y'                                      AS "SYSTEM_CURRENT_FLAG"  @id("cd7cdd") @isSystemCurrentFlag,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_CREATE_DATE"   @id("f93106") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_UPDATE_DATE"   @id("43f552") @isSystemUpdateDate,
    CAST('2999-12-31 00:00:00' AS TIMESTAMP) AS "SYSTEM_END_DATE"      @id("24bfd6") @isSystemEndDate
FROM {{ ref('SRC', 'CUSTOMER') }} "C"
INNER JOIN {{ ref('SRC', 'Nation_Test') }} "N"
    ON "C"."C_NATIONKEY" = "N"."NAtionKey"
