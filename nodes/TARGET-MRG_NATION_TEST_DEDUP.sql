@id("d8be52ee-8d22-40da-b633-d777902b5f0e")
@nodeType("ece2dca8-2416-4db4-b6ae-e12dfb4de042")

WITH src_dedup AS (
    SELECT
        SRC."N_NATIONKEY",
        SRC."N_NAME",
        SRC."N_REGIONKEY",
        SRC."N_COMMENT",
        SRC."N_LOAD_TIMESTAMP"
    FROM {{ ref('SRC', 'NATION_TEST_DEDUP') }} SRC
    QUALIFY ROW_NUMBER() OVER (
        PARTITION BY SRC."N_NATIONKEY"
        ORDER BY SRC."N_LOAD_TIMESTAMP" DESC
    ) = 1
)

SELECT  src_dedup."N_NATIONKEY" AS "N_NATIONKEY" @isBusinessKey,
        src_dedup."N_NAME" AS "N_NAME",
        src_dedup."N_REGIONKEY" AS "N_REGIONKEY",
        src_dedup."N_COMMENT" AS "N_COMMENT",
        src_dedup."N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP",
        CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @isSystemCreateDate,
        CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @isSystemUpdateDate
FROM src_dedup