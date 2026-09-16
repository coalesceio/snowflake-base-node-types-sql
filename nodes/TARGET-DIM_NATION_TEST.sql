@id("eadbba57-dee5-4e99-8f50-683c11c62279")
@nodeType("4a720337-2713-45a5-b3f2-2d47d7abe3e5")
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
        WHERE IS_CURRENT = TRUE
    ),

    changes AS (
        SELECT
            s.business_key,
            s.nation_name,
            s.region_key,
            s.comment,

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

        /* Expire the existing SCD2 record */
        SELECT
            business_key,
            nation_name,
            region_key,
            comment,
            old_surrogate_key AS surrogate_key,
            'EXPIRE' AS merge_action
        FROM changes
        WHERE action = 'CHANGE'

        UNION ALL

        /* Insert new version for changed records */
          SELECT
          business_key,
          nation_name,
          region_key,
          comment,
          {{ ref('SRC', 'DIM_NATION_TEST_SEQ') }}.NEXTVAL AS surrogate_key,
          'INSERT' AS merge_action
          FROM changes
          WHERE action IN ('INSERT', 'CHANGE')
    )

    SELECT  business_key  @isBusinessKey,
            nation_name,
            region_key,
            comment,
            surrogate_key::NUMBER,
            merge_action
    FROM merge_source