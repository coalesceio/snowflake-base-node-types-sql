# Coalesce SQL Base Node Types Package

## SQL Nodes Types
The  SQL Node is a powerful transformation tool within Coalesce that allows developers to write custom, hand-coded SQL instead of using the standard graphical column-mapping interface. It is ideal for complex transformations, advanced window functions, or multi-step logic that is difficult to represent via the standard UI. While it provides maximum flexibility, it shifts the responsibility of column definition and logic maintenance to the SQL author.

This package includes two node types:

- **SQL Insert** – used for inserting data into the target usng `INSERT` strategy
- **SQL Merge** – used for loading data into the target using a `MERGE` strategy

The key differences between these nodes are outlined below.

### Node Configuration

* Node properties

#### Node Properties

| **Setting** | **Description** |
|----------|-------------|
| **Storage Location** | Storage Location where the work will be created |

### Node-Level Annotations

| Annotation | SQL Insert | SQL Merge | Description |
|-----------|-----------|----------|------------|
| `@materializationType("table")` | ✓ | ✓ | Creates object as a table |
| `@materializationType("view")` | ✓ | ✓ | Creates object as a view |
| `@truncateBefore` | ✓ | ✓ | Truncates target before load |
| `@selectDistinct` | ✓ | ✓ | Applies `DISTINCT` to SELECT |
| `@preSQL("<sql1>", "<sql2>")` | ✓ | ✓ | Executes SQL before main query |
| `@postSQL("<sql1>", "<sql2>")` | ✓ | ✓ | Executes SQL after main query |
| `@groupByAll` | ✓ | ✓ | Applies `GROUP BY ALL` |
| `@preTests("<test1>", "<continueOnFailure:test2>")` | ✓ | ✓ | Allows you to define validation checks that run before node execution<br/>**continueOnFailure** - Continues execution flow when a test fails<br/>*Default Behavior*<br/>If continueOnFailure not mentioned, assumes **false**, i.e if any test fails, execution stops immediately |
| `@postTests("<continueOnFailure:test1>", "<test2>")` | ✓ | ✓ | Allows you to define validation checks that run after node execution<br/>**continueOnFailure** - Continues execution flow when a test fails<br/>*Default Behavior*<br/>If continueOnFailure not mentioned, assumes **false**, i.e if any test fails, execution stops immediately |
| `@zeroKey("string:<string>", "boolean:<bool>", "datetime:<timestamp>")` |  | ✓ | Specifies default zero-key (ghost record) values by data type, applied when no column-level override is provided<br/>**Example:** <br/>@zeroKey("string:DEFAULT", "boolean:True", "datetime:1900-01-01 00:00:00.000") |
| `@treatNullAsCurrentTimestamp` |  | ✓ | Treats NULL as current timestamp for timestamp datatype, last modified comparison column if **@isLastModifiedColumn** is specified |
| `@type2Dimension` |  | ✓ | Enables SCD Type 2 behavior if **@isLastModifiedColumn** is specified |

---

### Column-Level Annotations

| Annotation | SQL Insert | SQL Merge | Description |
|-----------|-----------|----------|------------|
| `@nullable("false")`<br/>`@nullable(false)` | ✓ | ✓ | Marks column as NOT NULL |
| `@description("<text>")` | ✓ | ✓ | Adds column description |
| `@defaultValue("<text>")`</br>`@defaultValue(<number>)`</br>`@defaultValue(<bool>)` | ✓ | ✓ | Adds default value |
| `@tests("null", "unique")` | ✓ | ✓ | Column tests are more restrictive and apply directly to individual columns.<br/>*Supported Tests*<br/> - **null** → Checks for NULL values<br/> - **unique** → Checks to ensure all values are unique<br/>*Valid Examples*<br/>@tests("null", "unique")<br/>@tests("null")<br/>@tests("unique") |
| `@hashValue("<hash_col_name>")` | ✓ | ✓ | Generates a hash key by combining and hashing the values of columns associated with a given hash group, ensuring consistent change detection and key generation.<br/><br/>**Default:** Uses `SHA1` hashing.<br/>**Supported Algorithms:** `SHA1` (default), `MD5`, `SHA256`.<br/><br/>**Example:**<br/><col_name> AS <col_name> @hashValue("GH_COL"),<br/>{{ get_hash('GH_COL') }}::STRING AS "GH_COL"<br/><br/>**Examples with different algorithms:**<br/>-- SHA1 (default)<br/>{{ get_hash('GH_COL') }}::STRING AS "GH_COL"<br/><br/>-- MD5<br/>{{ get_hash('GH_COL', 'MD5') }}::STRING AS "GH_COL"<br/><br/>-- SHA256<br/>{{ get_hash('GH_COL', 'SHA256') }}::STRING AS "GH_COL" |
| `@zeroKey("<text>")`</br>`@zeroKey(<number>)`</br>`@zeroKey(<bool>)`<br/>`@zeroKey(<timestamp>)` |  | ✓ | Adds zero key value(ghost record) to the column.<br/>**Example:** <br/> 0 AS "<NODE_NAME>_SKEY" @isSurrogateKey @zeroKey(0) |
| `@isSurrogateKey` |  | ✓ | System-generated surrogate key |
| `@isBusinessKey` |  | ✓ | Marks column as business key |
| `@isLastModifiedColumn` |  | ✓ | Identifies the last modified column and enables a last-modified-based approach instead of column-level change tracking |
| `@isChangeTracking` |  | ✓ | Identifies change tracking column |

