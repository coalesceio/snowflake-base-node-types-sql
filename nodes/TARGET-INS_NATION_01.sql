@id("01be8e32-88de-4f16-b935-a92aa698769f")
@nodeType("6fda2820-4404-4b60-bad3-cf0edd7dab92")


@truncateBefore
@selectDistinct
@preSQL("SELECT count(*) FROM TANVI_DEV.SOURCE.NATION")
@postSQL("SELECT count(*) FROM TANVI_DEV.SOURCE.NATION")
@groupByAll
@preTests(" continueOnFailure: SELECT count(*) FROM TANVI_DEV.SOURCE.NATION WHERE N_NATIONKEY > 0 ")

SELECT
     "N_NATIONKEY" AS "N_NATIONKEY",
     "N_NAME" AS "N_NAME",
     "N_REGIONKEY" AS "N_REGIONKEY",
     "N_COMMENT" AS "N_COMMENT",
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP"
FROM {{ ref('SRC', 'NATION') }} "NATION"