@id("be538795-ea15-43a0-9acf-61b15787dbd1")
@nodeType("704")
SELECT
     "N_NAME" AS "N_NAME" @tests("null") @notNull @defaultValue("'NA'") @description("Name col")
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST" 