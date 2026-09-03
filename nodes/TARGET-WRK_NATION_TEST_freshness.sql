@id("4dbeedf4-1d30-4142-bf65-3f9ddf1d63f7")
@nodeType("704")
SELECT
     "N_NATIONKEY" AS "N_NATIONKEY",
     "N_NAME" AS "N_NAME",
     "N_REGIONKEY" AS "N_REGIONKEY",
     "N_COMMENT" AS "N_COMMENT",
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP",
     "N_LOAD_TIMESTAMP" AS "FR_SECOND" @freshness(1, "SECOND"),
     "N_LOAD_TIMESTAMP" AS "FR_MINUTE" @freshness(1, "MINUTE"),
     "N_LOAD_TIMESTAMP" AS "FR_HOUR" @freshness(1, "HOUR"),
     "N_LOAD_TIMESTAMP" AS "FR_DAY" @freshness(1, "DAY"),
     "N_LOAD_TIMESTAMP" AS "FR_WEEK" @freshness(1, "WEEK"),
     "N_LOAD_TIMESTAMP" AS "FR_MONTH" @freshness(1, "MONTH"),
     "N_LOAD_TIMESTAMP" AS "FR_YEAR" @freshness(1, "YEAR")
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"