@id("251045c2-5d11-4f42-a6c8-0fda76f6eb20")
@nodeType("SQLWork")
@materializationType("view")
@tag("PII", "NAME", "GOV")
@description("Employee training - cleansed employee")
@writeMode("truncateInsert")
SELECT
    UPPER(TRIM("EMPLOYEE"."EMPLOYEE_ID")) AS "EMPLOYEE_ID" @notNull @not_null @uniqueness @clusterKey(2),
    TRIM("EMPLOYEE"."EMPLOYEE_NAME") AS "EMPLOYEE_NAME" @not_null @tag("PII", "NAME", "GOV"),
    INITCAP(TRIM("EMPLOYEE"."DEPARTMENT")) AS "DEPARTMENT" @clusterKey(1),
    INITCAP(TRIM("EMPLOYEE"."LOCATION")) AS "LOCATION"
FROM {{ ref('SRC', 'EMPLOYEE') }} "EMPLOYEE"
WHERE "EMPLOYEE"."EMPLOYEE_ID" IS NOT NULL
