@id("9a4c5413-2ea8-4c30-a918-233a663b15a1")
@nodeType("707")
SELECT
     e.EMPLOYEE_ID AS "emp_id",
     m.EMPLOYEE_ID  AS "man_id"
FROM {{ ref('SRC', 'EMPLOYEES') }} e
LEFT JOIN {{ ref('SRC', 'EMPLOYEES') }}  m 
    ON e.Manager_ID = m.Employee_ID;