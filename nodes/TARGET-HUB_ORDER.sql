@id("76cbec8b-11ac-47e9-88b4-880930ca8548")
@nodeType("SQLFact")
@mergeStrategy("allColumnMatch")
@tests("SELECT 1 FROM {{ this }} GROUP BY HK_ORDER HAVING COUNT(*) > 1", false, "After")
SELECT
    "S"."HK_ORDER"                       AS "HK_ORDER"      @id("d83523") @not_null,
    "S"."O_ORDERKEY"                     AS "O_ORDERKEY"    @id("705ffa") @not_null,
    "S"."RECORD_SOURCE"                  AS "RECORD_SOURCE" @id("edbce1"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "LOAD_DTS"      @id("707661") @isSystemCreateDate
FROM {{ ref('TARGET', 'STG_DV_ORDERS') }} "S"
