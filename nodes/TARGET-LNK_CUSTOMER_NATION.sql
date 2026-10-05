@id("320d869f-dfca-4fa3-b157-4ec28db7bf84")
@nodeType("SQLFact")
@mergeStrategy("allColumnMatch")
@tests("SELECT 1 FROM {{ this }} GROUP BY HK_L_CUSTOMER_NATION HAVING COUNT(*) > 1", false, "After")
SELECT
    "S"."HK_L_CUSTOMER_NATION"           AS "HK_L_CUSTOMER_NATION" @id("018bb6") @not_null,
    "S"."HK_CUSTOMER"                    AS "HK_CUSTOMER"          @id("1db986") @not_null,
    "S"."HK_NATION"                      AS "HK_NATION"            @id("59eab3") @not_null,
    "S"."RECORD_SOURCE"                  AS "RECORD_SOURCE"        @id("91a402"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "LOAD_DTS"             @id("d649a4") @isSystemCreateDate
FROM {{ ref('TARGET', 'STG_DV_CUSTOMER') }} "S"
