@id("6df77ec8-fbef-419b-bb72-801ebc858be3")
@nodeType("ece2dca8-2416-4db4-b6ae-e12dfb4de042")
@lastModifiedCompToggle(true)
SELECT
     "N_NATIONKEY" AS "N_NATIONKEY",
     "N_NAME" AS "N_NAME",
     "N_REGIONKEY" AS "N_REGIONKEY",
     "N_COMMENT" AS "N_COMMENT",
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP" @isLastModifiedColumn
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"