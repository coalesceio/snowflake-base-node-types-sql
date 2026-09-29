@id("05aa12c9-41a4-4e2c-ab09-a69543274ced")
@nodeType("718")
@description("Gold: current version of each customer (Dimension materialized as a view)")
@materializationType("view")
SELECT
    "C_CUSTKEY"                              AS "C_CUSTKEY"           @id("845497") @description("Customer identifier"),
    "C_NAME"                                 AS "C_NAME"              @id("53e5b0") @description("Customer name"),
    "C_MKTSEGMENT"                           AS "C_MKTSEGMENT"        @id("8cc582") @description("Market segment"),
    "NATION_NAME"                            AS "NATION_NAME"         @id("802908") @description("Nation name"),
    "C_ACCTBAL"                              AS "C_ACCTBAL"           @id("c3cf9e") @description("Account balance"),
    "SYSTEM_CREATE_DATE"                     AS "VERSION_START"       @id("c1ae46") @description("When this version became current")
FROM {{ ref('TARGET', 'GLD_DIM_CUSTOMER') }} "GLD_DIM_CUSTOMER"
WHERE "SYSTEM_CURRENT_FLAG" = 'Y'
