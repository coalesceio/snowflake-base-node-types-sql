@id("ef28f053-c3b2-4207-9a2d-4f3faf614428")
@nodeType("6fda2820-4404-4b60-bad3-cf0edd7dab92")

WITH RECURSIVE RCTE_FINAL AS (

    -- Anchor clause: top-level employees (no manager)
    SELECT
        "EMPLOYEES_RECUR"."EMPLOYEE_ID"  AS "EMPLOYEE_ID",
        1                                AS "LEVEL",
        "EMPLOYEES_RECUR"."TITLE"        AS "TITLE",
        "EMPLOYEES_RECUR"."MANAGER_ID"   AS "MANAGER_ID"
    FROM {{ ref('SRC', 'EMPLOYEES_RECUR') }} AS "EMPLOYEES_RECUR"
    WHERE "EMPLOYEES_RECUR"."MANAGER_ID" IS NULL

    UNION ALL

    -- Recursive clause: employees reporting to someone in the CTE
    SELECT
        "EMPLOYEES_RECUR"."EMPLOYEE_ID"  AS "EMPLOYEE_ID",
        "RCTE_FINAL"."LEVEL" + 1         AS "LEVEL",
        "EMPLOYEES_RECUR"."TITLE"        AS "TITLE",
        "EMPLOYEES_RECUR"."MANAGER_ID"   AS "MANAGER_ID"
    FROM {{ ref('SRC', 'EMPLOYEES_RECUR') }} AS "EMPLOYEES_RECUR"
    JOIN RCTE_FINAL
        ON "EMPLOYEES_RECUR"."MANAGER_ID" = "RCTE_FINAL"."EMPLOYEE_ID"

)

SELECT
    "LEVEL"          AS "LEVEL",
    "TITLE"::VARCHAR AS "TITLE"
FROM RCTE_FINAL