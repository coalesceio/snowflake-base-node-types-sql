@id("d9afa8ce-9065-4535-8a0e-64a060550cd3")
@nodeType("SQLFact")
@mergeStrategy("allColumnMatch")
@tests("SELECT 1 FROM {{ this }} GROUP BY HK_L_ORDER_CUSTOMER HAVING COUNT(*) > 1", false, "After")
SELECT
    "S"."HK_L_ORDER_CUSTOMER"            AS "HK_L_ORDER_CUSTOMER" @id("1daae9") @not_null,
    "S"."HK_ORDER"                       AS "HK_ORDER"            @id("04e01f") @not_null,
    "S"."HK_CUSTOMER"                    AS "HK_CUSTOMER"         @id("bda6d5") @not_null,
    "S"."RECORD_SOURCE"                  AS "RECORD_SOURCE"       @id("392f2f"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "LOAD_DTS"            @id("3e0e57") @isSystemCreateDate
FROM {{ ref('TARGET', 'STG_DV_ORDERS') }} "S"
