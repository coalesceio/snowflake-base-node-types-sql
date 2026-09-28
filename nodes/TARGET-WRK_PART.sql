@id("fbd734e6-bd3d-460a-96ae-7b2d6211d303")
@nodeType("707")
@description("Work table of TPC-H parts")
SELECT
    "PART"."P_PARTKEY"     AS "P_PARTKEY"     @id("c077c4") @not_null @uniqueness @description("Part key (primary key)"),
    "PART"."P_NAME"        AS "P_NAME"        @id("049730") @not_null @empty @description("Part name"),
    "PART"."P_MFGR"        AS "P_MFGR"        @id("9cb0e5") @description("Part manufacturer"),
    "PART"."P_BRAND"       AS "P_BRAND"       @id("ead98f") @description("Part brand"),
    "PART"."P_TYPE"        AS "P_TYPE"        @id("2ad0ad") @description("Part type"),
    "PART"."P_SIZE"        AS "P_SIZE"        @id("5fa6fc") @min_max("1", "50") @description("Part size"),
    "PART"."P_CONTAINER"   AS "P_CONTAINER"   @id("04f53a") @description("Part container type"),
    "PART"."P_RETAILPRICE" AS "P_RETAILPRICE" @id("7502df") @min_value("0") @description("Part retail price"),
    "PART"."P_COMMENT"     AS "P_COMMENT"     @id("456fc4") @description("Free-text comment about the part")
FROM {{ ref('SRC', 'PART') }} "PART"
