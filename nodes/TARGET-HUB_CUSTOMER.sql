@id("57d3a1d7-1de1-44fb-ad96-489369c0f80f")
@nodeType("SQLFact")
@mergeStrategy("allColumnMatch")
@tests("SELECT 1 FROM {{ this }} GROUP BY HK_CUSTOMER HAVING COUNT(*) > 1", false, "After")
SELECT
    "S"."HK_CUSTOMER"                    AS "HK_CUSTOMER"   @id("8dfd00") @not_null,
    "S"."C_CUSTKEY"                      AS "C_CUSTKEY"     @id("5e0a32") @not_null,
    "S"."RECORD_SOURCE"                  AS "RECORD_SOURCE" @id("81608e"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "LOAD_DTS"      @id("dc41f4") @isSystemCreateDate
FROM {{ ref('TARGET', 'STG_DV_CUSTOMER') }} "S"
