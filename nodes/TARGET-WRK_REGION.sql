@id("dfad5c2e-55d3-4218-9656-3e9728cb025b")
@nodeType("707")
@description("Work table of TPC-H regions")
SELECT
    "REGION"."R_REGIONKEY" AS "R_REGIONKEY" @id("de3128") @not_null @uniqueness @min_max("0", "4") @description("Region key (primary key)"),
    "REGION"."R_NAME"      AS "R_NAME"      @id("2e21ef") @not_null @empty @accepted_values("'AFRICA', 'AMERICA', 'ASIA', 'EUROPE', 'MIDDLE EAST'") @description("Region name"),
    "REGION"."R_COMMENT"   AS "R_COMMENT"   @id("de3c5c") @description("Free-text comment about the region")
FROM {{ ref('SRC', 'REGION') }} "REGION"
