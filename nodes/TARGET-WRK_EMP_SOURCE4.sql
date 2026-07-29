@id("3cdc04e4-d7c5-479a-80f8-02c96ed00a8b")
@nodeType("664")
@testsEnabled(true)
@tests("SELECT 1 FROM {{ this }} GROUP BY EMP_NAME HAVING COUNT(*) > 1", "Before", true)
@orderby(true)
@orderbycolumn("[object Object]", "desc")
SELECT
     "EMP_ID" AS "EMP_ID",
     "EMP_NAME" AS "EMP_NAME" @tests('null'),
     "EMP_CITY" AS "EMP_CITY",
     "DML_FLAG" AS "DML_FLAG",
     "CREATED_AT" AS "CREATED_AT"
FROM {{ ref('SRC', 'EMP_SOURCE') }} "EMP_SOURCE"