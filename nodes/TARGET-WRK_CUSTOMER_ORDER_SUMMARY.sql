@id("d97922e2-f50b-4cc2-acd8-5946960a0d08")
@nodeType("707")
@description("Customer order summary: aggregates the V1 order/lineitem fact by customer, enriched with customer geography from the V1 dimension layer. Capstone V2 node on top of the V1 star schema.")
@disableTests
@tests("SELECT CUSTOMER_KEY FROM {{ this }} GROUP BY CUSTOMER_KEY HAVING COUNT(1) > 1")
WITH ORDER_AMOUNTS AS (
    SELECT DISTINCT
        "CUSTOMER_KEY",
        "ORDER_KEY",
        "ORDER_TOTAL_PRICE"
    FROM {{ ref('TARGET', 'FCT_ORDER_LINEITEM') }}
),
CUSTOMER_AVG AS (
    SELECT
        "CUSTOMER_KEY",
        AVG("ORDER_TOTAL_PRICE") AS AVG_ORDER_AMOUNT
    FROM ORDER_AMOUNTS
    GROUP BY "CUSTOMER_KEY"
)
SELECT
    C."CUSTOMER_KEY" AS "CUSTOMER_KEY" @description("Customer business key") @uniqueness @not_null,
    C."CUSTOMER_NAME" AS "CUSTOMER_NAME" @description("Customer name") @not_null,
    NR."NATION_NAME" AS "NATION_NAME" @description("Customer's nation") @not_null,
    NR."REGION_NAME" AS "REGION_NAME" @description("Customer's region") @not_null,
    COUNT(DISTINCT F."ORDER_KEY") AS "ORDER_COUNT" @description("Distinct orders placed by this customer") @not_null,
    SUM(F."LINE_QUANTITY") AS "TOTAL_QUANTITY" @description("Total quantity ordered across all lineitems") @not_null,
    SUM(F."LINE_EXTENDED_PRICE" * (1 - F."LINE_DISCOUNT")) AS "TOTAL_REVENUE" @description("Total revenue after discount across all lineitems") @not_null,
    CA."AVG_ORDER_AMOUNT" AS "AVG_ORDER_AMOUNT_PER_CUSTOMER" @description("Average order total price across this customer's orders, computed once per customer (not skewed by lineitem count)") @not_null
FROM {{ ref('TARGET', 'FCT_ORDER_LINEITEM') }} F
JOIN {{ ref('TARGET', 'DIM_CUSTOMER') }} C ON F."CUSTOMER_KEY" = C."CUSTOMER_KEY"
JOIN {{ ref('TARGET', 'DIM_NATION_REGION') }} NR ON C."NATION_KEY" = NR."NATION_KEY"
JOIN CUSTOMER_AVG CA ON F."CUSTOMER_KEY" = CA."CUSTOMER_KEY"
GROUP BY C."CUSTOMER_KEY", C."CUSTOMER_NAME", NR."NATION_NAME", NR."REGION_NAME", CA."AVG_ORDER_AMOUNT"
