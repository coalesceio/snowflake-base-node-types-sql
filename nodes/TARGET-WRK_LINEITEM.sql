@id("5551004d-931d-4111-8ed8-24c8d84299de")
@nodeType("707")
@description("Work table of TPC-H order lines")
@tests("SELECT 1 FROM {{ this }} GROUP BY L_ORDERKEY, L_LINENUMBER HAVING COUNT(*) > 1")
SELECT
    "LINEITEM"."L_ORDERKEY"                                                                 AS "L_ORDERKEY"      @id("d68adf") @not_null @description("Order key (FK to ORDERS)"),
    "LINEITEM"."L_PARTKEY"                                                                  AS "L_PARTKEY"       @id("a07e99") @not_null @description("Part key (FK to PART)"),
    "LINEITEM"."L_SUPPKEY"                                                                  AS "L_SUPPKEY"       @id("829e07") @not_null @description("Supplier key (FK to SUPPLIER)"),
    "LINEITEM"."L_LINENUMBER"                                                               AS "L_LINENUMBER"    @id("36e9e9") @not_null @min_max("1", "7") @description("Line number within the order"),
    "LINEITEM"."L_QUANTITY"                                                                 AS "L_QUANTITY"      @id("3ba1cf") @min_max("1", "50") @description("Quantity ordered"),
    "LINEITEM"."L_EXTENDEDPRICE"                                                            AS "L_EXTENDEDPRICE" @id("67d1b2") @min_value("0") @description("Extended price (quantity x part retail price)"),
    "LINEITEM"."L_DISCOUNT"                                                                 AS "L_DISCOUNT"      @id("583666") @min_max("0", "0.10") @description("Discount rate applied to the line"),
    "LINEITEM"."L_TAX"                                                                      AS "L_TAX"           @id("927ed8") @min_max("0", "0.08") @description("Tax rate applied to the line"),
    "LINEITEM"."L_RETURNFLAG"                                                               AS "L_RETURNFLAG"    @id("5c55cf") @accepted_values("'R', 'A', 'N'") @description("Return flag (R, A or N)"),
    "LINEITEM"."L_LINESTATUS"                                                               AS "L_LINESTATUS"    @id("6bc765") @accepted_values("'O', 'F'") @description("Line status (O = open, F = fulfilled)"),
    "LINEITEM"."L_SHIPDATE"                                                                 AS "L_SHIPDATE"      @id("b38f96") @relative_time("<=", "L_RECEIPTDATE") @description("Date the line was shipped"),
    "LINEITEM"."L_COMMITDATE"                                                               AS "L_COMMITDATE"    @id("5e9382") @description("Date the line was committed to ship"),
    "LINEITEM"."L_RECEIPTDATE"                                                              AS "L_RECEIPTDATE"   @id("896fc9") @description("Date the line was received"),
    "LINEITEM"."L_SHIPINSTRUCT"                                                             AS "L_SHIPINSTRUCT"  @id("03565d") @description("Shipping instructions"),
    "LINEITEM"."L_SHIPMODE"                                                                 AS "L_SHIPMODE"      @id("d6b744") @accepted_values("'AIR', 'FOB', 'MAIL', 'RAIL', 'REG AIR', 'SHIP', 'TRUCK'") @description("Shipping mode"),
    "LINEITEM"."L_COMMENT"                                                                  AS "L_COMMENT"       @id("eafc4d") @description("Free-text comment about the line"),
    "LINEITEM"."L_EXTENDEDPRICE" * (1 - "LINEITEM"."L_DISCOUNT")                            AS "L_NET_PRICE"     @id("8e8614") @min_value("0") @description("Extended price after discount"),
    "LINEITEM"."L_EXTENDEDPRICE" * (1 - "LINEITEM"."L_DISCOUNT") * (1 + "LINEITEM"."L_TAX") AS "L_CHARGE"        @id("98aa4f") @min_value("0") @description("Extended price after discount, including tax")
FROM {{ ref('SRC', 'LINEITEM') }} "LINEITEM"
