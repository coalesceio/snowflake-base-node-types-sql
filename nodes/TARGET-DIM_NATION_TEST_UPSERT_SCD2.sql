@id("eadbba57-dee5-4e99-8f50-683c11c62279")
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
    WHERE MERGE_ACTION != 'EXPIRE'
),

changes AS (
    SELECT
        s.business_key,

        -- new (incoming) values
        s.nation_name   AS new_nation_name,
        s.region_key    AS new_region_key,
        s.comment       AS new_comment,

        -- old (current target) values
        t.nation_name   AS old_nation_name,
        t.region_key    AS old_region_key,
        t.comment       AS old_comment,

        t.SURROGATE_KEY AS old_surrogate_key,

        CASE
            WHEN t.business_key IS NULL THEN 'INSERT'
            WHEN NVL(t.nation_name, '') <> NVL(s.nation_name, '')
              OR NVL(t.region_key, -1) <> NVL(s.region_key, -1)
              OR NVL(t.comment, '') <> NVL(s.comment, '')
            THEN 'CHANGE'
            ELSE 'NO_CHANGE'
        END AS action

    FROM src s
    LEFT JOIN current_tgt t
        ON s.business_key = t.business_key
),

merge_source AS (

    /* Expire the existing SCD2 record — keep its OLD values */
    SELECT
        business_key,
        old_nation_name AS nation_name,
        old_region_key  AS region_key,
        old_comment     AS comment,
        old_surrogate_key AS surrogate_key,
        'EXPIRE' AS merge_action
    FROM changes
    WHERE action = 'CHANGE'

    UNION ALL

    /* Insert new version for changed/new records — use NEW values */
    SELECT
        business_key,
        new_nation_name AS nation_name,
        new_region_key  AS region_key,
        new_comment     AS comment,
        {{ ref('SRC', 'DIM_NATION_TEST_SEQ') }}.NEXTVAL AS surrogate_key,
        'INSERT' AS merge_action
    FROM changes
    WHERE action IN ('INSERT', 'CHANGE')
)

SELECT
    business_key           AS "BUSINESS_KEY"   @isBusinessKey,
    nation_name             AS "NATION_NAME",
    region_key              AS "REGION_KEY",
    comment                 AS "COMMENT",
    surrogate_key::NUMBER   AS "SURROGATE_KEY" @isBusinessKey,
    merge_action            AS "MERGE_ACTION"
FROM merge_source