---

#### Notes

- `@materializationType` defaults to **table** if not specified.
- `@nullable` defaults to **true**. Use `@nullable("false")` to enforce NOT NULL.
- `@selectDistinct` must be explicitly defined via annotation (cannot be inferred from SQL).
- Only **one** `@isLastModifiedColumn` should be defined. Multiple columns may lead to inconsistent results.
- `@isBusinessKey` is required for MERGE operations.
- Zero Key Stage only triggers when **@isSurrogateKey column** and **node level** have `@zeroKey` annotation with datatype relevant values.
- **Column-level** `@zeroKey` takes precedence over **node-level** configuration. If `@zeroKey` is not defined at the column level, the node-level `@zeroKey` configuration is applied based on the column data type else `NULL` is applied by default.
- Once the surrogate-zero key is defined, it is **not advisable** to change it in future deployments or redeployments. Modifying the surrogate-zero key can lead to unintended behavior, such as new records being inserted instead of updating existing ones, causing data inconsistencies.
- The hash transformation can be defined either using the reusable macro or by writing the full hash expression explicitly. Both approaches are supported and will produce the same result. Choose the macro approach for better reusability and cleaner code, or use the explicit expression when custom logic is required.

    #### Examples:
    
    Using macro:
    ```sql
    <col_name> AS <col_name> @hashValue("GH_COL"),
    {{ get_hash('GH_COL') }}::STRING AS "GH_COL"
    ```
    Using explicit expression:
    ```sql
    CAST(
      SHA1(
        NVL(CAST(<col_name> AS VARCHAR), 'null')
      ) AS STRING
    )::STRING AS "GH_Key"
    ```
---

## Guidelines for Creating Nodes from SQL Merge Node Type

### Standard System Columns

| Column Name | Definition | Annotation |
|------------|-----------|-----------|
| "<NODE_NAME>_SKEY" | "<NODE_NAME>_SKEY"::NUMBER AS "<NODE_NAME>_SKEY" | @isSurrogateKey |
| SYSTEM_VERSION | "SYSTEM_VERSION"::NUMBER AS "SYSTEM_VERSION" | @isSystemVersion |
| SYSTEM_CURRENT_FLAG | "SYSTEM_CURRENT_FLAG"::VARCHAR AS "SYSTEM_CURRENT_FLAG" | @isSystemCurrentFlag |
| SYSTEM_CREATE_DATE | CAST(CURRENT_TIMESTAMP AS TIMESTAMP) | @isSystemCreateDate |
| SYSTEM_END_DATE | CAST('2999-12-31 00:00:00' AS TIMESTAMP) | @isSystemEndDate |
| SYSTEM_UPDATE_DATE | CAST(CURRENT_TIMESTAMP AS TIMESTAMP) | @isSystemUpdateDate |

---

### Node/Load Strategy-Specific System Columns/Annotations(Recommended)

<img width="1000" height="600" alt="SQL_Merge" src="https://github.com/user-attachments/assets/8a8f233e-95c5-4690-84f1-eee09b903919" />

---

### Notes

