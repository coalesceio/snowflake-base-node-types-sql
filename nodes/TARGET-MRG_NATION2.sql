@id("053dc3c6-d22f-46ef-bee4-ba5cab282071")
@nodeType("ece2dca8-2416-4db4-b6ae-e12dfb4de042")
@lastModifiedCompToggle(true)
SELECT
     {{NODE_NAME}}_KEY AS "MRG_NATION2_KEY",
     "N_NATIONKEY" AS "N_NATIONKEY",
     "N_NAME" AS "N_NAME",
     "N_REGIONKEY" AS "N_REGIONKEY",
     "N_COMMENT" AS "N_COMMENT",
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP" @isLastModifiedColumn
FROM {{ ref('SRC', 'NATION') }} "NATION"