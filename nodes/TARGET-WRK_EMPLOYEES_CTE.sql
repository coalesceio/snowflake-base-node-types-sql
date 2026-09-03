@id("acc95404-30cf-4e74-b7db-a46f74cbe015")
@nodeType("704")
WITH RECURSIVE OrgChart AS (
    -- Anchor Clause: Start with the CEO (who has no manager)
    SELECT 
        EMPLOYEE_ID, 
        TITLE, 
        MANAGER_ID, 
        1 AS ORG_LEVEL,
        CAST(TITLE AS STRING) AS PATH
    FROM {{ ref('SRC', 'EMPLOYEES') }}
    WHERE MANAGER_ID IS NULL

    UNION ALL

    -- Recursive Clause: Join employees to their managers found in the anchor
    SELECT 
        E.EMPLOYEE_ID, 
        E.TITLE, 
        E.MANAGER_ID, 
        OC.ORG_LEVEL + 1,
        OC.PATH || ' -> ' || E.TITLE
    FROM {{ ref('SRC', 'EMPLOYEES') }} E
    JOIN OrgChart OC ON E.MANAGER_ID = OC.EMPLOYEE_ID
)
SELECT * FROM 
OrgChart 
ORDER BY ORG_LEVEL;