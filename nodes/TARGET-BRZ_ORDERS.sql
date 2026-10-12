@id("35e26781-55cd-55ce-9686-53b4f6e17428")
@nodeType("SQLWork")
@materializationType("table")
@description("Bronze orders (SQLWork)")
@tests("SELECT 1 FROM {{ this }} WHERE O_ORDERKEY IS NULL", false, "After")
SELECT
    "ORDERS"."O_ORDERKEY" AS "O_ORDERKEY" @id("ef560237-0d28-5ed7-9a59-1c3b3eec5427"),
    "ORDERS"."O_CUSTKEY" AS "O_CUSTKEY" @id("033a2de3-9cb6-5099-9070-f829d87f39ec"),
    "ORDERS"."O_ORDERSTATUS" AS "O_ORDERSTATUS" @id("1ac072ed-a549-5f3a-ab04-441f83269744") @clusterKey(2),
    "ORDERS"."O_TOTALPRICE" AS "O_TOTALPRICE" @id("f7e0f950-0182-58e6-b851-3e163a807c54"),
    "ORDERS"."O_ORDERDATE" AS "O_ORDERDATE" @id("8bdb301f-1b85-5ac0-84da-30cdfade0bdc") @clusterKey(1),
    "ORDERS"."O_ORDERPRIORITY" AS "O_ORDERPRIORITY" @id("d363b29f-bdd3-528a-95af-e8242ba565c9"),
    "ORDERS"."O_CLERK" AS "O_CLERK" @id("4c4f1c6f-50fc-5c3a-aa3c-79126a17c09c"),
    "ORDERS"."O_SHIPPRIORITY" AS "O_SHIPPRIORITY" @id("78c8498c-a5b5-55c1-8c81-d0c61b94ee59"),
    "ORDERS"."O_COMMENT" AS "O_COMMENT" @id("0229163e-4296-5414-b621-d78aa40e6e5d"),
    "ORDERS"."O_LOAD_TIMESTAMP" AS "O_LOAD_TIMESTAMP" @id("3a5479aa-74ef-573a-a610-5e50a41b06aa")
FROM {{ ref('SRC', 'ORDERS') }} "ORDERS"
