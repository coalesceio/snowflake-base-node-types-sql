@id("b92b12e7-76c1-4ffe-8b6a-9a23f47e2aeb")
@nodeType("724")
@description("Gold: customer balance fact - default changeTracking merge (SQL Fact)")
@tests("SELECT 1 FROM {{ this }} GROUP BY C_CUSTKEY HAVING COUNT(*) > 1")
SELECT
    "C_CUSTKEY"                          AS "C_CUSTKEY"          @id("79f96b") @isBusinessKey @not_null,
    "NATION_KEY"                         AS "NATION_KEY"         @id("bd47b6"),
    "C_ACCTBAL"                          AS "C_ACCTBAL"          @id("3e0ed7"),
    "BALANCE_BAND"                       AS "BALANCE_BAND"       @id("f5bc91"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("78f1be") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("17cf92") @isSystemUpdateDate
FROM {{ ref('TARGET', 'SLV_CUSTOMER_ENRICHED') }} "SLV_CUSTOMER_ENRICHED"
