@id("cdb05971-7d35-410d-872b-29a10bc37aed")
@nodeType("707")
SELECT
     "N_NAME" AS "N_NAME" @defaultValue("NA")
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"