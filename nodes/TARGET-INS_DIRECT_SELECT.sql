@id("56afcd4e-ec7f-4ef1-9e99-cb5ebab78b4b")
@nodeType("6fda2820-4404-4b60-bad3-cf0edd7dab92")
@selectDistinct(true)
@testsEnabled(true)
@preContinueOnFailure(true)
@postContinueOnFailure(true)


SELECT
     "N_NATIONKEY" @isBusinessKey,
     "N_NAME",
     "N_REGIONKEY",
     "N_COMMENT",
     "N_LOAD_TIMESTAMP",
     "N_LOAD_TIMESTAMP"::TIMESTAMP_NTZ @isSystemCreateDate,
     CAST("N_LOAD_TIMESTAMP" AS TIMESTAMP) @isSystemUpdateDate
FROM {{ ref('SRC', 'NATION') }} "NATION"