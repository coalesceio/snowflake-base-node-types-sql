@id("73a5d373-e417-48b7-833f-2eeb8d527efc")
@nodeType("718")
@description("Node-type switch test: 724 -> 718, combined Work/Dimension/Fact annotation set")
@mergeStrategy("upsert")
@writeMode("append")
@zeroKey("0")
@tests("SELECT 1 FROM {{ this }} GROUP BY C_CUSTKEY HAVING COUNT(*) > 1")
@preSQL("SELECT CURRENT_TIMESTAMP AS PRE_SQL_RAN")
@postSQL("SELECT COUNT(*) AS POST_SQL_ROWS FROM {{ this }}")
SELECT
    0                                        AS "NT_06_FCT_TO_DIM_KEY" @id("ff4f81") @isSurrogateKey,
    "C"."C_CUSTKEY"                          AS "C_CUSTKEY"            @id("f23034") @description("Customer identifier") @isBusinessKey @notNull @not_null @uniqueness @inHash("GH", 1),
    "C"."C_NAME"                             AS "C_NAME"               @id("2c043f") @description("Customer name") @inHash("GH", 2) @zeroKey("'N/A'"),
    "C"."C_MKTSEGMENT"                       AS "C_MKTSEGMENT"         @id("d104f0") @isChangeTracking @accepted_values("'AUTOMOBILE', 'BUILDING', 'FURNITURE', 'HOUSEHOLD', 'MACHINERY'"),
    "C"."C_ACCTBAL"                          AS "C_ACCTBAL"            @id("033b53") @defaultValue("0") @min_value("-1000"),
    "N"."name"                               AS "NATION_NAME"          @id("acc3af") @description("Nation name"),
    "N"."N_Load_Timestamp"                   AS "N_Load_Timestamp"     @id("214cff") @lastModifiedTracking,
    {{ get_hash('GH') }}::STRING             AS "GH"                   @id("fe51b3") @description("Hash of C_CUSTKEY and C_NAME"),
    1                                        AS "SYSTEM_VERSION"       @id("365670") @isSystemVersion,
    'Y'                                      AS "SYSTEM_CURRENT_FLAG"  @id("c648a2") @isSystemCurrentFlag,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_CREATE_DATE"   @id("2beeff") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_UPDATE_DATE"   @id("2cf463") @isSystemUpdateDate,
    CAST('2999-12-31 00:00:00' AS TIMESTAMP) AS "SYSTEM_END_DATE"      @id("7e7535") @isSystemEndDate
FROM {{ ref('SRC', 'CUSTOMER') }} "C"
INNER JOIN {{ ref('SRC', 'Nation_Test') }} "N"
    ON "C"."C_NATIONKEY" = "N"."NAtionKey"
