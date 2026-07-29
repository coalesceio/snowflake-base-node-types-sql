@id("215f9bfe-ccb1-4e6b-b1b4-ab792caef94b")
@nodeType("664")
@testsEnabled(true)
@tests("SELECT 1 FROM {{ this }} GROUP BY EMP_NAME HAVING COUNT(*) > 1", "After", true)
@tests("SELECT 1 FROM {{ this }} GROUP BY EMP_NAME HAVING COUNT(*) > 1", "After", true)

SELECT
     "EMP_ID" AS "EMP_ID",
     "EMP_NAME" AS "EMP_NAME",
     "EMP_CITY" AS "EMP_CITY" @tests('null'),
     "DML_FLAG" AS "DML_FLAG",
     "CREATED_AT" AS "CREATED_AT"
FROM {{ ref('SRC', 'EMP_SOURCE') }} "EMP_SOURCE"