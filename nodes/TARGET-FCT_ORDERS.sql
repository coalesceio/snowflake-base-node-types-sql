@id("2483dfab-3a0d-4099-ba21-d3131879b4e1")
@nodeType("SQLFact")
@description("Pipeline: order fact - changeTracking on ORDER_ID, resolved to customer and current nation surrogate keys (-1 when unmatched)")
@mergeStrategy("changeTracking")
@writeMode("truncateInsert")
@preSQL("SELECT 'FCT_ORDERS pre-load'")
@postSQL("SELECT 'FCT_ORDERS post-load'")
@tests("SELECT 1 FROM {{ this }} GROUP BY ORDER_ID HAVING COUNT(*) > 1", false, "After")
@tests("SELECT 1 FROM {{ this }} WHERE DIM_NATION_KEY IS NULL OR DIM_CUSTOMER_KEY IS NULL", true, "After")
SELECT
    "O"."ORDER_ID"                         AS "ORDER_ID"           @id("3a0001") @isBusinessKey @not_null @uniqueness @inHash("GH_FCT_ORDER", 1),
    COALESCE("DC"."DIM_CUSTOMER_KEY", -1)  AS "DIM_CUSTOMER_KEY"   @id("3a0002") @not_null @inHash("GH_FCT_ORDER", 2),
    COALESCE("DN"."DIM_NATION_KEY", -1)    AS "DIM_NATION_KEY"     @id("3a0003") @not_null @inHash("GH_FCT_ORDER", 3),
    "O"."CUSTOMER_NAME"                    AS "CUSTOMER_NAME"      @id("3a0004"),
    "O"."CUSTOMER_MATCHED"                 AS "CUSTOMER_MATCHED"   @id("3a0005") @accepted_values("'Y', 'N'"),
    "O"."GH_ORDER"                         AS "GH_ORDER"           @id("3a0007") @not_null,
    {{ get_hash('GH_FCT_ORDER') }}::STRING AS "GH_FCT_ORDER"       @id("3a0008") @not_null,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)   AS "SYSTEM_CREATE_DATE" @id("3a0009") @isSystemCreateDate @not_null,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)   AS "SYSTEM_UPDATE_DATE" @id("3a000a") @isSystemUpdateDate @not_null @relative_time(">=", "SYSTEM_CREATE_DATE")
FROM {{ ref('TARGET', 'WRK_ORDERS_ENRICHED_VIEW') }} "O"
LEFT JOIN {{ ref('TARGET', 'DIM_CUSTOMER') }} "DC"
    ON "O"."CUSTOMER_ID" = "DC"."CUSTOMER_ID"
LEFT JOIN {{ ref('TARGET', 'DIM_NATION') }} "DN"
    ON "O"."NATION_KEY" = "DN"."N_NATIONKEY"
    AND "DN"."SYSTEM_CURRENT_FLAG" = 'Y'
