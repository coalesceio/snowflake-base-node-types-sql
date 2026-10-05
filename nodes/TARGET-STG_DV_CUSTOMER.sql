@id("6887d430-ae21-4a3d-b664-3a04bb417e5f")
@nodeType("707")
@writeMode("truncateInsert")
SELECT
    {{ get_hash('HK_CUSTOMER', 'MD5') }}::STRING          AS "HK_CUSTOMER"          @id("c9ee12") @not_null @uniqueness,
    {{ get_hash('HK_NATION', 'MD5') }}::STRING            AS "HK_NATION"            @id("c828c7") @not_null,
    {{ get_hash('HK_L_CUSTOMER_NATION', 'MD5') }}::STRING AS "HK_L_CUSTOMER_NATION" @id("69130d") @not_null,
    {{ get_hash('HASHDIFF_CUSTOMER', 'MD5') }}::STRING    AS "HASHDIFF_CUSTOMER"    @id("12fd4a") @not_null,
    "CUSTOMER"."C_CUSTKEY"                                AS "C_CUSTKEY"            @id("80b80e") @inHash("HK_CUSTOMER", 1) @inHash("HK_L_CUSTOMER_NATION", 1) @not_null,
    "CUSTOMER"."C_NATIONKEY"                              AS "C_NATIONKEY"          @id("0ac3e8") @inHash("HK_NATION", 1) @inHash("HK_L_CUSTOMER_NATION", 2),
    "CUSTOMER"."C_NAME"                                   AS "C_NAME"               @id("0175f0") @inHash("HASHDIFF_CUSTOMER", 1),
    "CUSTOMER"."C_ADDRESS"                                AS "C_ADDRESS"            @id("017132") @inHash("HASHDIFF_CUSTOMER", 2),
    "CUSTOMER"."C_PHONE"                                  AS "C_PHONE"              @id("071098") @inHash("HASHDIFF_CUSTOMER", 3),
    "CUSTOMER"."C_ACCTBAL"                                AS "C_ACCTBAL"            @id("76fb77") @inHash("HASHDIFF_CUSTOMER", 4),
    "CUSTOMER"."C_MKTSEGMENT"                             AS "C_MKTSEGMENT"         @id("75a0d7") @inHash("HASHDIFF_CUSTOMER", 5),
    "CUSTOMER"."C_COMMENT"                                AS "C_COMMENT"            @id("90346a") @inHash("HASHDIFF_CUSTOMER", 6),
    'TPCH.CUSTOMER'                                       AS "RECORD_SOURCE"        @id("57b8cb"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)                  AS "LOAD_DTS"             @id("9d9439")
FROM {{ ref('SRC', 'CUSTOMER') }} "CUSTOMER"
