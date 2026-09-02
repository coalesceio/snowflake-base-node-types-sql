@id("da2f01ed-8e44-4637-936c-7c611ecebc28")
@nodeType("707")
SELECT
     "N_NATIONKEY" AS "N_NATIONKEY",
     "N_NAME" AS "N_NAME",
     "N_REGIONKEY" AS "N_REGIONKEY",
     "N_COMMENT" AS "N_COMMENT",
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP" @foreign,
     "N_LOAD_TIMESTAMP" AS "FR_DEFAULT_UNIT" @freshness(1),
     "N_LOAD_TIMESTAMP" AS "FR_SECOND" @freshness(1, "SECOND"),
     "N_LOAD_TIMESTAMP" AS "FR_MINUTE" @freshness(1, "MINUTE"),
     "N_LOAD_TIMESTAMP" AS "FR_HOUR" @freshness(1, "HOUR"),
     "N_LOAD_TIMESTAMP" AS "FR_DAY" @freshness(1, "DAY"),
     "N_LOAD_TIMESTAMP" AS "FR_WEEK" @freshness(1, "WEEK"),
     "N_LOAD_TIMESTAMP" AS "FR_MONTH" @freshness(1, "MONTH"),
     "N_LOAD_TIMESTAMP" AS "FR_YEAR" @freshness(1, "YEAR"),
     "N_LOAD_TIMESTAMP" AS "FR_LARGE_INTERVAL" @freshness(100, "YEAR"),
     "N_LOAD_TIMESTAMP" AS "FR_ZERO_INTERVAL" @freshness(0, "SECOND")
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"