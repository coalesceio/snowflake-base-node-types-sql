@id("62c7c7cd-9e47-469c-aba7-0859d65caaae")
@nodeType("707")
@writeMode("truncateInsert")
SELECT
    "LINEITEM"."L_ORDERKEY"                                                                                       AS "ORDER_KEY"      @id("bd7d19") @not_null,
    "LINEITEM"."L_LINENUMBER"                                                                                     AS "LINE_NUMBER"    @id("a6fe02") @not_null,
    "ORDERS"."O_CUSTKEY"                                                                                          AS "CUSTOMER_KEY"   @id("8120e7"),
    "LINEITEM"."L_PARTKEY"                                                                                        AS "PART_KEY"       @id("55545b"),
    "LINEITEM"."L_SUPPKEY"                                                                                        AS "SUPPLIER_KEY"   @id("6a2072"),
    "ORDERS"."O_ORDERDATE"                                                                                        AS "ORDER_DATE"     @id("ef108e"),
    "LINEITEM"."L_SHIPDATE"                                                                                       AS "SHIP_DATE"      @id("bc3901"),
    "LINEITEM"."L_RECEIPTDATE"                                                                                    AS "RECEIPT_DATE"   @id("c3ac18"),
    "ORDERS"."O_ORDERSTATUS"                                                                                      AS "ORDER_STATUS"   @id("d95fdf"),
    "ORDERS"."O_ORDERPRIORITY"                                                                                    AS "ORDER_PRIORITY" @id("871b69"),
    "LINEITEM"."L_RETURNFLAG"                                                                                     AS "RETURN_FLAG"    @id("3f0d46"),
    "LINEITEM"."L_LINESTATUS"                                                                                     AS "LINE_STATUS"    @id("50682c"),
    "LINEITEM"."L_SHIPMODE"                                                                                       AS "SHIP_MODE"      @id("408488"),
    "LINEITEM"."L_QUANTITY"                                                                                       AS "QUANTITY"       @id("503f1e"),
    "LINEITEM"."L_EXTENDEDPRICE"                                                                                  AS "EXTENDED_PRICE" @id("3b1110"),
    "LINEITEM"."L_DISCOUNT"                                                                                       AS "DISCOUNT"       @id("4fe709"),
    "LINEITEM"."L_TAX"                                                                                            AS "TAX"            @id("a67dd2"),
    CAST("LINEITEM"."L_EXTENDEDPRICE" * (1 - "LINEITEM"."L_DISCOUNT") AS NUMBER(18,2))                            AS "NET_AMOUNT"     @id("907636"),
    CAST("LINEITEM"."L_EXTENDEDPRICE" * (1 - "LINEITEM"."L_DISCOUNT") * (1 + "LINEITEM"."L_TAX") AS NUMBER(18,2)) AS "GROSS_AMOUNT"   @id("9f7b84")
FROM {{ ref('SRC', 'LINEITEM') }} "LINEITEM"
INNER JOIN {{ ref('SRC', 'ORDERS') }} "ORDERS"
    ON "LINEITEM"."L_ORDERKEY" = "ORDERS"."O_ORDERKEY"
