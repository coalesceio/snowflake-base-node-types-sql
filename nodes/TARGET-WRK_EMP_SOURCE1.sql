@id("46b1a105-6894-4e72-b9d9-14af05cc4c9a")
@nodeType("664")
@testsEnabled(true)
@orderby(true)
@orderbycolumn("[object Object]", "desc")
SELECT
     "EMP_ID" AS "EMP_ID",
     "EMP_NAME" AS "EMP_NAME",
     "EMP_CITY" AS "EMP_CITY",
     "DML_FLAG" AS "DML_FLAG",
     "CREATED_AT" AS "CREATED_AT"
FROM {{ ref('SRC', 'EMP_SOURCE') }} "EMP_SOURCE"