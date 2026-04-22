@id("7165f20a-e36a-47a0-ae7c-977b1a3c590d")
@nodeType("6fda2820-4404-4b60-bad3-cf0edd7dab92")

WITH pivoted_nation AS (
    SELECT *
    FROM (
        SELECT
            "N_NAME",
            "N_REGIONKEY"
        FROM {{ ref('SRC', 'NATION') }} "NATION"
    )
    PIVOT (
        COUNT("N_NAME")
        FOR "N_REGIONKEY" IN (0, 1, 2, 3, 4)
    ) AS P
)

SELECT * FROM pivoted_nation;