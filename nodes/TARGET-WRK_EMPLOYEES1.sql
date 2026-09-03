@id("8eaa4250-cb2a-403c-aeef-af16302e783e")
@nodeType("707")
SELECT
     "TITLE" AS "TITLE",
     OBJECT_CONSTRUCT('emp_id',EMPLOYEE_ID,'mana_id',
     MANAGER_ID)AS EMP_INFO
FROM {{ ref('SRC', 'EMPLOYEES') }} "EMPLOYEES"