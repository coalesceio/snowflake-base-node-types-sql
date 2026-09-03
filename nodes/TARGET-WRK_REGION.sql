@id("d3b08967-49a9-42b3-bfe8-f71388a8443d")
@nodeType("704")
@testsEnabled
SELECT
     "R_REGIONKEY" AS "R_REGIONKEY" @description("Unique identifier for the region") @tests("unique"),
     "R_NAME" AS "R_NAME" @description("Region name") @defaultValue("'EMEA'"),
     "R_COMMENT" AS "R_COMMENT" @description("Free-text comment about the region"),
     "R_LOAD_TIMESTAMP" AS "R_LOAD_TIMESTAMP" @description("Timestamp when the record was loaded")
FROM {{ ref('SRC', 'REGION') }} "REGION"