- Use annotations to control behavior instead of external configuration.
- Ensure consistent naming for all system columns.
- These columns support SCD handling and audit tracking in MERGE-based nodes.
- If **MERGE** is selected and a **business key** is defined, **Change Tracking (SCD1)** is applied by default
- When both Last Modified and Change Tracking are defined, the execution prioritizes Last Modified over Change Tracking.
- System column names can be customized as needed. However, the **annotations must remain unchanged**, as they control how the template interprets and processes the SQL
- In cases where joins are used within MERGE logic (such as Last Modified logic in SCD1/SCD2 or Change Tracking in SCD2), explicit table aliases must be defined before running the node.<br/>While the Create step may succeed, the job execution can fail if aliases are not properly specified in the MERGE conditions.<br/><br/>Use fully qualified column references in the MERGE source like below, to avoid ambiguity in joins and conditions.<br/>
  ```sql
  NATION_TEST."N_NATIONKEY" AS "N_NATIONKEY"
  ```

---

### Known Limitations

Users should be aware of the following technical constraints when using SQL:

* **Parsable SQL Only**:
 The node only supports SQL that can be fully parsed by the platform’s engine. Non-standard SQL or vendor-specific "semantic views" that bypass standard parsing will not work.

* **SELECT Statements Only**:  
This node only supports data retrieval and transformation logic. DML or DDL commands such as `CREATE`, `MERGE`, `DELETE`, `UPDATE`, or `TRUNCATE` are not supported and will cause execution failures.

* **Support for DISTINCT, UNION, and UNION ALL**:  
Keywords like `DISTINCT`, `UNION`, and `UNION ALL` are fully supported when used within **Common Table Expressions (CTEs)**. However, if these keywords are used instandard `SELECT` statements, the platform will not return an error, but the keywords will not be "picked up" or reflected in the final output. To ensure these operations are functional, always implement them inside a CTE.

###  SQL Stage Deployment

####  SQL Stage Initial Deployment

When deployed for the first time into an environment the  SQL Stage Node of materialization type table will execute the below stage:

| **Stage** | **Description** |
|-----------|----------------|
| **Create  SQL Stage Table** | This will execute a CREATE OR REPLACE statement and create a table in the target environment |

####  SQL Stage Redeployment

After the SQL Stage Node with materialization type table has been deployed for the first time into a target environment, subsequent deployments may result in either altering the  SQL Table or recreating the  SQL table.

#### Altering the SQL Stage Tables

A few types of column or table changes will result in an ALTER statement to modify the  SQL Table in the target environment, whether these changes are made individually or all together:

* Changing table names
* Dropping existing columns
* Altering column data types
* Adding new columns

The following stages are executed:

| **Stage** | **Description** |
|-----------|----------------|
| **Clone Table** | Creates an internal table |
| **Rename Table\| Alter Column \| Delete Column \| Add Column \| Edit table description** | Alter table statement is executed to perform the alter operation |
| **Swap Cloned Table** | Upon successful completion of all updates, the clone replaces the main table ensuring that no data is lost |
| **Delete Table** | Drops the internal table |

###  SQL Undeployment

If a  SQL Stage Node of materialization type table is deleted from a Workspace, that Workspace is committed to Git and that commit deployed to a higher level environment then the WorkTable in the target environment will be dropped.

This is executed in two stages:

| **Stage** | **Description** |
|-----------|----------------|
| **Delete Table** | Coalesce Internal table is dropped |

-----------

### Usage Examples 

The following patterns represent common ways to use the  SQL Stage Node.<br/>

- **Sample Insert Node with Annotations** <br/>

