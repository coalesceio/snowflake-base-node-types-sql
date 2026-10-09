@id("3f7607d4-153f-4195-84ae-bd5205c1659e")
@nodeType("Latest220:::SQLWork")
@writeMode("truncateInsert")
SELECT
    UPPER(TRIM("TRAINING"."TRAINING_ID")) AS "TRAINING_ID"   @id("6677fd") @not_null @uniqueness,
    TRIM("TRAINING"."TRAINING_NAME")      AS "TRAINING_NAME" @id("c61e9f") @not_null,
    TRIM("TRAINING"."TRAINER")            AS "TRAINER"       @id("252337")
FROM {{ ref('SRC', 'TRAINING') }} "TRAINING"
WHERE "TRAINING"."TRAINING_ID" IS NOT NULL
