@id("3904a4ed-2a6b-4b13-a287-2b598b246682")
@nodeType("707")
SELECT
     "N_NATIONKEY" AS "N_NATIONKEY" @inHash("GH_COL", 1),
     {{ get_hash("GH_COL") }}::STRING AS "GH_COL"
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"