@id("b64688ac-0450-4851-8028-55bf178e9f4c")
@nodeType("707")
@description("Gold: current version of each customer (SQL Work as a view)")
@materializationType("view")
SELECT
    "GLD_DIM_CUSTOMER"."C_CUSTKEY"      AS "C_CUSTKEY"      @id("87626c"),
    "GLD_DIM_CUSTOMER"."C_NAME"         AS "C_NAME"         @id("ccd04e"),
    "GLD_DIM_CUSTOMER"."C_MKTSEGMENT"   AS "C_MKTSEGMENT"   @id("07e0fc"),
    "GLD_DIM_CUSTOMER"."NATION_NAME"    AS "NATION_NAME"    @id("c4fc51"),
    "GLD_DIM_CUSTOMER"."SYSTEM_VERSION" AS "SYSTEM_VERSION" @id("230a34")
FROM {{ ref('TARGET', 'GLD_DIM_CUSTOMER') }} "GLD_DIM_CUSTOMER"
WHERE "GLD_DIM_CUSTOMER"."SYSTEM_CURRENT_FLAG" = 'Y'
