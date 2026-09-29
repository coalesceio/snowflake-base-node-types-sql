@id("7d5a8cc5-f703-466d-8859-459fe5e7c378")
@nodeType("718")
@description("SQL-authored SCD Type 1 dimension over EMP_SOURCE")
@mergeStrategy("changeTracking")
SELECT
     0 AS "DIM_EMPLOYEE_KEY" @id("0f4194") @isSurrogateKey,
     "EMP_ID" AS "EMP_ID" @id("d80623") @isBusinessKey @not_null,
     "FIRST_NAME" AS "FIRST_NAME" @id("8cd0a4"),
     "LAST_NAME" AS "LAST_NAME" @id("347a3f"),
     "EMAIL" AS "EMAIL" @id("1045d1"),
     "HIRE_DATE" AS "HIRE_DATE" @id("7d6277"),
     "JOB_TITLE" AS "JOB_TITLE" @id("0cce35"),
     "DEPARTMENT_ID" AS "DEPARTMENT_ID" @id("7248ad"),
     "MANAGER_ID" AS "MANAGER_ID" @id("2c833f"),
     "SALARY" AS "SALARY" @id("2ff8d2"),
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("390062") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("477183") @isSystemUpdateDate
FROM {{ ref('SRC', 'EMP_SOURCE') }} "EMP_SOURCE"
