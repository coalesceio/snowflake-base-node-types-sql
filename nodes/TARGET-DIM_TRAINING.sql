@id("ad5e63b0-9fe2-416a-a918-e0ea9275b57d")
@nodeType("SQLDimension")
@materializationType("table")
@tag("PII", "NAME", "GOV")
@description("Employee training - training dimension (change tracking, SCD1)")
@mergeStrategy("changeTracking")
@zeroKey("-1", "'UNKNOWN'", "1900-01-01 00:00:00", false)
@tests("SELECT TRAINING_ID FROM {{ ref('TARGET', 'WRK_TRAINING') }} GROUP BY TRAINING_ID HAVING COUNT(*) > 1 OR TRAINING_ID IS NULL", false, "Before")
SELECT
    0 AS "DIM_TRAINING_KEY" @id("b2921cd1-4436-4f87-842b-7f242b50e199") @isSurrogateKey,
    "T"."TRAINING_ID" AS "TRAINING_ID" @id("bc3eee4a-3df0-4057-bf43-a796a42401e5") @isBusinessKey @clusterKey(1),
    "T"."TRAINING_NAME" AS "TRAINING_NAME" @id("a1c6379c-c645-4e81-917f-5156d1101411"),
    "T"."TRAINER" AS "TRAINER" @id("72002e92-18dd-4d1d-afd8-c868276472d4") @tag("PII", "NAME", "GOV"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("e636d2d0-9a48-4575-8748-972f2dfe9ba8") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("fe9079e8-7f04-4cb3-a24a-97aaf9c2079d") @isSystemUpdateDate
FROM {{ ref('TARGET', 'WRK_TRAINING') }} "T"
