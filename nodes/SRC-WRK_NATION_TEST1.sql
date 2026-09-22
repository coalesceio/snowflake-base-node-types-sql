@id("967c4618-470b-4beb-b6b9-0c4388b83d61")
@nodeType("707")
SELECT
     "N_NATIONKEY" AS "N_NATIONKEY" @inHash("GH_COL", 1),
     {{ get_hash("GH_COL") }}::STRING AS "GH_COL",
     '{{ parameters.nationkey }}.{{ parameters.nationkey }}'::STRING AS "NATION"
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"