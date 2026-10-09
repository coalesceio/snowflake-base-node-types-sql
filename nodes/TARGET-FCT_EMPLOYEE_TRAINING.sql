@id("13c1928f-10fe-40d9-a8d3-bc305d026043")
@nodeType("Latest220:::SQLFact")
@mergeStrategy("allColumnMatch")
SELECT
    COALESCE("DE"."DIM_EMPLOYEE_KEY", 0) AS "DIM_EMPLOYEE_KEY"   @id("3d965a") @not_null,
    COALESCE("DT"."DIM_TRAINING_KEY", 0) AS "DIM_TRAINING_KEY"   @id("df5adf") @not_null,
    "ET"."EMPLOYEE_ID"                   AS "EMPLOYEE_ID"        @id("ecd52f") @not_null,
    "ET"."TRAINING_ID"                   AS "TRAINING_ID"        @id("d922a8") @not_null,
    "ET"."TRAINING_DATE"                 AS "TRAINING_DATE"      @id("706922") @not_null,
    "ET"."TRAINING_STATUS"               AS "TRAINING_STATUS"    @id("5f0d9c"),
    "ET"."TRAINING_TYPE"                 AS "TRAINING_TYPE"      @id("ea45ba"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("4d042c") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("edde37") @isSystemUpdateDate
FROM {{ ref('TARGET', 'WRK_EMPLOYEE_TRAINING') }} "ET"
LEFT JOIN {{ ref('TARGET', 'DIM_EMPLOYEE') }} "DE"
    ON "ET"."EMPLOYEE_ID" = "DE"."EMPLOYEE_ID"
   AND CAST("ET"."TRAINING_DATE" AS TIMESTAMP) <= "DE"."SYSTEM_END_DATE"
   AND (CAST("ET"."TRAINING_DATE" AS TIMESTAMP) >= "DE"."SYSTEM_CREATE_DATE" OR "DE"."SYSTEM_VERSION" = 1)
LEFT JOIN {{ ref('TARGET', 'DIM_TRAINING') }} "DT"
    ON "ET"."TRAINING_ID" = "DT"."TRAINING_ID"
   AND CAST("ET"."TRAINING_DATE" AS TIMESTAMP) <= "DT"."SYSTEM_END_DATE"
   AND (CAST("ET"."TRAINING_DATE" AS TIMESTAMP) >= "DT"."SYSTEM_CREATE_DATE" OR "DT"."SYSTEM_VERSION" = 1)
