@id("0e454b93-1163-4cfd-8c66-bf35c8e339d1")
@nodeType("ece2dca8-2416-4db4-b6ae-e12dfb4de042")
@lastModifiedCompToggle(true)


SELECT
     "N_NATIONKEY" @isBusinessKey,
     "N_NAME",
     "N_REGIONKEY",
     "N_COMMENT",
     "N_LOAD_TIMESTAMP",
     "N_LOAD_TIMESTAMP"::TIMESTAMP_NTZ AS "N_LOAD_TIMESTAMP1" @isSystemCreateDate,
     CAST("N_LOAD_TIMESTAMP" AS TIMESTAMP) @isSystemUpdateDate
FROM {{ ref('SRC', 'NATION') }} "NATION"