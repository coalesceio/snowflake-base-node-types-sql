@id("4745f723-03f2-4eb5-bf7e-a3cd141e14ee")
@nodeType("707")
@description("Work table of TPC-H orders")
SELECT
    "ORDERS"."O_ORDERKEY"      AS "O_ORDERKEY"      @id("3db00c") @not_null @uniqueness @description("Order key (primary key)"),
    "ORDERS"."O_CUSTKEY"       AS "O_CUSTKEY"       @id("1b4cb8") @not_null @description("Customer key (FK to CUSTOMER)"),
    "ORDERS"."O_ORDERSTATUS"   AS "O_ORDERSTATUS"   @id("13bace") @accepted_values("'O', 'F', 'P'") @description("Order status (O = open, F = fulfilled, P = partial)"),
    "ORDERS"."O_TOTALPRICE"    AS "O_TOTALPRICE"    @id("497c48") @min_value("0") @description("Total price of the order"),
    "ORDERS"."O_ORDERDATE"     AS "O_ORDERDATE"     @id("77c958") @not_null @min_max("DATE '1992-01-01'", "CURRENT_DATE") @description("Date the order was placed"),
    "ORDERS"."O_ORDERPRIORITY" AS "O_ORDERPRIORITY" @id("5a776e") @accepted_values("'1-URGENT', '2-HIGH', '3-MEDIUM', '4-NOT SPECIFIED', '5-LOW'") @description("Order priority"),
    "ORDERS"."O_CLERK"         AS "O_CLERK"         @id("96bc2d") @description("Clerk who processed the order"),
    "ORDERS"."O_SHIPPRIORITY"  AS "O_SHIPPRIORITY"  @id("927fd1") @description("Shipping priority"),
    "ORDERS"."O_COMMENT"       AS "O_COMMENT"       @id("250f09") @description("Free-text comment about the order")
FROM {{ ref('SRC', 'ORDERS') }} "ORDERS"
