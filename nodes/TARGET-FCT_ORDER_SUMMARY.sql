@id("d7748397-a66d-4087-b6f6-45651bc4a9d4")
@nodeType("SQLFact")
@materializationType("table")
@description("Sales star - order-grain summary fact (upsert), aggregated from order lines")
@mergeStrategy("upsert")
WITH "ORDER_TOTALS" AS (
    SELECT
        "ORDER_KEY",
        "CUSTOMER_KEY",
        "ORDER_DATE",
        "ORDER_STATUS",
        "ORDER_PRIORITY",
        COUNT(*) AS "LINE_COUNT",
        SUM("QUANTITY") AS "TOTAL_QUANTITY",
        SUM("NET_AMOUNT") AS "TOTAL_NET_AMOUNT",
        SUM("GROSS_AMOUNT") AS "TOTAL_GROSS_AMOUNT",
        SUM(CASE WHEN "IS_LATE" THEN 1 ELSE 0 END) AS "LATE_LINE_COUNT",
        MAX("RECEIPT_DATE") AS "LAST_RECEIPT_DATE"
    FROM {{ ref('TARGET', 'WRK_ORDER_LINES') }}
    GROUP BY "ORDER_KEY", "CUSTOMER_KEY", "ORDER_DATE", "ORDER_STATUS", "ORDER_PRIORITY"
)
SELECT
    "T"."ORDER_KEY" AS "ORDER_KEY" @id("08bb991a-54b5-4acc-abb8-bb9a24b76926") @isBusinessKey,
    COALESCE("C"."DIM_CUSTOMER_PROFILE_KEY", -1) AS "DIM_CUSTOMER_PROFILE_KEY" @id("1f227fff-2457-4fbd-a57d-4ac6c8e592d0") @not_null,
    "T"."ORDER_DATE" AS "ORDER_DATE" @id("020236ea-d62c-406a-a47a-9becd69b4e57") @clusterKey(1),
    "T"."ORDER_STATUS" AS "ORDER_STATUS" @id("624035c8-d9fb-464d-9dc1-1d042bcafd94") @accepted_values("'F', 'O', 'P'"),
    "T"."ORDER_PRIORITY" AS "ORDER_PRIORITY" @id("42018cb7-80c2-4448-b653-fbf8173c646e"),
    CAST("T"."LINE_COUNT" AS NUMBER(10,0)) AS "LINE_COUNT" @id("9e5af49c-be15-419d-9ea5-fd5d0e6b74b6") @min_value("1"),
    CAST("T"."TOTAL_QUANTITY" AS NUMBER(18,2)) AS "TOTAL_QUANTITY" @id("b126eb9d-9036-4262-bc76-bbb84dc3ad56"),
    CAST("T"."TOTAL_NET_AMOUNT" AS NUMBER(18,2)) AS "TOTAL_NET_AMOUNT" @id("693bea69-fb97-423a-8408-11231ea9a7b5"),
    CAST("T"."TOTAL_GROSS_AMOUNT" AS NUMBER(18,2)) AS "TOTAL_GROSS_AMOUNT" @id("34ff8652-6359-4657-86fc-b03dcf373ab8"),
    CAST("T"."LATE_LINE_COUNT" AS NUMBER(10,0)) AS "LATE_LINE_COUNT" @id("a3fd2d26-50f3-4a3a-b40a-a4c2712eb783"),
    "T"."LAST_RECEIPT_DATE" AS "LAST_RECEIPT_DATE" @id("d2ed1792-1b25-4f8d-84c2-07fc00f7d94d"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("a68ba509-97fc-4f1e-afeb-ed3bc0076ede") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("004cfae5-8559-4bc8-b92e-8c7ce71d1bba") @isSystemUpdateDate
FROM "ORDER_TOTALS" "T"
LEFT JOIN {{ ref('TARGET', 'DIM_CUSTOMER_PROFILE') }} "C"
    ON "T"."CUSTOMER_KEY" = "C"."CUSTOMER_KEY"
    AND "C"."SYSTEM_CURRENT_FLAG" = 'Y'
