@id("3f7607d4-153f-4195-84ae-bd5205c1659e")
@nodeType("SQLWork")
@materializationType("table")
@tag("PII", "NAME", "GOV")
@description("Employee training - cleansed training catalogue")
@writeMode("truncateInsert")
SELECT
    UPPER(TRIM("TRAINING"."TRAINING_ID")) AS "TRAINING_ID" @notNull @not_null @uniqueness @clusterKey(1),
    TRIM("TRAINING"."TRAINING_NAME") AS "TRAINING_NAME" @not_null,
    TRIM("TRAINING"."TRAINER") AS "TRAINER" @tag("PII", "NAME", "GOV")
FROM {{ ref('SRC', 'TRAINING') }} "TRAINING"
WHERE "TRAINING"."TRAINING_ID" IS NOT NULL
