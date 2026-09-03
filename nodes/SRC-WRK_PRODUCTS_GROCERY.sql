@id("16b0c3a4-9750-44a6-82ae-32bca7a28365")
@nodeType("707")
@materializationType("TableView")
SELECT
     "PRODUCT_ID" AS "PRODUCT_ID",
     "PRODUCT_NAME" AS "PRODUCT_NAME",
     "BRAND" AS "BRAND",
     "COLOUR" AS "COLOUR"
FROM {{ ref('SRC', 'PRODUCTS_GROCERY') }} "PRODUCTS_GROCERY"