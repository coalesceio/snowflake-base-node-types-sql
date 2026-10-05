@id("d019ca92-da84-4a9e-abe7-4b1825533037")
@nodeType("SQLFact")
@materializationType("view")
WITH "NATION_LATEST" AS (
    SELECT *
    FROM {{ ref('SRC', 'NATION_TEST') }}
    QUALIFY ROW_NUMBER() OVER (PARTITION BY "N_NATIONKEY" ORDER BY "N_LOAD_TIMESTAMP" DESC NULLS LAST) = 1
)
SELECT
    "NATION_LATEST"."N_NATIONKEY"                 AS "N_NATIONKEY"        @id("0d0801"),
    "NATION_LATEST"."N_NAME"                      AS "N_NAME"             @id("0d0802"),
    "NATION_LATEST"."N_REGIONKEY"                 AS "N_REGIONKEY"        @id("0d0803"),
    "NATION_LATEST"."N_COMMENT"                   AS "N_COMMENT"          @id("0d0804"),
    "NATION_LATEST"."N_LOAD_TIMESTAMP"            AS "N_LOAD_TIMESTAMP"   @id("0d0805"),
    "NATION_LATEST"."N_DATE"                      AS "N_DATE"             @id("0d0806"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("0d0807") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("0d0808") @isSystemUpdateDate
FROM "NATION_LATEST"