```sql

@truncateBefore
@selectDistinct
@preSQL("select count(*) from {{ this }}", "select count(*) from {{ this }}")
@postSQL("select count(*) from {{ this }}", "select count(*) from {{ this }}")
@preTests("select count(*) from {{ this }}", "continueOnFailure:select count(*) from {{ this }}")
@postTests("continueOnFailure:select count(*) from {{ this }}", "select count(*) from {{ this }}")

SELECT
     "N_NATIONKEY" AS "N_NATIONKEY" @nullable("false") @description("nation key") @defaultValue("100") @tests("null", "unique") @hashValue("GH_COL"),
     "N_NAME" AS "N_NAME",
     "N_REGIONKEY" AS "N_REGIONKEY",
     "N_COMMENT" AS "N_COMMENT",
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP",
     {{ get_hash('GH_COL') }}::STRING AS "GH_COL"
FROM {{ ref('SRC', 'NATION') }} "NATION"

```
- **Sample Merge Node - Change Tracking - SCD1 with Annotations** <br/>
```sql

@truncateBefore
@selectDistinct
@preSQL("select count(*) from {{ this }}", "select count(*) from {{ this }}")
@postSQL("select count(*) from {{ this }}", "select count(*) from {{ this }}")
@preTests("select count(*) from {{ this }}", "continueOnFailure:select count(*) from {{ this }}")
@postTests("continueOnFailure:select count(*) from {{ this }}", "select count(*) from {{ this }}")

SELECT
     "N_NATIONKEY" AS "N_NATIONKEY" @hashValue("GH_COL") 🔴@isBusinessKey,
     "N_NAME" AS "N_NAME",
     "N_REGIONKEY" AS "N_REGIONKEY" @nullable("false") @description("region key") @defaultValue("100") @tests("null", "unique"),
     "N_COMMENT" AS "N_COMMENT",
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP",
     {{ get_hash('GH_COL') }}::STRING AS "GH_COL",
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @isSystemUpdateDate
FROM {{ ref('SRC', 'NATION') }} "NATION"

```
- **Sample Merge Node - Change Tracking - SCD2 with Annotations** <br/>
```sql

@truncateBefore
@selectDistinct
@preSQL("select count(*) from {{ this }}", "select count(*) from {{ this }}")
@postSQL("select count(*) from {{ this }}", "select count(*) from {{ this }}")
@preTests("select count(*) from {{ this }}", "continueOnFailure:select count(*) from {{ this }}")
@postTests("continueOnFailure:select count(*) from {{ this }}", "select count(*) from {{ this }}")
@zeroKey("string:DEFAULT", "boolean:True", "datetime:1900-01-01 00:00:00")

SELECT
    0 AS "MRG_ALL_ANNOT_KEY" @isSurrogateKey @zeroKey(0),
     NATION."N_NATIONKEY" AS "N_NATIONKEY" @hashValue("GH_COL") 🔴@isBusinessKey,
     NATION."N_NAME" AS "N_NAME" 🔴@isChangeTracking,
     NATION."N_REGIONKEY" AS "N_REGIONKEY" @nullable("false") @description("region key") @defaultValue("100") @tests("null", "unique"),
     NATION."N_COMMENT" AS "N_COMMENT" @zeroKey("NA"),
     NATION."N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP",
     {{ get_hash('GH_COL') }}::STRING AS "GH_COL",
    "SYSTEM_CURRENT_FLAG"::VARCHAR AS "SYSTEM_CURRENT_FLAG" @isSystemCurrentFlag,
    "SYSTEM_VERSION"::NUMBER AS "SYSTEM_VERSION" @isSystemVersion,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @isSystemUpdateDate,
    CAST('2999-12-31 00:00:00' AS TIMESTAMP) AS "SYSTEM_END_DATE" @isSystemEndDate
FROM {{ ref('SRC', 'NATION') }} "NATION"

```
- **Sample Merge Node - Last Modified - SCD1 with Annotations** <br/>
```sql

@truncateBefore
@selectDistinct
@preSQL("select count(*) from {{ this }}", "select count(*) from {{ this }}")
@postSQL("select count(*) from {{ this }}", "select count(*) from {{ this }}")
@preTests("continueOnFailure:select count(*) from {{ this }}", "continueOnFailure:select count(*) from {{ this }}")
@postTests("continueOnFailure:select count(*) from {{ this }}", "continueOnFailure:select count(*) from {{ this }}")

🔴@treatNullAsCurrentTimestamp

SELECT
     NATION."N_NATIONKEY" AS "N_NATIONKEY" @nullable("false") @description("nation key") @defaultValue("100") @tests("null", "unique") @hashValue("GH_COL") 🔴@isBusinessKey,
     NATION."N_NAME" AS "N_NAME",
     NATION."N_REGIONKEY" AS "N_REGIONKEY",
     NATION."N_COMMENT" AS "N_COMMENT",
     NATION."N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP" 🔴@isLastModifiedColumn,
     {{ get_hash('GH_COL') }}::STRING AS "GH_COL",
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @isSystemUpdateDate
FROM {{ ref('SRC', 'NATION') }} "NATION"

```
- **Sample Merge Node - Last Modified - SCD2 with Annotations** <br/>
```sql

@truncateBefore
@selectDistinct
@preSQL("select count(*) from {{ this }}", "select count(*) from {{ this }}")
@postSQL("select count(*) from {{ this }}", "select count(*) from {{ this }}")
@preTests("continueOnFailure:select count(*) from {{ this }}", "continueOnFailure:select count(*) from {{ this }}")
@postTests("continueOnFailure:select count(*) from {{ this }}", "continueOnFailure:select count(*) from {{ this }}")
@zeroKey("string:DEFAULT", "boolean:True", "datetime:1900-01-01 00:00:00")

🔴@treatNullAsCurrentTimestamp
🔴@type2Dimension

SELECT
    0 AS "MRG_ALL_ANNOT_KEY" @isSurrogateKey @zeroKey(0),
     NATION."N_NATIONKEY" AS "N_NATIONKEY" @nullable("false") @description("nation key") @defaultValue("100") @tests("null", "unique") @hashValue("GH_COL") 🔴@isBusinessKey,
     NATION."N_NAME" AS "N_NAME",
     NATION."N_REGIONKEY" AS "N_REGIONKEY",
     NATION."N_COMMENT" AS "N_COMMENT",
     NATION."N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP" 🔴@isLastModifiedColumn,
     {{ get_hash('GH_COL') }}::STRING AS "GH_COL",
    "SYSTEM_CURRENT_FLAG"::VARCHAR AS "SYSTEM_CURRENT_FLAG" @isSystemCurrentFlag,
    "SYSTEM_VERSION"::NUMBER AS "SYSTEM_VERSION" @isSystemVersion,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @isSystemCreateDate,
    CAST('2999-12-31 00:00:00' AS TIMESTAMP) AS "SYSTEM_END_DATE" @isSystemEndDate
FROM {{ ref('SRC', 'NATION') }} "NATION"

------

- **Basic Transformation & Cleaning** <br/>
Standard pattern for renaming columns and handling nulls.

```sql
SELECT
"O_ORDERKEY",
"O_CUSTKEY",
UPPER("O_ORDERSTATUS") AS "O_ORDERSTATUS",
COALESCE("O_TOTALPRICE", 0) AS "O_TOTALPRICE",
"O_ORDERDATE"
FROM {{ ref('SOURCE_DATA', 'ORDERS') }}
WHERE "O_ORDERSTATUS" != 'F'
```

- **Using CTEs (Common Table Expressions)** <br/>
For more complex, multi-step logic.

```sql
WITH priority_counts AS (
    SELECT 
        "O_ORDERPRIORITY",
        COUNT(*) as order_count
    FROM {{ ref('SOURCE_DATA', 'ORDERS') }}
    GROUP BY 1
)
SELECT * FROM priority_counts
```

- **Multi-CTE Transformation With Window Functions** <br/>
Complex transformations that would otherwise require multiple nodes can be written as a single SQL statement. Coalesce tracks lineage through each CTE and down to the source tables
```sql
WITH ordered_orders AS (
-- CTE 1: Rank every order for each customer by date
SELECT
O_CUSTKEY,
O_ORDERKEY,
O_ORDERDATE,
O_TOTALPRICE,
O_ORDERSTATUS,
ROW_NUMBER() OVER (
PARTITION BY O_CUSTKEY
ORDER BY O_ORDERDATE ASC, O_ORDERKEY ASC
) AS order_rank
FROM {{ ref('SOURCE_DATA', 'ORDERS') }}
),
first_orders AS (
-- CTE 2: Filter to keep only the first order (rank 1) for each customer
SELECT
O_CUSTKEY,
O_ORDERKEY AS first_order_id,
O_ORDERDATE AS first_purchase_date,
O_TOTALPRICE AS first_order_value,
O_ORDERSTATUS
FROM ordered_orders
WHERE order_rank = 1
)
-- Final Select: Add metadata and return the results
SELECT
f.O_CUSTKEY,
f.first_order_id,
f.first_purchase_date,
f.first_order_value,
f.O_ORDERSTATUS,
CURRENT_TIMESTAMP() AS refreshed_at,
'Initial Customer Purchase' AS record_type
FROM first_orders f;
```

* Using Recursive CTE
```sql
WITH RECURSIVE date_series AS (
    SELECT 
        MIN(O_ORDERDATE) AS report_date
    FROM {{ ref('SRC','ORDERS') }}

    UNION ALL

    SELECT 
        DATEADD(day, 1, report_date)
    FROM date_series
    WHERE report_date < (SELECT DATEADD(day, 10, MIN(O_ORDERDATE)) FROM {{ ref('SRC','ORDERS') }} )
)

