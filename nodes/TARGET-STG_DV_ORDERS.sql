@id("d89bb8e1-30e1-4891-9d0c-8690d13b9e0c")
@nodeType("707")
@writeMode("truncateInsert")
SELECT
    {{ get_hash('HK_ORDER', 'MD5') }}::STRING            AS "HK_ORDER"            @id("8940e5") @not_null @uniqueness,
    {{ get_hash('HK_CUSTOMER', 'MD5') }}::STRING         AS "HK_CUSTOMER"         @id("687f02") @not_null,
    {{ get_hash('HK_L_ORDER_CUSTOMER', 'MD5') }}::STRING AS "HK_L_ORDER_CUSTOMER" @id("1d501c") @not_null,
    {{ get_hash('HASHDIFF_ORDER', 'MD5') }}::STRING      AS "HASHDIFF_ORDER"      @id("dd5c1c") @not_null,
    "ORDERS"."O_ORDERKEY"                                AS "O_ORDERKEY"          @id("a49abe") @inHash("HK_ORDER", 1) @inHash("HK_L_ORDER_CUSTOMER", 1) @not_null,
    "ORDERS"."O_CUSTKEY"                                 AS "O_CUSTKEY"           @id("a3cdb3") @inHash("HK_CUSTOMER", 1) @inHash("HK_L_ORDER_CUSTOMER", 2),
    "ORDERS"."O_ORDERSTATUS"                             AS "O_ORDERSTATUS"       @id("a13aad") @inHash("HASHDIFF_ORDER", 1),
    "ORDERS"."O_TOTALPRICE"                              AS "O_TOTALPRICE"        @id("a1755e") @inHash("HASHDIFF_ORDER", 2),
    "ORDERS"."O_ORDERDATE"                               AS "O_ORDERDATE"         @id("751bf5") @inHash("HASHDIFF_ORDER", 3),
    "ORDERS"."O_ORDERPRIORITY"                           AS "O_ORDERPRIORITY"     @id("77862f") @inHash("HASHDIFF_ORDER", 4),
    "ORDERS"."O_CLERK"                                   AS "O_CLERK"             @id("7678ad") @inHash("HASHDIFF_ORDER", 5),
    "ORDERS"."O_SHIPPRIORITY"                            AS "O_SHIPPRIORITY"      @id("02bb50") @inHash("HASHDIFF_ORDER", 6),
    "ORDERS"."O_COMMENT"                                 AS "O_COMMENT"           @id("457f0e") @inHash("HASHDIFF_ORDER", 7),
    'TPCH.ORDERS'                                        AS "RECORD_SOURCE"       @id("99508b"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)                 AS "LOAD_DTS"            @id("53d236")
FROM {{ ref('SRC', 'ORDERS') }} "ORDERS"
