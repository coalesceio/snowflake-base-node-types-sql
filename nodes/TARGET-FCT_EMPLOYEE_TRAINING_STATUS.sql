@id("f9e55476-5192-4316-83b8-e796657f07d3")
@nodeType("SQLFact")
@mergeStrategy("upsert")
@tests("SELECT 1 FROM {{ this }} GROUP BY EMPLOYEE_ID, TRAINING_ID HAVING COUNT(*) > 1", false, "After")
WITH "LATEST_ATTEMPT" AS (
    -- One row per employee + training: the most recent attempt, plus attempt history
    SELECT
        "EMPLOYEE_ID",
        "TRAINING_ID",
        "TRAINING_STATUS"                                                    AS "LATEST_STATUS",
        "TRAINING_TYPE"                                                      AS "LATEST_TRAINING_TYPE",
        MIN("TRAINING_DATE") OVER (PARTITION BY "EMPLOYEE_ID", "TRAINING_ID") AS "FIRST_TRAINING_DATE",
        "TRAINING_DATE"                                                      AS "LATEST_TRAINING_DATE",
        COUNT(*) OVER (PARTITION BY "EMPLOYEE_ID", "TRAINING_ID")            AS "ATTEMPT_COUNT"
    FROM {{ ref('TARGET', 'WRK_EMPLOYEE_TRAINING') }}
    QUALIFY ROW_NUMBER() OVER (
        PARTITION BY "EMPLOYEE_ID", "TRAINING_ID"
        ORDER BY "TRAINING_DATE" DESC, "TRAINING_STATUS" DESC
    ) = 1
)
SELECT
    "ET"."EMPLOYEE_ID"                                                 AS "EMPLOYEE_ID"          @id("9fa8c4") @isBusinessKey @not_null,
    "ET"."TRAINING_ID"                                                 AS "TRAINING_ID"          @id("56fd3d") @isBusinessKey @not_null,
    COALESCE("DE"."DIM_EMPLOYEE_KEY", 0)                               AS "DIM_EMPLOYEE_KEY"     @id("bc1959") @not_null,
    COALESCE("DT"."DIM_TRAINING_KEY", 0)                               AS "DIM_TRAINING_KEY"     @id("1473a7") @not_null,
    "ET"."LATEST_STATUS"                                               AS "LATEST_STATUS"        @id("c2f6ec"),
    "ET"."LATEST_TRAINING_TYPE"                                        AS "LATEST_TRAINING_TYPE" @id("8534fc"),
    "ET"."FIRST_TRAINING_DATE"                                         AS "FIRST_TRAINING_DATE"  @id("cba1bc") @not_null,
    "ET"."LATEST_TRAINING_DATE"                                        AS "LATEST_TRAINING_DATE" @id("b783da") @not_null,
    "ET"."ATTEMPT_COUNT"                                               AS "ATTEMPT_COUNT"        @id("07904b") @min_value("1"),
    CASE WHEN "ET"."LATEST_STATUS" = 'COMPLETED' THEN 'Y' ELSE 'N' END AS "IS_COMPLETED"         @id("fda85d") @accepted_values("'Y', 'N'"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)                               AS "SYSTEM_CREATE_DATE"   @id("67fd95") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)                               AS "SYSTEM_UPDATE_DATE"   @id("01b992") @isSystemUpdateDate
FROM "LATEST_ATTEMPT" "ET"
LEFT JOIN {{ ref('TARGET', 'DIM_EMPLOYEE') }} "DE"
    ON "ET"."EMPLOYEE_ID" = "DE"."EMPLOYEE_ID"
   AND "DE"."SYSTEM_CURRENT_FLAG" = 'Y'
LEFT JOIN {{ ref('TARGET', 'DIM_TRAINING') }} "DT"
    ON "ET"."TRAINING_ID" = "DT"."TRAINING_ID"
   AND "DT"."SYSTEM_CURRENT_FLAG" = 'Y'