SELECT 
    ds.report_date,
    COUNT(o.O_ORDERKEY) AS total_orders,
    SUM(o.O_TOTALPRICE) AS daily_revenue
FROM date_series ds
LEFT JOIN {{ ref('SRC','ORDERS') }} o 
    ON ds.report_date = o.O_ORDERDATE
GROUP BY 1
ORDER BY 1
```
* Using CTE for multisource combine
```sql
WITH ALL_NATIONS AS (

    SELECT N_NATIONKEY, N_NAME, N_REGIONKEY, N_COMMENT
    FROM {{ ref('SOURCE_DATA', 'NATION_COPY1') }}

    UNION

    SELECT N_NATIONKEY, N_NAME, N_REGIONKEY, N_COMMENT
    FROM {{ ref('SOURCE_DATA', 'NATION_COPY2') }}

)

SELECT * FROM ALL_NATIONS
```

```sql
WITH ALL_NATIONS AS (

    SELECT N_NATIONKEY, N_NAME, N_REGIONKEY, N_COMMENT, N_LOAD_TIMESTAMP
    FROM {{ ref('SRC', 'NATION_COPY1') }}

    UNION ALL

    SELECT N_NATIONKEY, N_NAME, N_REGIONKEY, N_COMMENT, N_LOAD_TIMESTAMP
    FROM {{ ref('SRC', 'NATION_COPY2') }}

)

