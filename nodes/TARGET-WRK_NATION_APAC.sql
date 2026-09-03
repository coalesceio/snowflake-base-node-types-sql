@id("bef59018-6a23-4505-87b5-070ca420ff81")
@nodeType("707")
@disableTests
@writeMode("append")
@description("V2 Work node feeding a downstream V1 Stage node")
SELECT
     "N_NATIONKEY" AS "N_NATIONKEY" @not_null @uniqueness,
     "N_NAME" AS "N_NAME" @not_null,
     "N_REGIONKEY" AS "N_REGIONKEY" @min_max("0", "4")
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"
