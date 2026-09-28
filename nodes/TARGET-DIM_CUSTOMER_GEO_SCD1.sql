@id("cd070322-2e0e-4c7e-8aa5-c47766686398")
@nodeType("718")
@mergeStrategy("changeTracking")
@description("SCD Type 1 customer dimension built on WRK_CUSTOMER_GEO; one row per customer, attributes overwritten in place")
SELECT
    0                                    AS "DIM_CUSTOMER_GEO_SCD1_KEY" @id("6cf2ce") @isSurrogateKey @description("Surrogate key of the customer dimension row"),
    "WRK_CUSTOMER_GEO"."C_CUSTKEY"       AS "C_CUSTKEY"                 @id("5e251c") @isBusinessKey @not_null @uniqueness @description("Customer key (business key)"),
    "WRK_CUSTOMER_GEO"."C_NAME"          AS "C_NAME"                    @id("606949") @description("Customer name"),
    "WRK_CUSTOMER_GEO"."C_MKTSEGMENT"    AS "C_MKTSEGMENT"              @id("54f811") @description("Customer market segment"),
    "WRK_CUSTOMER_GEO"."C_ACCTBAL"       AS "C_ACCTBAL"                 @id("12561a") @description("Customer account balance"),
    "WRK_CUSTOMER_GEO"."N_NATIONKEY"     AS "N_NATIONKEY"               @id("80ee64") @description("Nation key of the customer"),
    "WRK_CUSTOMER_GEO"."N_NAME"          AS "N_NAME"                    @id("9259f8") @description("Name of the nation of the customer"),
    "WRK_CUSTOMER_GEO"."R_REGIONKEY"     AS "R_REGIONKEY"               @id("7e3507") @description("Region key of the customer nation"),
    "WRK_CUSTOMER_GEO"."R_NAME"          AS "R_NAME"                    @id("aa63c1") @description("Name of the region of the customer"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE"        @id("113029") @isSystemCreateDate @description("Timestamp when the row was first inserted"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE"        @id("c538aa") @isSystemUpdateDate @description("Timestamp when the row was last inserted or changed")
FROM {{ ref('TARGET', 'WRK_CUSTOMER_GEO') }} "WRK_CUSTOMER_GEO"
