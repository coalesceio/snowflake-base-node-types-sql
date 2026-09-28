@id("0c060512-e2a7-4b49-9a1b-5a4c3ee46fae")
@nodeType("707")
@description("Work table of TPC-H nations")
SELECT
    "NATION"."N_NATIONKEY" AS "N_NATIONKEY" @id("e4f7ed") @not_null @uniqueness @min_max("0", "24") @description("Nation key (primary key)"),
    "NATION"."N_NAME"      AS "N_NAME"      @id("c727bd") @not_null @empty @description("Nation name"),
    "NATION"."N_REGIONKEY" AS "N_REGIONKEY" @id("780f55") @not_null @accepted_values("0, 1, 2, 3, 4") @description("Region key of the nation (FK to REGION)"),
    "NATION"."N_COMMENT"   AS "N_COMMENT"   @id("aeb8e3") @description("Free-text comment about the nation")
FROM {{ ref('SRC', 'NATION') }} "NATION"
