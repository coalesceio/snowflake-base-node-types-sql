@id("9a7ad486-570f-4a56-89b2-3f00febb39a0")
@nodeType("707")
@materializationType("view")
SELECT
     "EMPLOYEE_ID" AS "EMPLOYEE_ID",
     "TITLE" AS "TITLE",
     "MANAGER_ID" AS "MANAGER_ID",
     "ORG_LEVEL" AS "ORG_LEVEL",
     "PATH" AS "PATH"
FROM {{ ref('SRC', 'V_EMPLOYEES_CTE') }} "V_EMPLOYEES_CTE"