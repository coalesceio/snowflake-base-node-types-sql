@id("13c1928f-10fe-40d9-a8d3-bc305d026043")
@nodeType("SQLFact")
@materializationType("table")
@description("Employee training - enrolment fact (change tracking) keyed to employee and training dimensions")
@mergeStrategy("changeTracking")
@tests("SELECT 1 FROM {{ this }} GROUP BY EMPLOYEE_ID, TRAINING_ID, TRAINING_DATE HAVING COUNT(*) > 1", false, "After")
SELECT
    "ET"."EMPLOYEE_ID" AS "EMPLOYEE_ID" @id("ab9306b1-eece-47fb-a3b4-57a1ca52d212") @isBusinessKey @clusterKey(2) @description("Employee Id") @uniqueness,
    "ET"."TRAINING_ID" AS "TRAINING_ID" @id("6fe653c2-6e85-4f43-9788-9afd4f35d91a") @isBusinessKey,
    "ET"."TRAINING_DATE" AS "TRAINING_DATE" @id("c5b3f0b4-f788-4f54-98e9-f5938faa6491") @isBusinessKey @clusterKey(1, "DATE_TRUNC('MONTH', ""TRAINING_DATE"")"),
    COALESCE("DE"."DIM_EMPLOYEE_KEY", -1) AS "DIM_EMPLOYEE_KEY" @id("620c516f-cdd2-41f2-b10d-4dc7eefec43c") @not_null,
    COALESCE("DT"."DIM_TRAINING_KEY", -1) AS "DIM_TRAINING_KEY" @id("3693bd3c-fb93-48e7-88fe-a97d3c860ccc") @not_null,
    "ET"."TRAINING_STATUS" AS "TRAINING_STATUS" @id("a122cbc5-9f26-47c9-ba0a-f4ae6b159199"),
    "ET"."TRAINING_TYPE" AS "TRAINING_TYPE" @id("16f80a7b-c516-43c6-8fe4-ccd0ca184560"),
    CAST(CASE WHEN "ET"."TRAINING_STATUS" = 'COMPLETED' THEN 1 ELSE 0 END AS NUMBER(1,0)) AS "IS_COMPLETED" @id("b97b96c9-d0cc-4860-8c8d-35e5f3dbd441") @accepted_values("0, 1"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("af9d70d0-5321-4062-9e07-91daf0373020") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("7fffad9b-83ea-4583-b71a-a851d84a285e") @isSystemUpdateDate
FROM {{ ref('TARGET', 'WRK_EMPLOYEE_TRAINING') }} "ET"
LEFT JOIN {{ ref('TARGET', 'DIM_EMPLOYEE') }} "DE"
    ON "ET"."EMPLOYEE_ID" = "DE"."EMPLOYEE_ID"
    AND CAST("ET"."TRAINING_DATE" AS TIMESTAMP) <= "DE"."SYSTEM_END_DATE"
    AND (CAST("ET"."TRAINING_DATE" AS TIMESTAMP) >= "DE"."SYSTEM_CREATE_DATE" OR "DE"."SYSTEM_VERSION" = 1)
LEFT JOIN {{ ref('TARGET2', 'DIM_TRAINING') }} "DT"
    ON "ET"."TRAINING_ID" = "DT"."TRAINING_ID"
