@id("66d3ef09-d1ea-4f9c-9b14-fdf5d9340539")
@nodeType("6fda2820-4404-4b60-bad3-cf0edd7dab92")

@preSQL("ALTER SESSION SET TIMEZONE = 'UTC'"")

WITH 
-- CTE 1: Clean and prepare the Sales data
PREP_SALES AS (
    SELECT 
        TRANSACTION_ID,
        STORE_ID,
        PRODUCT_ID,
        CAST(SALE_TIMESTAMP AS DATE) AS SALE_DATE,
        DATE_PART(MONTH, SALE_TIMESTAMP) AS SALE_MONTH,
        QUANTITY,
        COALESCE(DISCOUNT_AMOUNT, 0) AS DISCOUNT_AMOUNT
    FROM {{ ref('SRC', 'SOURCE_SALES') }} "SOURCE_SALES"
),

-- CTE 2: Join with Products to calculate gross revenue
SALES_WITH_PRODUCTS AS (
    SELECT 
        S.*,
        P.PRODUCT_NAME,
        P.CATEGORY,
        (S.QUANTITY * P.BASE_PRICE) AS GROSS_REVENUE,
        ((S.QUANTITY * P.BASE_PRICE) - S.DISCOUNT_AMOUNT) AS NET_REVENUE
    FROM PREP_SALES S
    INNER JOIN {{ ref('SRC', 'SOURCE_PRODUCTS') }} "P" ON S.PRODUCT_ID = P.PRODUCT_ID
),

-- CTE 3: Join with Stores to add geographical dimensions
ENRICHED_FINAL AS (
    SELECT 
        SWP.*,
        ST.STORE_NAME,
        ST.REGION
    FROM SALES_WITH_PRODUCTS SWP
    INNER JOIN {{ ref('SRC', 'SOURCE_STORES') }} "ST" ON SWP.STORE_ID = ST.STORE_ID
)

-- Final SELECT: Expose Dimensions and Measures with business-friendly names
SELECT 
    -- Dimensions
    SALE_DATE,
    SALE_MONTH,
    STORE_NAME,
    REGION,
    PRODUCT_NAME,
    CATEGORY,
    
    -- Measures (Aggregatable)
    QUANTITY AS UNIT_SALES,
    GROSS_REVENUE,
    DISCOUNT_AMOUNT AS TOTAL_DISCOUNTS,
    NET_REVENUE,
    
    -- Derived Measure (Calculated at row level)
    (NET_REVENUE / NULLIF(QUANTITY, 0)) AS AVERAGE_UNIT_PRICE
FROM ENRICHED_FINAL;