SELECT * FROM ALL_NATIONS "NATIONS"
```

### Supported SQL functionality

- **Multi-Source Joins & Enrichment:** The ability to reference and join multiple upstream nodes (e.g., Joining ORDERS and CUSTOMER) within a single stage to flatten data or create enriched wide tables while maintaining full lineage for every source.

- **Conditional Logic via CASE Statements:** Support for complex business rules and data categorization using standard CASE WHEN syntax to create derived columns based on multiple logical conditions.

 - **Flexible Projection (SELECT * with Expressions):** Enhanced projection capabilities that allow for selecting all columns from a source (`SELECT *`) while simultaneously appending new calculated expressions, timestamps, or metadata in the same statement.

- **Nested Subqueries:** Support for correlated and non-correlated subqueries within SELECT, FROM, or WHERE clauses, enabling granular filtering and complex lookups that don't require separate nodes.

- **Common Table Expressions (CTEs)**: Support for standard `WITH` clauses to break down complex, multi-step transformation logic into readable, modular blocks. Coalesce tracks lineage through each CTE and back to the source tables.

- **Recursive CTEs**: Full support for `WITH` RECURSIVE logic, enabling the transformation of hierarchical data and the programmatic generation of data sequences within a single node.

----

## Code

### SQL Insert Deploy Code

| **Component** | **Link** |
|--------------|-----------|
| **Node definition** | [definition.yml](nodeTypes/SQLInsert-6fda2820-4404-4b60-bad3-cf0edd7dab92/definition.yml) |
| **Create Template** | [create.sql.j2](nodeTypes/SQLInsert-6fda2820-4404-4b60-bad3-cf0edd7dab92/create.sql.j2) |
| **Run Template** | [run.sql.j2](nodeTypes/SQLInsert-6fda2820-4404-4b60-bad3-cf0edd7dab92/run.sql.j2) |

### SQL Merge Deploy Code

| **Component** | **Link** |
|--------------|-----------|
| **Node definition** | [definition.yml](nodeTypes/SQLMerge-ece2dca8-2416-4db4-b6ae-e12dfb4de042/definition.yml) |
| **Create Template** | [create.sql.j2](nodeTypes/SQLMerge-ece2dca8-2416-4db4-b6ae-e12dfb4de042/create.sql.j2) |
| **Run Template** | [run.sql.j2](nodeTypes/SQLMerge-ece2dca8-2416-4db4-b6ae-e12dfb4de042/run.sql.j2) |

[Macros](macros/macro-1.yml)
