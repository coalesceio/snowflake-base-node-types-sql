@id("c814974d-8fd5-48f2-9fb1-6a9aa9080a69")
@nodeType("664")
@description("Table''desc")
@tests("SELECT 1 FROM {{ this }} GROUP BY N_COMMENT HAVING COUNT(*) > 1", "Before", true)
@tests("SELECT 1 FROM {{ this }} GROUP BY N_COMMENT HAVING COUNT(*) > 1", "After", true)
@tests("SELECT 1 FROM {{ this }} GROUP BY N_COMMENT HAVING COUNT(*) > 1", "Before", true)
@tests("SELECT 1 FROM {{ this }} GROUP BY N_COMMENT HAVING COUNT(*) > 1", "After", true)
@orderbycolumn("[object Object]", "desc")
@testsEnabled(true)
@truncateBefore(false)


WITH ALL_NATION AS
(
SELECT
     "N_NATIONKEY" AS "N_NATIONKEY",
     "N_NAME" AS "N_NAME",
     "N_REGIONKEY" AS "N_REGIONKEY",
     "N_COMMENT" AS "N_COMMENT",
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP"
FROM {{ ref('SRC', 'NATION_COPY1') }} "NATION_COPY1"
UNION
SELECT
     "N_NATIONKEY" AS "N_NATIONKEY",
     "N_NAME" AS "N_NAME",
     "N_REGIONKEY" AS "N_REGIONKEY",
     "N_COMMENT" AS "N_COMMENT",
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP"
FROM {{ ref('SRC', 'NATION_COPY2') }} "NATION_COPY2"
)

SELECT
     ALL_NATION."N_NATIONKEY" AS "N_NATIONKEY"  @nullable(false),
     ALL_NATION."N_NAME" AS "N_NAME_RENAME" @defaultValue("NA"),
     ALL_NATION."N_REGIONKEY" AS "N_REGIONKEY" @description("Column''desc"),
     ALL_NATION."N_COMMENT" AS "N_COMMENT" @tests('null'),
     ALL_NATION."N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP"
FROM ALL_NATION ALL_NATION
WHERE N_NATIONKEY = 2