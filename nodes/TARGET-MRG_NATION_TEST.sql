@id("b8b6e117-2bfd-499f-94bd-59094cb5ae63")
@nodeType("ece2dca8-2416-4db4-b6ae-e12dfb4de042")
@lastModifiedCompToggle(true)

SELECT
     "N_NATIONKEY" AS "N_NATIONKEY",
     "N_NAME" AS "N_NAME",
     "N_REGIONKEY" AS "N_REGIONKEY",
     "N_COMMENT" AS "N_COMMENT",
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP"
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"