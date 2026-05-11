@id("265d4b1c-4fe1-4747-9b44-cdb3c20325ca")
@nodeType("ece2dca8-2416-4db4-b6ae-e12dfb4de042")

@type2Dimension

SELECT
     NATION_TEST."N_NATIONKEY" AS "N_NATIONKEY" @isBusinessKey,
     NATION_TEST."N_NAME" AS "N_NAME",
     NATION_TEST."N_REGIONKEY" AS "N_REGIONKEY",
     NATION_TEST."N_COMMENT" AS "N_COMMENT",
     NATION_TEST."N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP" @isLastModifiedColumn,
                "MRG_NODE_KEY"::NUMBER AS "MRG_NODE_KEY" @isSurrogateKey,
                "SYSTEM_CURRENT_FLAG"::VARCHAR AS "SYSTEM_CURRENT_FLAG" @isSystemCurrentFlag,
                "SYSTEM_VERSION"::NUMBER AS "SYSTEM_VERSION" @isSystemVersion,
                CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @isSystemCreateDate,
                CAST('2999-12-31 00:00:00' AS TIMESTAMP) AS "SYSTEM_END_DATE" @isSystemEndDate
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"