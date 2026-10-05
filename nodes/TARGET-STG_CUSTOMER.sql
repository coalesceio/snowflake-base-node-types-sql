@id("2724d767-46a5-4398-aaf6-867969d84627")
@nodeType("707")
@writeMode("truncateInsert")
SELECT
    "CUSTOMER"."C_CUSTKEY"                 AS "C_CUSTKEY"    @id("8abaaf") @not_null @uniqueness,
    TRIM("CUSTOMER"."C_NAME")              AS "C_NAME"       @id("08d8fa"),
    TRIM("CUSTOMER"."C_ADDRESS")           AS "C_ADDRESS"    @id("daa3f7"),
    "CUSTOMER"."C_PHONE"                   AS "C_PHONE"      @id("3c2537"),
    "CUSTOMER"."C_ACCTBAL"                 AS "C_ACCTBAL"    @id("569699"),
    UPPER(TRIM("CUSTOMER"."C_MKTSEGMENT")) AS "C_MKTSEGMENT" @id("45d46c"),
    "CUSTOMER"."C_NATIONKEY"               AS "N_NATIONKEY"  @id("f922f0"),
    "NATION"."N_NAME"                      AS "N_NAME"       @id("8991bd"),
    "REGION"."R_REGIONKEY"                 AS "R_REGIONKEY"  @id("93496e"),
    "REGION"."R_NAME"                      AS "R_NAME"       @id("37d892")
FROM {{ ref('SRC', 'CUSTOMER') }} "CUSTOMER"
LEFT JOIN {{ ref('SRC', 'NATION') }} "NATION"
    ON "CUSTOMER"."C_NATIONKEY" = "NATION"."N_NATIONKEY"
LEFT JOIN {{ ref('SRC', 'REGION') }} "REGION"
    ON "NATION"."N_REGIONKEY" = "REGION"."R_REGIONKEY"
