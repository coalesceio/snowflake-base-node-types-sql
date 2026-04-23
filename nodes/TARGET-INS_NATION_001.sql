@id("054c1ed5-6c99-4f09-8c8c-80321e786926")
@nodeType("6fda2820-4404-4b60-bad3-cf0edd7dab92")

@truncateBefore
@selectDistinct
@preSQL("SELECT count(*) FROM TANVI_DEV.SOURCE.NATION")
@postSQL("SELECT count(*) FROM TANVI_DEV.SOURCE.NATION")
@groupByAll
@preTests("continueOnFailure:SELECT count(*) FROM TANVI_DEV.SOURCE.NATION WHERE N_NATIONKEY > 0 ")

SELECT
     "N_NATIONKEY" AS "N_NATIONKEY" @nullable(false),
     "N_NAME" AS "N_NAME" @description("Name column"),
     "N_REGIONKEY" AS "N_REGIONKEY" @defaultValue(0),
     "N_COMMENT" AS "N_COMMENT" @tests("null"),
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP"
FROM {{ ref('SRC', 'NATION') }} "NATION"