@id("251045c2-5d11-4f42-a6c8-0fda76f6eb20")
@nodeType("Latest220:::SQLFact")
@writeMode("truncateInsert")
SELECT
    UPPER(TRIM("EMPLOYEE"."EMPLOYEE_ID"))  AS "EMPLOYEE_ID"   @id("2c4097") @not_null @uniqueness,
    TRIM("EMPLOYEE"."EMPLOYEE_NAME")       AS "EMPLOYEE_NAME" @id("932257") @not_null,
    INITCAP(TRIM("EMPLOYEE"."DEPARTMENT")) AS "DEPARTMENT"    @id("d510ef"),
    INITCAP(TRIM("EMPLOYEE"."LOCATION"))   AS "LOCATION"      @id("ba5f1f")
FROM {{ ref('SRC', 'EMPLOYEE') }} "EMPLOYEE"
WHERE "EMPLOYEE"."EMPLOYEE_ID" IS NOT NULL
