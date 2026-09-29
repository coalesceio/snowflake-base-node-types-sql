@id("7e3ca648-02a7-40ad-81af-1b3ef283e093")
@nodeType("718")
@mergeStrategy("upsert")
@description("SCD Type 3 customer dimension on CUSTOMER, loaded via upsert: address and market segment keep their current value plus the one previous value and the time it changed; every other attribute is overwritten in place")
@tests("SELECT 1 FROM {{ this }} GROUP BY C_CUSTKEY HAVING COUNT(*) > 1")
WITH "CUSTOMER_CTE" AS (
    SELECT "C_CUSTKEY", "C_NAME", "C_ADDRESS", "C_NATIONKEY", "C_PHONE",
           "C_ACCTBAL", "C_MKTSEGMENT", "C_COMMENT"
    FROM {{ ref('SRC', 'CUSTOMER') }}
),
"EXISTING" AS (
    -- Current state of each customer already in this dimension; drives the SCD3 previous-value logic
    SELECT "C_CUSTKEY",
           "C_ADDRESS", "C_ADDRESS_PREV", "C_ADDRESS_CHANGED_DATE",
           "C_MKTSEGMENT", "C_MKTSEGMENT_PREV", "C_MKTSEGMENT_CHANGED_DATE"
    FROM ANANDHIS_DEV.TARGET.DIM_CUSTOMER_SCD3
)
SELECT
    0                                                    AS "DIM_CUSTOMER_SCD3_KEY"     @id("7b465d") @isSurrogateKey,
    CAST("CUSTOMER_CTE"."C_CUSTKEY" AS NUMBER(38,0))     AS "C_CUSTKEY"                 @id("0a14a6") @isBusinessKey @not_null @description("Customer key (business key)"),
    CAST("CUSTOMER_CTE"."C_NAME" AS VARCHAR(25))         AS "C_NAME"                    @id("348375") @description("Customer name; overwritten on change"),
    CAST("CUSTOMER_CTE"."C_ADDRESS" AS VARCHAR(40))      AS "C_ADDRESS"                 @id("b25b4c") @description("Current customer address"),
    CAST(CASE
        WHEN "EXISTING"."C_CUSTKEY" IS NOT NULL
         AND NOT EQUAL_NULL("CUSTOMER_CTE"."C_ADDRESS", "EXISTING"."C_ADDRESS")
        THEN "EXISTING"."C_ADDRESS"
        ELSE "EXISTING"."C_ADDRESS_PREV"
    END AS VARCHAR(40))                                  AS "C_ADDRESS_PREV"            @id("c8176d") @description("Address before the most recent change; NULL until the address first changes"),
    CAST(CASE
        WHEN "EXISTING"."C_CUSTKEY" IS NOT NULL
         AND NOT EQUAL_NULL("CUSTOMER_CTE"."C_ADDRESS", "EXISTING"."C_ADDRESS")
        THEN CURRENT_TIMESTAMP
        ELSE "EXISTING"."C_ADDRESS_CHANGED_DATE"
    END AS TIMESTAMP)                                    AS "C_ADDRESS_CHANGED_DATE"    @id("e571a9") @description("When the address last changed; NULL until the address first changes"),
    CAST("CUSTOMER_CTE"."C_NATIONKEY" AS NUMBER(38,0))   AS "C_NATIONKEY"               @id("ff079b") @description("Nation key (FK to NATION); overwritten on change"),
    CAST("CUSTOMER_CTE"."C_PHONE" AS VARCHAR(15))        AS "C_PHONE"                   @id("d0d9a9") @description("Phone number; overwritten on change"),
    CAST("CUSTOMER_CTE"."C_ACCTBAL" AS NUMBER(12,2))     AS "C_ACCTBAL"                 @id("04f2ea") @description("Account balance; overwritten on change"),
    CAST("CUSTOMER_CTE"."C_MKTSEGMENT" AS VARCHAR(10))   AS "C_MKTSEGMENT"              @id("8da2be") @description("Current market segment"),
    CAST(CASE
        WHEN "EXISTING"."C_CUSTKEY" IS NOT NULL
         AND NOT EQUAL_NULL("CUSTOMER_CTE"."C_MKTSEGMENT", "EXISTING"."C_MKTSEGMENT")
        THEN "EXISTING"."C_MKTSEGMENT"
        ELSE "EXISTING"."C_MKTSEGMENT_PREV"
    END AS VARCHAR(10))                                  AS "C_MKTSEGMENT_PREV"         @id("476dbf") @description("Market segment before the most recent change; NULL until the segment first changes"),
    CAST(CASE
        WHEN "EXISTING"."C_CUSTKEY" IS NOT NULL
         AND NOT EQUAL_NULL("CUSTOMER_CTE"."C_MKTSEGMENT", "EXISTING"."C_MKTSEGMENT")
        THEN CURRENT_TIMESTAMP
        ELSE "EXISTING"."C_MKTSEGMENT_CHANGED_DATE"
    END AS TIMESTAMP)                                    AS "C_MKTSEGMENT_CHANGED_DATE" @id("a3ed74") @description("When the market segment last changed; NULL until the segment first changes"),
    CAST("CUSTOMER_CTE"."C_COMMENT" AS VARCHAR(117))     AS "C_COMMENT"                 @id("8ffa3f") @description("Customer comment; overwritten on change"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)                 AS "SYSTEM_CREATE_DATE"        @id("b3c157") @isSystemCreateDate @description("Timestamp when the customer was first inserted (kept on update)"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)                 AS "SYSTEM_UPDATE_DATE"        @id("793a0e") @isSystemUpdateDate @description("Timestamp of the last load that touched the customer")
FROM "CUSTOMER_CTE"
LEFT JOIN "EXISTING"
    ON "CUSTOMER_CTE"."C_CUSTKEY" = "EXISTING"."C_CUSTKEY"
