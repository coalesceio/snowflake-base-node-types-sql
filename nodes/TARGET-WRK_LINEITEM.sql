@id("4167b533-2392-4fbf-9a91-3831744c40b1")
@nodeType("704")
SELECT
     "L_ORDERKEY" AS "L_ORDERKEY" @description("Foreign key to the order"),
     "L_PARTKEY" AS "L_PARTKEY" @description("Foreign key to the part"),
     "L_SUPPKEY" AS "L_SUPPKEY" @description("Foreign key to the supplier"),
     "L_LINENUMBER" AS "L_LINENUMBER" @description("Line number within the order"),
     "L_QUANTITY" AS "L_QUANTITY" @description("Quantity of the item ordered"),
     "L_EXTENDEDPRICE" AS "L_EXTENDEDPRICE" @description("Extended price for the line item"),
     "L_DISCOUNT" AS "L_DISCOUNT" @description("Discount applied to the line item"),
     "L_TAX" AS "L_TAX" @description("Tax applied to the line item"),
     "L_RETURNFLAG" AS "L_RETURNFLAG" @description("Indicates whether the item was returned"),
     "L_LINESTATUS" AS "L_LINESTATUS" @description("Status of the line item"),
     "L_SHIPDATE" AS "L_SHIPDATE" @description("Date the item was shipped"),
     "L_COMMITDATE" AS "L_COMMITDATE" @description("Date the item was committed to ship"),
     "L_RECEIPTDATE" AS "L_RECEIPTDATE" @description("Date the item was received"),
     "L_SHIPINSTRUCT" AS "L_SHIPINSTRUCT" @description("Shipping instructions"),
     "L_SHIPMODE" AS "L_SHIPMODE" @description("Mode of shipment"),
     "L_COMMENT" AS "L_COMMENT" @description("Free-text comment about the line item"),
     "L_LOAD_TIMESTAMP" AS "L_LOAD_TIMESTAMP" @description("Timestamp when the record was loaded")
FROM {{ ref('SRC', 'LINEITEM') }} "LINEITEM"
