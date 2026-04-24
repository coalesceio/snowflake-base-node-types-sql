@id("029c9b8a-ce8d-4901-b907-155cbc5d219f")
@nodeType("ece2dca8-2416-4db4-b6ae-e12dfb4de042")

SELECT
     HR_DATA_MNC."SL_NO" AS "SL_NO",
     HR_DATA_MNC."EMPLOYEE_ID" AS "EMPLOYEE_ID" @isBusinessKey,
     HR_DATA_MNC."FULL_NAME" AS "FULL_NAME" @isChangeTracking,
     HR_DATA_MNC."DEPARTMENT" AS "DEPARTMENT" @isChangeTracking,
     HR_DATA_MNC."JOB_TITLE" AS "JOB_TITLE" @isChangeTracking,
     HR_DATA_MNC."HIRE_DATE" AS "HIRE_DATE" @isChangeTracking,
     HR_DATA_MNC."LOCATION" AS "LOCATION" @isChangeTracking,
     HR_DATA_MNC."PERFORMANCE_RATING" AS "PERFORMANCE_RATING" @isChangeTracking,
     HR_DATA_MNC."EXPERIENCE_YEARS" AS "EXPERIENCE_YEARS" @isChangeTracking,
     HR_DATA_MNC."STATUS" AS "STATUS" @isChangeTracking,
     HR_DATA_MNC."WORK_MODE" AS "WORK_MODE" @isChangeTracking,
     HR_DATA_MNC."SALARY_INR" AS "SALARY_INR" @isChangeTracking,
     '' AS "SYSTEM_CURRENT_FLAG" @isSystemCurrentFlag,
     1 AS "SYSTEM_VERSION" @isSystemVersion,
     0 AS "CT_SCD2_HR_DATA_MNC_KEY" @isSurrogateKey,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @isSystemUpdateDate,
     CAST('2999-12-31 00:00:00' AS TIMESTAMP) AS "SYSTEM_END_DATE" @isSystemEndDate
FROM {{ ref('SRC', 'HR_DATA_MNC') }} "HR_DATA_MNC"