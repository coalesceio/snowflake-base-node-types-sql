@id("5631b50c-331c-4433-970e-ee49a46264e6")
@nodeType("707")
@writeMode("truncateInsert")
SELECT
    {{ get_hash('HK_NATION', 'MD5') }}::STRING       AS "HK_NATION"       @id("5c21ac") @not_null @uniqueness,
    {{ get_hash('HASHDIFF_NATION', 'MD5') }}::STRING AS "HASHDIFF_NATION" @id("8b9b33") @not_null,
    "NATION"."N_NATIONKEY"                           AS "N_NATIONKEY"     @id("4c24ac") @inHash("HK_NATION", 1) @not_null,
    "NATION"."N_NAME"                                AS "N_NAME"          @id("d158eb") @inHash("HASHDIFF_NATION", 1),
    "NATION"."N_REGIONKEY"                           AS "N_REGIONKEY"     @id("550490") @inHash("HASHDIFF_NATION", 2),
    "NATION"."N_COMMENT"                             AS "N_COMMENT"       @id("f1d01b") @inHash("HASHDIFF_NATION", 3),
    'TPCH.NATION'                                    AS "RECORD_SOURCE"   @id("98f658"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)             AS "LOAD_DTS"        @id("8e504c")
FROM {{ ref('SRC', 'NATION') }} "NATION"
