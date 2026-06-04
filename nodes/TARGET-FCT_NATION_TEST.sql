@id("fba5b0b8-e02c-4bde-b0be-55f5bf01fbdc")
@nodeType("659")
@lastModifiedCompToggle(true)
@lastModifiedColumn("[object Object]")
@lookBackDays("365")
@orderby(true)
@orderbycolumn("[object Object]", "desc")
SELECT
     NATION_TEST."N_NATIONKEY" AS "N_NATIONKEY",
     NATION_TEST."N_NAME" AS "N_NAME",
     NATION_TEST."N_REGIONKEY" AS "N_REGIONKEY",
     NATION_TEST."N_COMMENT" AS "N_COMMENT",
     NATION_TEST."N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP",
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE",
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE"
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"