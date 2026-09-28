@id("93679e68-9fce-4782-84dc-647864bd2a7d")
@nodeType("707")
@description("Work table aggregating Nation_Test to one row per region via a CTE")
@tests("SELECT 1 FROM {{ this }} WHERE ""NATION_COUNT"" = 0")
WITH "NATION_SRC" AS (
    SELECT "NAtionKey", "name", "REGIONKEY", "N_Load_Timestamp"
    FROM {{ ref('SRC', 'Nation_Test') }}
)
SELECT
    "NATION_SRC"."REGIONKEY"                 AS "REGIONKEY"           @id("01b100") @not_null @uniqueness @description("Identifier of the region"),
    COUNT(DISTINCT "NATION_SRC"."NAtionKey") AS "NATION_COUNT"        @id("c89e1d") @min_value("1") @description("Number of distinct nations in the region"),
    LISTAGG("NATION_SRC"."name", ', ')       AS "NATION_NAMES"        @id("1befce") @description("Comma-separated list of nation names in the region"),
    MAX("NATION_SRC"."N_Load_Timestamp")     AS "LAST_LOAD_TIMESTAMP" @id("9a0746") @description("Most recent source load timestamp in the region")
FROM "NATION_SRC"
GROUP BY "NATION_SRC"."REGIONKEY"
