@id("7e57a000-0000-4000-8000-000000000104")
@nodeType("SQLFact")
@mergeStrategy("allColumnMatch")
@writeMode("append")
@description("Fact test: allColumnMatch factless fact - nation/region coverage, insert-only on full-row match")
@preSQL("SELECT COUNT(DISTINCT ""REGIONKEY"") AS SOURCE_REGIONS FROM {{ ref('SRC', 'Nation_Test') }}")
@postSQL("SELECT COUNT(*) AS POST_SQL_ROWS FROM {{ this }}")
@tests("SELECT 1 FROM {{ this }} GROUP BY ""NATION_KEY"", ""REGION_KEY"", ""GH_COVERAGE"" HAVING COUNT(*) > 1")
@tests("SELECT 1 FROM {{ ref('SRC', 'Nation_Test') }} s WHERE NOT EXISTS (SELECT 1 FROM {{ this }} t WHERE t.""NATION_KEY"" = s.""NAtionKey"")", true, "After")
SELECT
    "NAtionKey"                                     AS "NATION_KEY"         @id("f10401") @not_null @uniqueness @min_max("0", "24") @inHash("GH_COVERAGE", 1),
    "REGIONKEY"                                     AS "REGION_KEY"         @id("f10402") @not_null @accepted_values("0, 1, 2, 3, 4") @inHash("GH_COVERAGE", 2),
    {{ get_hash('GH_COVERAGE', 'SHA256') }}::STRING AS "GH_COVERAGE"        @id("f10403") @not_null @uniqueness @empty,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)            AS "SYSTEM_CREATE_DATE" @id("f1040e") @isSystemCreateDate @not_null @relative_time("<=", "SYSTEM_UPDATE_DATE"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)            AS "SYSTEM_UPDATE_DATE" @id("f1040f") @isSystemUpdateDate @not_null @freshness(7, "DAY")
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
