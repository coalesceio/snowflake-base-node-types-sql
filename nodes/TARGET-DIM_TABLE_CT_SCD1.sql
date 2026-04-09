@id("6aa6b44e-2ecd-49d0-87a1-92949872aa46")
@nodeType("230cba1d-908f-4198-b597-1cef53279d36")

SELECT
     0 AS "{{ node.name }}_KEY" @isSurrogateKey @nullable("false") @description("System generated value"),
     NATION."N_NATIONKEY" AS "N_NATIONKEY" @isBusinessKey,
     NATION."N_NAME" AS "N_NAME",
     NATION."N_REGIONKEY" AS "N_REGIONKEY",
     NATION."N_COMMENT" AS "N_COMMENT",
     NATION."N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP",
     0 AS "SYSTEM_VERSION" @isSystemVersion @defaultValue("1"),
     '' AS "SYSTEM_CURRENT_FLAG" @isSystemCurrentFlag @defaultValue("Y"),
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @isSystemUpdateDate,
     CAST('2999-12-31 00:00:00' AS TIMESTAMP) AS "SYSTEM_END_DATE" @isSystemEndDate
FROM {{ ref('SRC', 'NATION') }} "NATION"