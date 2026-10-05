@id("0350da90-f4eb-4ca9-8e2b-26d395602edf")
@nodeType("707")
@writeMode("truncateInsert")
SELECT
    "PART"."P_PARTKEY"     AS "P_PARTKEY"     @id("0022d4") @not_null @uniqueness,
    TRIM("PART"."P_NAME")  AS "P_NAME"        @id("d065b8"),
    "PART"."P_MFGR"        AS "P_MFGR"        @id("8c5cc4"),
    "PART"."P_BRAND"       AS "P_BRAND"       @id("c3511c"),
    "PART"."P_TYPE"        AS "P_TYPE"        @id("22af63"),
    "PART"."P_SIZE"        AS "P_SIZE"        @id("3de3c8"),
    "PART"."P_CONTAINER"   AS "P_CONTAINER"   @id("7469aa"),
    "PART"."P_RETAILPRICE" AS "P_RETAILPRICE" @id("ef608d") @min_value("0")
FROM {{ ref('SRC', 'PART') }} "PART"
