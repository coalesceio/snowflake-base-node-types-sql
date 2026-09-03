@id("bc35cc60-b3ee-40e2-af07-0708af31fb12")
@nodeType("1")
@selectDistinct(true)
@testsEnabled(true)
SELECT
     "TITLE" AS "TITLE" @nullable("false") @description("ABC") @defaultValue("ABC"),
     "EMPLOYEE_ID" AS "EMPLOYEE_ID",
     "MANAGER_ID" AS "MANAGER_ID"
FROM {{ ref('SRC', 'EMPLOYEES') }} "EMPLOYEES"