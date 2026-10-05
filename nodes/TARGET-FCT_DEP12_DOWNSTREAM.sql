@id("26f3e76d-a107-457b-ad97-97d731ed7f2f")
@nodeType("SQLFact")
@mergeStrategy("changeTracking")
SELECT
    "FCT_DEP01_COLUMN_CHANGES"."N_NATIONKEY"                 AS "N_NATIONKEY"        @id("0d1201") @isBusinessKey,
    "FCT_DEP01_COLUMN_CHANGES"."N_NAME"                      AS "N_NAME"             @id("0d1202"),
    "FCT_DEP01_COLUMN_CHANGES"."N_REGIONKEY"                 AS "N_REGIONKEY"        @id("0d1203"),
    "FCT_DEP01_COLUMN_CHANGES"."N_COMMENT"                   AS "N_COMMENT"          @id("0d1204"),
    "FCT_DEP01_COLUMN_CHANGES"."N_LOAD_TIMESTAMP"            AS "N_LOAD_TIMESTAMP"   @id("0d1205"),
    "FCT_DEP01_COLUMN_CHANGES"."N_DATE"                      AS "N_DATE"             @id("0d1206"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("0d1207") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("0d1208") @isSystemUpdateDate
FROM {{ ref('TARGET', 'FCT_DEP01_COLUMN_CHANGES') }} "FCT_DEP01_COLUMN_CHANGES"
