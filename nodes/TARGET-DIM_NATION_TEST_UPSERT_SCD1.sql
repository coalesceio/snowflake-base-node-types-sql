@id("768f71cf-a343-46b7-8cc4-751e53ca29bf")
@nodeType("718")
@mergeStrategy("upsert")
WITH src AS (
    SELECT
        N_NATIONKEY       AS business_key,
        N_NAME            AS nation_name,
        N_REGIONKEY       AS region_key,
        N_COMMENT         AS comment
    FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"
),

current_tgt AS (
    SELECT *
    FROM {{ this }}
),

merge_source AS (
    SELECT
        s.business_key,
        s.nation_name,
        s.region_key,
        s.comment,

        -- keep the existing surrogate key for a row that's already there;
        -- only mint a new one for a brand-new business key
        COALESCE(t.SURROGATE_KEY, {{ ref('SRC', 'DIM_NATION_TEST_SEQ') }}.NEXTVAL) AS surrogate_key

    FROM src s
    LEFT JOIN current_tgt t
        ON s.business_key = t.business_key
)

SELECT
    business_key           AS "BUSINESS_KEY"   @isBusinessKey,
    nation_name             AS "NATION_NAME",
    region_key              AS "REGION_KEY",
    comment                 AS "COMMENT",
    surrogate_key::NUMBER   AS "SURROGATE_KEY"
FROM merge_source
