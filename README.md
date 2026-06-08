# Base Node Types - SQL Package

## SQL Node Types

The SQL Node is a powerful transformation tool within Coalesce that allows developers to write custom, hand-coded SQL instead of using the standard graphical column-mapping interface. It is ideal for complex transformations, advanced window functions, or multi-step logic that is difficult to represent with the standard UI. While it provides maximum flexibility, it shifts the responsibility of column definition and logic maintenance to the SQL author.

The Base Node Types - SQL Package includes:

* [Work](#work)
* [Persistent Stage](#persistent-stage)
* [Dimension](#dimension)
* [Fact](#fact)
* [Factless Fact](#factless-fact)
* [View](#view)
* [Code](#code)

The key differences between these nodes are outlined below.

### Node Configuration

* Node properties

#### Node Properties

| **Setting** | **Description** |
|----------|-------------|
| **Storage Location** | Storage Location where the work will be created |

### Node Options

| Options |   Work   | Dimension | Persistent Stage | Fact | Factless Fact | View | Description |
|----------|-------------|-----------|------------------|------|---------------|------|-------------|
| **Create As** | Table/View | Table/View | Table | Table/View | Table | View | |
| **Truncate Before** | ✅ | ✅ | ✅ | ✅ | ✅ |  | **True**: Truncates target before load.<br/>**False**: Table is not truncated before data load. |
| **Distinct** | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | **True**: Group By All is hidden and DISTINCT data is processed.<br/>**False**: Group By All is visible. |
| **Group By All** | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | **True**: DISTINCT is hidden and data is grouped by all columns.<br/>**False**: DISTINCT is visible. |
| **Order By** | ✅ | ✅ | ✅ | ✅ | ✅ |  | **True**: Sort column and sort order drop down are visible and are required to form order by clause<br/>**False**: Sort column and sort order drop down are invisible |
| **Business Key** |  | ✅ | ✅ | ✅ |  |  | Required column for both SCD Type 1 and Type 2.<br/>**Note:** Geometry and Geography data type columns are not supported as business key columns. |
| **Last Modified Based Incremental Load**² |  | ✅ | ✅ | ✅ |  |  | **True**: When enabled we can do timestamp based/Integer based CDC<br/>**False**: Regular CDC based on Change tracking columns is done. |
| **Lookback Days**¹ |  | ✅ | ✅ | ✅ |  |  | Specifies the number of days to look back from the last successful load when extracting incremental data |
| **Last Modified Column**¹ |  | ✅ | ✅ | ✅ |  |  | Column used for incremental loading. Supported data types include NUMERIC and TIMESTAMP-related columns. |
| **Enable SCD Type2**¹ |  | ✅ | ✅ |  |  |  | **True**: SCD Type2 - CDC is based on timestamp/ID column chosen.<br/>**False**: SCD Type1 - CDC is based on timestamp/ID column chosen. |
| **Change Tracking** |  | ✅ | ✅ |  |  |  | *Only when Last Modified Based Incremental Load is OFF*<br/>Required column/s for SCD Type 2 |

### Zero Key Record Options

| Option | Work | Dimension | Persistent Stage | Fact | Factless Fact | View | Description |
|----------|------|-----------|------------------|------|---------------|------|-------------|
| **Insert Zero Key Record** |  | ✅ |  |  |  |  | Enables insertion of a zero key (ghost) record. |
| **Default Surrogate Key Value**³ |  | ✅ |  |  |  |  | Default surrogate key value used for the zero key record. |
| **Default String Value** |  | ✅ |  |  |  |  | Default value used for string columns in the zero key record. |
| **Default Date/Time/Timestamp Value** |  | ✅ |  |  |  |  | Default value used for date, time, and timestamp columns in the zero key record. |
| **Default Boolean Value** |  | ✅ |  |  |  |  | Default value used for boolean columns in the zero key record. |

### Control Options

| Options | Work | Dimension | Persistent Stage | Fact | Factless Fact | View | Description |
|----------|------|-----------|------------------|------|---------------|------|-------------|
| **Enable tests** | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | Determines if tests are enabled |
| **Test**⁴ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | SQL query executed as a validation test. The test fails if the query returns any records. |
| **Run**⁴ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | Determines when the test is executed.<br/>**Before** - Run before the load operation.<br/>**After** - Run after the load operation. |
| **Continue On Failure**⁴ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | Determines whether execution should continue if the test fails.<br/>**True** - Continue execution.<br/>**False** - Stop execution. |
| **Pre-SQL** | ✅ | ✅ | ✅ | ✅ | ✅ |  | SQL to execute before data insert operation |
| **Post-SQL** | ✅ | ✅ | ✅ | ✅ | ✅ |  | SQL to execute after data insert operation |

### Column-Level Annotations

| Annotation | Work | Dimension | Persistent Stage | Fact | Factless Fact | View | Description |
|------------|------|-----------|------------------|------|---------------|------|-------------|
| `@nullable("false")`<br/>`@nullable(false)` | ✅ | ✅ | ✅ | ✅ | ✅ |  | Marks column as NOT NULL |
| `@description("<text>")` | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | Adds column description |
| `@defaultValue("<text>")`<br/>`@defaultValue(<number>)`<br/>`@defaultValue(<bool>)` | ✅ | ✅ | ✅ | ✅ | ✅ |  | Adds default value |
| `@tests("null", "unique")` | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | Column tests are more restrictive and apply directly to individual columns.<br/><br/>**Supported Tests**<br/>- **null** → Checks for NULL values<br/>- **unique** → Checks to ensure all values are unique |
| `@hashValue("<hash_name>")` | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | Generates a hash key by combining and hashing the values of columns associated with a given hash group, ensuring consistent change detection and key generation.<br/>**Default:** Uses `SHA1` hashing. |
| `@zeroKey("<text>")`<br/>`@zeroKey(<number>)`<br/>`@zeroKey(<bool>)`<br/>`@zeroKey(<timestamp>)` |  | ✅ |  |  |  |  | Provides override zero key value(ghost record) to the column |

---

#### Notes

- ¹ Enabled only if Last Modified Based Incremental Load is ON
- ² For timestamp-based incremental loads, a *validation test checks* the selected Last Modified column for NULL values before the merge. If NULL values are detected, the merge is stopped; otherwise, processing continues.
- ³ Changing the surrogate key value after deployment is not recommended.
- ⁴ Enabled only if Enable tests is ON
- Some dependent options may **remain visible** in the SQL Editor regardless of the selected parent configuration. **This does not impact execution**. The generated SQL always follows the **parent setting**, and any non-applicable options are ignored.
- Verify that all **column datatypes** are successfully resolved before creating the object. Columns with an `UNKNOWN` datatype may cause stage generation or runtime failures.
- If a **Dim and PStage node** is renamed, ensure that the surrogate key column is also renamed to follow the `{{NODE_NAME}}_KEY` naming convention. Failure to do so may result in the surrogate key attribute being lost, which can impact the expected behavior of the flow.
- `@nullable` defaults to **true**. Use `@nullable("false")` to enforce NOT NULL.
- **Column-level** `@zeroKey` takes precedence over **node-level** configuration. If `@zeroKey` is not defined at the column level, the node-level `@zeroKey` configuration is applied based on the column data type else `NULL` is applied by default.
- Once the surrogate-zero key value is defined, it is **not advisable** to change it in future deployments or redeployments. Modifying the surrogate-zero key can lead to unintended behavior, such as new records being inserted instead of updating existing ones, causing data inconsistencies.
- In cases where joins are used within run template logic (such as Last Modified logic in SCD1/SCD2 or Change Tracking in SCD2), explicit table aliases must be defined before running the node.<br/>While the Create step may succeed, the job execution can fail if aliases are not properly specified in the MERGE conditions.<br/>Use fully qualified column references in the MERGE source like below, to avoid ambiguity in joins and conditions.<br/>
  ```sql
  NATION_TEST."N_NATIONKEY" AS "N_NATIONKEY"
  ```
- The hash transformation can be defined either using the reusable macro or by writing the full hash expression explicitly. Both approaches are supported and will produce the same result. Choose the macro approach for better reusability and cleaner code, or use the explicit expression when custom logic is required.

    #### Examples:
    
    Using hash macro(default-SHA1)
    ```sql
    <col_name> AS <col_name> @hashValue("GH_COL"),
    {{ get_hash('GH_COL') }}::STRING AS "GH_COL"
    ```
    Using hash macro(MD5)
    ```sql
    <col_name> AS <col_name> @hashValue("GH_COL"),
    {{ get_hash('GH_COL', 'MD5') }}::STRING AS "GH_COL"<SHA256
    ```
    Using hash macro(SHA256)
    ```sql
    <col_name> AS <col_name> @hashValue("GH_COL"),
    {{ get_hash('GH_COL', 'SHA256') }}::STRING AS "GH_COL"
    ```
    Using hash macro(algo=SHA256, delimeter='~' )
    ```sql
    <col_name> AS <col_name> @hashValue("GH_COL"),
    {{ get_hash('GH_COL', 'SHA256', '~') }}::STRING AS "GH_COL"
    ```
    Using multiple keys hash macro
    ```sql
    <col_name1> AS <col_name1> @hashValue("GH_COL"),
    <col_name2> AS <col_name2> @hashValue("GH_COL"),
    {{ get_hash('GH_COL') }}::STRING AS "GH_COL_COMBINED"
    ```
    Using multiple hash macros
    ```sql
    <col_name1> AS <col_name1> @hashValue("GH_COL1", "GH_COL2"),
    <col_name2> AS <col_name2> @hashValue("GH_COL1"),
    <col_name3> AS <col_name3> @hashValue("GH_COL2"),
    {{ get_hash('GH_COL1') }}::STRING AS "GH_COL_COMBINED1",
    {{ get_hash('GH_COL2') }}::STRING AS "GH_COL_COMBINED2"
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

### Supported Load Strategies

| Node Type | Supported Load Strategies |
|-----------|---------------------------|
| **Work** | Insert |
| **Dimension** | Merge - Change Tracking (SCD1)<br/>Merge - Change Tracking (SCD2)<br/>Merge - Last Modified (SCD1)<br/>Merge - Last Modified (SCD2) |
| **Persistent Stage** | Insert<br/>Merge - Change Tracking (SCD1)<br/>Merge - Change Tracking (SCD2)<br/>Merge - Last Modified (SCD1)<br/>Merge - Last Modified (SCD2) |
| **Fact** | Insert<br/>Merge - Change Tracking (SCD1)<br/>Merge - Last Modified (SCD1) |
| **Factless Fact** | Merge - Insert Only |
| **View** | N/A |

> **Note:** Load strategy is determined by the node type and selected configuration options. It is not a user-configurable setting.
----

## Standard System Columns

| Column Name | Definition | Annotation |
|------------|-----------|-----------|
| "<NODE_NAME>_SKEY" | "<NODE_NAME>_SKEY"::NUMBER AS "<NODE_NAME>_SKEY" | @isSurrogateKey |
| SYSTEM_VERSION | "SYSTEM_VERSION"::NUMBER AS "SYSTEM_VERSION" | @isSystemVersion |
| SYSTEM_CURRENT_FLAG | "SYSTEM_CURRENT_FLAG"::VARCHAR AS "SYSTEM_CURRENT_FLAG" | @isSystemCurrentFlag |
| SYSTEM_CREATE_DATE | CAST(CURRENT_TIMESTAMP AS TIMESTAMP) | @isSystemCreateDate |
| SYSTEM_END_DATE | CAST('2999-12-31 00:00:00' AS TIMESTAMP) | @isSystemEndDate |
| SYSTEM_UPDATE_DATE | CAST(CURRENT_TIMESTAMP AS TIMESTAMP) | @isSystemUpdateDate |

---

### Known Limitations

Users should be aware of the following technical constraints when using SQL:

* **Parsable SQL Only**:
 The node only supports SQL that can be fully parsed by the platform’s engine. Non-standard SQL or vendor-specific "semantic views" that bypass standard parsing will not work.

* **SELECT Statements Only**:  
This node only supports data retrieval and transformation logic. DML or DDL commands such as `CREATE`, `MERGE`, `DELETE`, `UPDATE`, or `TRUNCATE` are not supported and will cause execution failures.

* **Support for DISTINCT, UNION, and UNION ALL**:  
Keywords like `DISTINCT`, `UNION`, and `UNION ALL` are fully supported when used within **Common Table Expressions (CTEs)**. However, if these keywords are used instandard `SELECT` statements, the platform will not return an error, but the keywords will not be "picked up" or reflected in the final output. To ensure these operations are functional, always implement them inside a CTE.

###  SQL Node Deployment

####  SQL Node Initial Deployment

When deployed for the first time into an environment the SQL Node of materialization type table/View will execute the below stage:

| **Stage** | **Description** |
|-----------|----------------|
| **Create SQL Node Table** | This will execute a CREATE OR REPLACE statement and create a table in the target environment |

| **Stage** | **Description** |
|-----------|----------------|
| **Create SQL Node View** | This will execute a CREATE OR REPLACE statement and create a view in the target environment |

####  SQL Node Redeployment

After the SQL Node with materialization type table has been deployed for the first time into a target environment, subsequent deployments may result in either altering the  SQL Table or recreating the  SQL table.

#### Altering the SQL Node Tables

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

#### Recreating the SQL Node Views

Any of the following changes to views will result in deleting and recreating the Dimension view.

* View definition
* Adding table description
* Renaming the view

This is executed in two stages:

| **Stage** | **Description** |
|-----------|----------------|
| **Drop View** | Existing view is dropped |
| **Create View** | New view is created |

###  SQL Node Undeployment

If a  SQL Node of materialization type table is deleted from a Workspace, that Workspace is committed to Git and that commit deployed to a higher level environment then the WorkTable in the target environment will be dropped.

| **Stage** | **Description** |
|-----------|----------------|
| **Delete Table** | Coalesce Internal table is dropped |
| **Delete Table** | Existing is dropped |

| **Stage** | **Description** |
|-----------|----------------|
| **Drop View** | Existing view is dropped |

-----------

### Usage Examples 

The following patterns represent common ways to use the SQL Node.<br/>

**Sample node with Annotations**
```sql

SELECT
    0 AS "MRG_ALL_ANNOT_KEY" @zeroKey(0),
     NATION."N_NATIONKEY" AS "N_NATIONKEY" @nullable("false") @hashValue("GH_COL"),
     NATION."N_NAME" AS "N_NAME" @defaultValue("NA"),
     NATION."N_REGIONKEY" AS "N_REGIONKEY" @description("region key"),
     NATION."N_COMMENT" AS "N_COMMENT" @hashValue("GH_COL"),
     NATION."N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP" @tests("null", "unique"),
     {{ get_hash('GH_COL') }}::STRING AS "GH_COL",
    "SYSTEM_CURRENT_FLAG"::VARCHAR AS "SYSTEM_CURRENT_FLAG",
    "SYSTEM_VERSION"::NUMBER AS "SYSTEM_VERSION",
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE",
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE",
    CAST('2999-12-31 00:00:00' AS TIMESTAMP) AS "SYSTEM_END_DATE"
FROM {{ ref('SRC', 'NATION') }} "NATION"
```
**Basic Transformation & Cleaning**
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

**Using Recursive CTE - Date Series**
```sql
WITH RECURSIVE RCTE_FNL AS (
    SELECT TO_DATE('2025-01-01') AS "date_s"
    UNION ALL
    SELECT DATEADD(day, 1, "date_s") AS "date_s"
    FROM RCTE_FNL
    where "date_s" < TO_DATE('2025-01-10')
  )
SELECT "date_s"
FROM RCTE_FNL

```
**Using Recursive CTE - Classic Employee**

```sql
WITH RECURSIVE RCTE_FINAL AS (

    -- Anchor clause: top-level employees (no manager)
    SELECT
        "EMPLOYEES_RECUR"."EMPLOYEE_ID"  AS "EMPLOYEE_ID",
        1                                AS "LEVEL",
        "EMPLOYEES_RECUR"."TITLE"        AS "TITLE",
        "EMPLOYEES_RECUR"."MANAGER_ID"   AS "MANAGER_ID"
    FROM {{ ref('SRC', 'EMPLOYEES_RECUR') }} AS "EMPLOYEES_RECUR"
    WHERE "EMPLOYEES_RECUR"."MANAGER_ID" IS NULL

    UNION ALL

    -- Recursive clause: employees reporting to someone in the CTE
    SELECT
        "EMPLOYEES_RECUR"."EMPLOYEE_ID"  AS "EMPLOYEE_ID",
        "RCTE_FINAL"."LEVEL" + 1         AS "LEVEL",
        "EMPLOYEES_RECUR"."TITLE"        AS "TITLE",
        "EMPLOYEES_RECUR"."MANAGER_ID"   AS "MANAGER_ID"
    FROM {{ ref('SRC', 'EMPLOYEES_RECUR') }} AS "EMPLOYEES_RECUR"
    JOIN RCTE_FINAL
        ON "EMPLOYEES_RECUR"."MANAGER_ID" = "RCTE_FINAL"."EMPLOYEE_ID"

)

SELECT
    "LEVEL"          AS "LEVEL",
    "TITLE"::VARCHAR AS "TITLE"
FROM RCTE_FINAL
```

**Using CTE for multisource combine**
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

### Supported SQL Functionality

- **Multi-Source Joins & Enrichment:** The ability to reference and join multiple upstream nodes (e.g., Joining ORDERS and CUSTOMER) within a single stage to flatten data or create enriched wide tables while maintaining full lineage for every source.

- **Conditional Logic via CASE Statements:** Support for complex business rules and data categorization using standard CASE WHEN syntax to create derived columns based on multiple logical conditions.

 - **Flexible Projection (SELECT * with Expressions):** Enhanced projection capabilities that allow for selecting all columns from a source (`SELECT *`) while simultaneously appending new calculated expressions, timestamps, or metadata in the same statement.

- **Nested Subqueries:** Support for correlated and non-correlated subqueries within SELECT, FROM, or WHERE clauses, enabling granular filtering and complex lookups that don't require separate nodes.

- **Common Table Expressions (CTEs)**: Support for standard `WITH` clauses to break down complex, multi-step transformation logic into readable, modular blocks. Coalesce tracks lineage through each CTE and back to the source tables.

- **Recursive CTEs**: Full support for `WITH` RECURSIVE logic, enabling the transformation of hierarchical data and the programmatic generation of data sequences within a single node.

----

## Code

### Work

| **Component** | **Link** |
|--------------|-----------|
| **Node definition** | [definition.yml]() |
| **Create Template** | [create.sql.j2]() |
| **Run Template** | [run.sql.j2]() |

### Dimension

| **Component** | **Link** |
|--------------|-----------|
| **Node definition** | [definition.yml]() |
| **Create Template** | [create.sql.j2]() |
| **Run Template** | [run.sql.j2]() |

### Persistent Stage

| **Component** | **Link** |
|--------------|-----------|
| **Node definition** | [definition.yml]() |
| **Create Template** | [create.sql.j2]() |
| **Run Template** | [run.sql.j2]() |

### Fact

| **Component** | **Link** |
|--------------|-----------|
| **Node definition** | [definition.yml]() |
| **Create Template** | [create.sql.j2]() |
| **Run Template** | [run.sql.j2]() |


### Factless Fact

| **Component** | **Link** |
|--------------|-----------|
| **Node definition** | [definition.yml]() |
| **Create Template** | [create.sql.j2]() |
| **Run Template** | [run.sql.j2]() |


### View

| **Component** | **Link** |
|--------------|-----------|
| **Node definition** | [definition.yml]() |
| **Create Template** | [create.sql.j2]() |
| **Run Template** | [run.sql.j2]() |

[Macros](https://github.com/coalesceio/snowflake-base-node-types-sql/blob/main/macros/macro-1.yml)
