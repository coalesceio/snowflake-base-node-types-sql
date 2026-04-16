@id("b2833e6a-32bf-43b8-9a98-0cbf16e17d45")
@nodeType("e35d8015-545b-4150-942f-5168dcd2bea8")

@lastModifiedComparison
@treatNullAsCurrentTimestamp

SELECT
     0 AS "DIM_KEY" @isSurrogateKey @nullable("false") @description("System generated value"),
     NATION."N_NATIONKEY" AS "N_NATIONKEY" @isBusinessKey,
     NATION."N_NAME" AS "N_NAME" @description("name of country"),
     NATION."N_REGIONKEY" AS "N_REGIONKEY",
     NATION."N_COMMENT" AS "N_COMMENT" @defaultValue("NA"),
     NATION."N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP" @isLastModifiedColumn,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @isSystemUpdateDate
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION"