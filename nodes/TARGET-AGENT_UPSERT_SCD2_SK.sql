@id("7905f0c1-54c0-4a4d-8f11-ba2c1d9a8cd1")
@nodeType("718")
-- WARNING: skips column ID checks. This stays as-is for the complete lifecycle of this node once created — don't remove unless every column has a real system-generated ID.
@disableIDs
@mergeStrategy("upsert")
    WITH src AS (
    SELECT
        N_NATIONKEY       AS business_key,
        N_NAME            AS nation_name,
        N_REGIONKEY       AS region_key,
        N_COMMENT         AS comment
    FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"
),

/* Only the current (non-expired) version of each business key */
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

        -- VERSION is the current row's version if one exists, else 0 (no prior row)
        NVL(t.VERSION, 0) AS old_version,

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

/* Two rows can be produced per business key in the same run (one EXPIRE, one
   INSERT) — VERSION makes each one match a distinct/nonexistent target row,
   so the outer MERGE (which matches on every @isBusinessKey column, i.e.
   BUSINESS_KEY AND VERSION here) never has two source rows land on the same
   target row. Without this, both rows would match the same existing
   BUSINESS_KEY and Snowflake would reject the MERGE as ambiguous
   ("duplicate row detected during DML action"). */
merge_source AS (

    /* Expire the existing current row — same BUSINESS_KEY + VERSION as what's
       already there, so this matches exactly that one row and nothing else */
    SELECT
        business_key,
        old_version     AS version,
        old_nation_name AS nation_name,
        old_region_key  AS region_key,
        old_comment     AS comment,
        'EXPIRE' AS merge_action
    FROM changes
    WHERE action = 'CHANGE'

    UNION ALL

    /* Insert new version for changed/new records — use NEW values.
       VERSION = old_version + 1 is a value no existing row for this business
       key has, so this always lands as a brand-new physical row (NOT
       MATCHED -> INSERT). SURROGATE_KEY is not computed here at all:
       @isSurrogateKey below makes it an IDENTITY column, so Snowflake
       assigns it on that insert — no sequence needed. */
    SELECT
        business_key,
        old_version + 1 AS version,
        new_nation_name AS nation_name,
        new_region_key  AS region_key,
        new_comment     AS comment,
        'INSERT' AS merge_action
    FROM changes
    WHERE action IN ('INSERT', 'CHANGE')
)

SELECT
    business_key   AS "BUSINESS_KEY" @isBusinessKey,
    version::NUMBER AS "VERSION"     @isBusinessKey,
    nation_name     AS "NATION_NAME",
    region_key      AS "REGION_KEY",
    comment         AS "COMMENT",
    0               AS "SURROGATE_KEY" @isSurrogateKey,
    merge_action    AS "MERGE_ACTION"
FROM merge_source
