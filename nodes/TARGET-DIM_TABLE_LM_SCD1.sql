@id("b2833e6a-32bf-43b8-9a98-0cbf16e17d45")
@nodeType("e35d8015-545b-4150-942f-5168dcd2bea8")

@lastModifiedComparison
@treatNullAsCurrentTimestamp

SELECT
     0 AS "{{ node.name }}_KEY" @isSurrogateKey @nullable("false") @description("System generated value"),
     NATION."N_NATIONKEY" AS "N_NATIONKEY" @isBusinessKey,
     NATION."N_NAME" AS "N_NAME",
     NATION."N_REGIONKEY" AS "N_REGIONKEY" @isLastModifiedColumn,
     NATION."N_COMMENT" AS "N_COMMENT",
     NATION."N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP" @isLastModifiedColumn,
     0 AS "SYSTEM_VERSION" @isSystemVersion @defaultValue("1"),
     '' AS "SYSTEM_CURRENT_FLAG" @isSystemCurrentFlag @defaultValue("Y"),
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @isSystemUpdateDate,
     CAST('2999-12-31 00:00:00' AS TIMESTAMP) AS "SYSTEM_END_DATE" @isSystemEndDate
FROM {{ ref('SRC', 'NATION') }} "NATION"