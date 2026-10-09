@id("0d941100-8209-4c48-8611-a5d23dfad33a")
@nodeType("Latest220:::SQLFact")
@description("Gold: load audit - plain insert, one row appended per run (SQL Fact)")
SELECT
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "AUDIT_TS"           @id("a3f94d"),
    COUNT(*)                             AS "CUSTOMER_ROWS"      @id("d64662"),
    COUNT(DISTINCT "NATION_KEY")         AS "NATION_COUNT"       @id("234e4d"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("1bc31a") @isSystemCreateDate
FROM {{ ref('TARGET', 'SLV_CUSTOMER_ENRICHED') }} "SLV_CUSTOMER_ENRICHED"
