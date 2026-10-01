@id("bf897c78-8d9f-4983-8d98-471589af9386")
@nodeType("707")
@description("Silver: customer enriched with nation via CTEs and a LEFT JOIN (SQL Work)")
WITH "CUST" AS (
    SELECT "C"."C_CUSTKEY", "C"."C_NAME", "C"."C_NATIONKEY", "C"."C_ACCTBAL", "C"."C_MKTSEGMENT", "C"."LOAD_TS"
    FROM {{ ref('TARGET', 'SLV_CUSTOMER') }} "C"
),
"NAT" AS (
    SELECT "N"."NATION_KEY", "N"."NATION_NAME", "N"."REGION_KEY"
    FROM {{ ref('TARGET', 'BRZ_NATION') }} "N"
)
SELECT
    "CU"."C_CUSTKEY"                                                                                       AS "C_CUSTKEY"    @id("b50809") @not_null @uniqueness,
    "CU"."C_NAME"                                                                                          AS "C_NAME"       @id("3713eb"),
    "CU"."C_MKTSEGMENT"                                                                                    AS "C_MKTSEGMENT" @id("327850"),
    "CU"."C_ACCTBAL"                                                                                       AS "C_ACCTBAL"    @id("4d2b12"),
    CASE WHEN "CU"."C_ACCTBAL" < 0 THEN 'NEGATIVE' WHEN "CU"."C_ACCTBAL" < 5000 THEN 'LOW' ELSE 'HIGH' END AS "BALANCE_BAND" @id("c5b531") @accepted_values("'NEGATIVE', 'LOW', 'HIGH'"),
    "CU"."C_NATIONKEY"                                                                                     AS "NATION_KEY"   @id("734c4c"),
    COALESCE("NA"."NATION_NAME", 'UNKNOWN')                                                                AS "NATION_NAME"  @id("cf678b"),
    "NA"."REGION_KEY"                                                                                      AS "REGION_KEY"   @id("ab430e"),
    "CU"."LOAD_TS"                                                                                         AS "LOAD_TS"      @id("20f9a6")
FROM "CUST" "CU"
LEFT JOIN "NAT" "NA"
    ON "CU"."C_NATIONKEY" = "NA"."NATION_KEY"
