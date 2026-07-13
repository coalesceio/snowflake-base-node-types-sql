@id("3cc8a786-b97b-45eb-a720-716bcec4f0cf")
@nodeType("659")
@orderby(true)
@orderbycolumn("N_REGIONKEY", "desc")
@lastModifiedCompToggle(true)
@lastModifiedColumn("N_LOAD_TIMESTAMP")
SELECT
     "N_NATIONKEY" AS "N_NATIONKEY" @isBusinessKey,
     "N_NAME" AS "N_NAME" @isBusinessKey,
     "N_REGIONKEY" AS "N_REGIONKEY",
     "N_COMMENT" AS "N_COMMENT",
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP",
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE",
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE"
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"