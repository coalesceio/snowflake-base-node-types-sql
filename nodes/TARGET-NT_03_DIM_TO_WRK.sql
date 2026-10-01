@id("38d76a28-8025-49c9-8e49-1e831563932f")
@nodeType("707")
@description("Node-type switch test: 718 -> 707, combined Work/Dimension/Fact annotation set")
@mergeStrategy("upsert")
@writeMode("append")
@zeroKey("0")
@tests("SELECT 1 FROM {{ this }} GROUP BY C_CUSTKEY HAVING COUNT(*) > 1")
@preSQL("SELECT CURRENT_TIMESTAMP AS PRE_SQL_RAN")
@postSQL("SELECT COUNT(*) AS POST_SQL_ROWS FROM {{ this }}")
SELECT
    0                                        AS "NT_03_DIM_TO_WRK_KEY" @id("d596e5") @isSurrogateKey,
    "C"."C_CUSTKEY"                          AS "C_CUSTKEY"            @id("e0a012") @description("Customer identifier") @isBusinessKey @notNull @not_null @uniqueness @inHash("GH", 1),
    "C"."C_NAME"                             AS "C_NAME"               @id("405ec6") @description("Customer name") @inHash("GH", 2) @zeroKey("'N/A'"),
    "C"."C_MKTSEGMENT"                       AS "C_MKTSEGMENT"         @id("f5f45d") @isChangeTracking @accepted_values("'AUTOMOBILE', 'BUILDING', 'FURNITURE', 'HOUSEHOLD', 'MACHINERY'"),
    "C"."C_ACCTBAL"                          AS "C_ACCTBAL"            @id("fbb0b6") @defaultValue("0") @min_value("-1000"),
    "N"."name"                               AS "NATION_NAME"          @id("8f204a") @description("Nation name"),
    "N"."N_Load_Timestamp"                   AS "N_Load_Timestamp"     @id("61e9ee") @lastModifiedTracking,
    {{ get_hash('GH') }}::STRING             AS "GH"                   @id("228266") @description("Hash of C_CUSTKEY and C_NAME"),
    1                                        AS "SYSTEM_VERSION"       @id("430a09") @isSystemVersion,
    'Y'                                      AS "SYSTEM_CURRENT_FLAG"  @id("afb772") @isSystemCurrentFlag,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_CREATE_DATE"   @id("fd5bb7") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_UPDATE_DATE"   @id("a1682f") @isSystemUpdateDate,
    CAST('2999-12-31 00:00:00' AS TIMESTAMP) AS "SYSTEM_END_DATE"      @id("4adae9") @isSystemEndDate
FROM {{ ref('SRC', 'CUSTOMER') }} "C"
INNER JOIN {{ ref('SRC', 'Nation_Test') }} "N"
    ON "C"."C_NATIONKEY" = "N"."NAtionKey"
