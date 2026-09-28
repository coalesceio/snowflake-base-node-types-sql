@id("85861a61-49f0-4959-a77c-df7b8df445d9")
@nodeType("707")
@description("Customers enriched with their nation and region names (CUSTOMER x NATION x REGION)")
SELECT
    "CUSTOMER"."C_CUSTKEY"    AS "C_CUSTKEY"    @id("51a604") @not_null @uniqueness @description("Customer key (primary key)"),
    "CUSTOMER"."C_NAME"       AS "C_NAME"       @id("ee2247") @description("Customer name"),
    "CUSTOMER"."C_MKTSEGMENT" AS "C_MKTSEGMENT" @id("fb6631") @description("Customer market segment"),
    "CUSTOMER"."C_ACCTBAL"    AS "C_ACCTBAL"    @id("0cc7c7") @description("Customer account balance"),
    "NATION"."N_NATIONKEY"    AS "N_NATIONKEY"  @id("15dc5a") @not_null @description("Nation key of the customer (FK to NATION)"),
    "NATION"."N_NAME"         AS "N_NAME"       @id("fba860") @not_null @description("Name of the nation of the customer"),
    "REGION"."R_REGIONKEY"    AS "R_REGIONKEY"  @id("f07337") @not_null @description("Region key of the nation of the customer"),
    "REGION"."R_NAME"         AS "R_NAME"       @id("1bb23a") @not_null @description("Name of the region of the customer")
FROM {{ ref('SRC', 'CUSTOMER') }} "CUSTOMER"
INNER JOIN {{ ref('SRC', 'NATION') }} "NATION"
    ON "CUSTOMER"."C_NATIONKEY" = "NATION"."N_NATIONKEY"
INNER JOIN {{ ref('SRC', 'REGION') }} "REGION"
    ON "NATION"."N_REGIONKEY" = "REGION"."R_REGIONKEY"
