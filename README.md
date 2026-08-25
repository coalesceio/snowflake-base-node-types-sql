# Coalesce Base Node Types Package

The Coalesce Base Node Types Package includes:

* [Work](#work)
* [Persistent Stage](#persistent-stage)
* [Dimension](#dimension)
* [Fact](#fact)
* [Factless Fact](#factless-fact)
* [View](#view)
* [SQL Work](#sql-work)
* [Code](#code)

---

## Work

The Coalesce Work Node lets you develop and deploy a Work table or view in Snowflake.

A Work Node serves as an intermediary object and is commonly employed to store raw data before undergoing the crucial phases of transformation and loading into the main tables of the data warehouse.

This pivotal step ensures that the raw data is processed and structured effectively.

### Work Node Configuration

The Work Node type has two configuration groups:

* [Node Properties](#work-node-properties)
* [Options](#work-options)

![Work Node configuration](https://github.com/coalesceio/Coalesce-Base-Node-Types/assets/7216836/6f863c3b-3abd-4318-bd7e-ed50a829f911)

#### Work Node Properties

| **Property** | **Description** |
|----------|-------------|
| **Storage Location** | Storage Location where the Work table or view will be created |
| **Node Type** | Name of template used to create Node objects |
| **Description** | A description of the Node's purpose |
| **Deploy Enabled** | If TRUE the Node will be deployed or redeployed when changes are detected<br/> If FALSE the Node will not be deployed or will be dropped during redeployment |

#### Work Options

You can create the Node as:

* [Table](#work-options-table)
* [View](#work-options-view)

##### Work Options Table

![Work_options_table1](https://github.com/coalesceio/Coalesce-Base-Node-Types/assets/7216836/f5643f40-fb37-4182-a11b-577bdc3e8f8d)

| **Property** | **Description** |
|---------|-------------|
| **Multi Source** | Toggle: True or False<br/>Implementation of SQL UNIONs<br/>**True**: Combine multiple sources in a single Node<br/>True Options:<br/>- **UNION**: Combines with duplicate elimination<br/>- **UNION ALL**: Combines without duplicate elimination<br/>- **INSERT**: Individual insert for each source<br/>**False**: single-source Node or multiple sources combined using a join |
| **Truncate Before** | Toggle: True or False<br/>This determines whether a table will be truncated before data load.<br/> **True**:Truncate table stage gets executed<br/>**False**: Table is not truncated before data load |
| **Enable tests** | Toggle: True or False<br/>Determines if tests are enabled |
| **Distinct** | Toggle: True or False<br/>**True**: Group by All is invisible. DISTINCT data is chosen for processing<br/>**False**: Group by All is visible |
| **Group by All** | Toggle: True or False<br/>**True**: DISTINCT is invisible. Data is grouped by all columns for processing<br/>**False**: DISTINCT is visible |
| **Order By** | Toggle: True or False<br/>**True**: Sort column and sort order drop down are visible and are required to form order by clause<br/>**False**: Sort column and sort order drop down are invisible |
| **ASOF Join** | Toggle: True or False<br/>**True**: ASOF Join Options will be visible. <br/>**False**: ASOF Join Options will be invisible |
| **Pre-SQL** | SQL to execute before data insert operation |
| **Post-SQL** | SQL to execute after data insert operation |

##### Work Options View

![Work_options_view1](https://github.com/coalesceio/Coalesce-Base-Node-Types/assets/7216836/7881c46e-0424-46ca-9a89-d111b5dbc379)

| **Setting** | **Description** |
|---------|-------------|
| **Override Create SQL** | Toggle: True or False<br/>**True**: Customized Create SQL specified in the Create SQL space is executed. All other options are invisible except 'Enable Tests'<br/>**False**: Create view SQL based on options chosen are framed and executed |
| **Multi Source** | Toggle: True or False<br/>Implementation of SQL UNIONs<br/>**True**: Combine multiple sources in a single Node<br/>True Options:<br/>- **UNION**: Combines with duplicate elimination<br/>- **UNION ALL**: Combines without duplicate elimination<br/>**False**: single-source Node or multiple sources combined using a join |
| **Enable tests** | Toggle: True or False<br/>Determines if tests are enabled |
| **Distinct** | Toggle: True or False<br/>**True**: Group by All is invisible. DISTINCT data is chosen for processing<br/>**False**: Group by All is visible |
| **Group by All** | Toggle: True or False<br/>**True**: DISTINCT is invisible. Data is grouped by all columns for processing<br/>**False**: DISTINCT is visible |
| **ASOF Join** | Toggle: True or False<br/>**True**: ASOF Join Options will be visible. <br/>**False**: ASOF Join Options will be invisible |

##### ASOF Join Options

| **Setting** | **Description** |
|---------|-------------|
| **Match Condition** | Toggle: True or False <br/> Match Condition Clause from Snowflake ASOF join <br/> **True**: Allows you to specify the match condition.<br/>- **Right Table Storage Location**: Add right table storage location<br/>- **Right Table Name**: Add name of the right table<br/>- **Match Condition**: Add a match condition in the format "Left Table Name"."Column Name" Condition Operator "Right Table Name"."Column Name"<br/> **False** : No Match Condition Added|
| **On** | Toggle: True or False <br/> ON Clause with Match Condition from Snowflake ASOF join. **Using** will be invisible <br/> **True**: Allows you to add the ON Clause.<br/> **ON Condition**: Add a match condition in the format "Left Table Name"."Column Name" = "Right Table Name"."Column Name" <br/> **False**: No ON Clause Added. **Using** will be visible |
| **Using** | Toggle: True or False <br/> Using Clause with Match Condition from Snowflake ASOF join. **On** will be invisible <br/> **True**: Allows you to add the Using Clause.<br/> **Using Column Name** : Add a Column Name for Using clause<br/> **False**: No Using Clause Added. **On** will be visible |

### Work Joins

Join conditions and other clauses can be specified in the join space next to mapping of columns in the Coalesce App.

![work_join](https://github.com/coalesceio/Coalesce-Base-Node-Types/assets/7216836/2dc81bb8-2285-46e1-8b93-ce7082800fc5)

> 📘 **Specify Group by and Order by Clauses**
>
> You should specify group by and order by clauses in this space if you are not opting for the group by all and order by provided in OPTIONS config.

### Work ASOF Joins
After selecting options for ASOF Join, click **Generate join**, then use **Copy To Editor** to add the new ASOF join.
<img width="256" alt="ASOF Join: Generate join and Copy To Editor actions in the Coalesce App" src="https://github.com/user-attachments/assets/f87a6b11-8c3f-4226-8d5f-fdcd1e3a1c6e" />

### Work Deployment

#### Work Initial Deployment

When deployed for the first time into an Environment the Work Node of materialization type table will execute the below stage:

| **Stage** | **Description** |
|-----------|----------------|
| **Create Work Table** | This will execute a CREATE OR REPLACE statement and create a table in the target Environment |
| **Create Work View** | This will execute a CREATE OR REPLACE statement and create a view in the target Environment |

#### Work Redeployment

After the Work Node with materialization type table has been deployed for the first time into a target Environment, subsequent deployments may result in either altering the Work Table or recreating the Work table.

#### Altering the Work Tables

A few types of column or table changes will result in an ALTER statement to modify the Work Table in the target Environment, whether these changes are made individually or all together:

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

#### Recreating the Work Tables

If any of the following changes are detected, then the table will be recreated using a CREATE OR REPLACE.

* Join clause
* Adding transformation
* Changes in configuration like adding distinct, group by, or order by

One of the following stages is executed:

| **Stage** | **Description** |
|-----------|----------------|
| **Create Table** | Creates a new table |
| **Replace Table** | Replaces an existing table|

#### Recreating the Work Views

The subsequent deployment of the Work Node of materialization type view with changes in view definition, adding table description or renaming view results in deleting the existing view and recreating the view.

The following stages are executed:

| **Stage** | **Description** |
|-----------|----------------|
| **Delete View** | Removes existing view |
| **Create View** | Creates new view with updated definition |

### Removing a Work Node

If a Work Node of materialization type table is deleted from a Workspace, that Workspace is committed to Git and that commit deployed to a higher-level Environment, then the WorkTable in the target Environment will be dropped.

This is executed in two stages:

| **Stage** | **Description** |
|-----------|----------------|
| **Delete Table** | Coalesce Internal table is dropped |
| **Delete Table** | Target table in Snowflake is dropped |

If a Work Node of materialization type view is deleted from a Workspace, that Workspace is committed to Git and that commit deployed to a higher-level Environment, then the WorkView in the target Environment will be dropped.

The stage executed:

| **Stage** | **Description** |
|-----------|----------------|
| **Delete View** | Drops the existing Work view from the target Environment |

---

## Persistent Stage

The Persistent Stage Node serves as an intermediary object and is commonly used to persist data across multiple execution cycles.

It plays a crucial role in tracking the historical changes of columns linked to business keys.

This functionality is particularly beneficial when the objective is to retain raw data for prolonged durations.

### Persistent Stage Node Configuration

The Persistent Stage Node type has two configuration groups:

* [Node Properties](#persistent-stage-node-properties)
* [Options](#persistent-stage-options)

![Persistent Stage Node configuration](https://github.com/coalesceio/Coalesce-Base-Node-Types/assets/7216836/6f863c3b-3abd-4318-bd7e-ed50a829f911)

#### Persistent Stage Node Properties

| **Property** | **Description** |
|----------|-------------|
| **Storage Location** | Storage Location where the Persistent Stage table will be created |
| **Node Type** | Name of template used to create Node objects |
| **Description** | A description of the Node's purpose |
| **Deploy Enabled** | If TRUE the Node will be deployed or redeployed when changes are detected<br/> If FALSE the Node will not be deployed or will be dropped during redeployment |

#### Persistent Stage Options

| **Option** | **Description** |
|---------|-------------|
| **Create As** | Table is the only option at this time |
| **Multi Source** | Toggle: True or False<br/>Implementation of SQL UNIONs<br/>**True**: Combine multiple sources in a single Node<br/>True Options:<br/>- **UNION**: Combines with duplicate elimination<br/>- **UNION ALL**: Combines without duplicate elimination<br/>**False**: single-source Node or multiple sources combined using a join |
| **Business key** | Required column for both Type 1 and Type 2.<br/>**Note:** Geometry and Geography data type columns are not supported as business key columns. |
| **Last Modified Comparison** | **True**:When enabled, timestamp-based/ ID based CDC is performed.If the chosen column is timestamp-based, the test condition validates the source data for NULL values in the selected Last Modified column before the merge operation. The merge is blocked if NULL values are found and proceeds only after they are resolved<br/>**False**:Regular CDC based on Change tracking columns is done |
| **Last Modified Column(Enabled for Last Modified Comparison)** | Timestamp/Incremental ID column can be chosen.Based on which CDC is done |
| **Type 2 Dimension(Enabled for Last Modified Comparison)**|CDC is based on timestamp/ID column chosen above.Change tracking columns are not enabled for this scenario|
| **Change tracking** | Required column for Type 2 |
| **Delete Strategy** | Visible only when a Business Key is configured.<br/> **NO DELETE**: Deleted records are not processed.<br/>**SOFT DELETE**:  Deleted records are kept in the target but marked as inactive.<br/>**HARD DELETE**: Deleted records and all their version history are permanently removed from the target. |
| **Column that Identifies DML Operations** | The column in the source table that tells whether a record is an Insert, Update or Delete. |
| **Delete Value** | The value in the DML column that signals a record should be deleted. |
| **Truncate Before** | Toggle: True or False<br/>This determines whether a table will be truncated before data load.<br/> **True**:Truncate table stage gets executed<br/>**False**: Table is not truncated before data load |
| **Enable tests** | Toggle: True or False<br/>Determines if tests are enabled |
| **Distinct** | Toggle: True or False<br/>**True**: Group by All is invisible. DISTINCT data is chosen for processing<br/>**False**: Group by All is visible |
| **Group by All** | Toggle: True or False<br/>**True**: DISTINCT is invisible. Data is grouped by all columns for processing<br/>**False**: DISTINCT is visible |
| **Order By** | Toggle: True or False<br/>**True**: Sort column and sort order drop down are visible and are required to form order by clause<br/>**False**: Sort column and sort order drop down are invisible |
| **Pre-SQL** | SQL to execute before data insert operation |
| **Post-SQL** | SQL to execute after data insert operation |

### Persistent Stage Joins

Join conditions and other clauses can be specified in the join space next to mapping of columns in the Coalesce App.

![pstage_join](https://github.com/coalesceio/Coalesce-Base-Node-Types/assets/7216836/84ce06c9-103c-4700-ad3d-2e8222995b31)

> 📘 **Specify Group by and Order by Clauses**
>
> You should specify group by and order by clauses in this space if you are not opting for the group by all and order by provided in OPTIONS config.

### Persistent Stage Deployment

#### Persistent Stage Initial Deployment

When deployed for the first time into an Environment the Persistent Stage Node will execute the below stage:

| **Stage** | **Description** |
|-----------|----------------|
| **Create Persistent Table** | This will execute a CREATE OR REPLACE statement and create a table in the target Environment |

#### Persistent Stage Redeployment

After the Persistent Stage Node has been deployed for the first time into a target Environment, subsequent deployments may result in either altering the Persistent Table or recreating the Persistent table.

#### Altering the Persistent Tables

A few types of column or table changes will result in an ALTER statement to modify the Persistent Table in the target Environment, whether these changes are made individually or all together:

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

#### Recreating the Persistent Tables

If any of the following changes are detected, then the table will be recreated using a CREATE OR REPLACE.

* Join clause
* Adding transformation
* Changes in configuration like adding distinct, group by, or order by

One of the following stages is executed:

| **Stage** | **Description** |
|-----------|----------------|
| **Create Table** | Creates a new table |
| **Replace Table** | Replaces an existing table|

### Removing a Persistent Stage Node

If a Persistent Node is deleted from a Workspace, that Workspace is committed to Git and that commit deployed to a higher-level Environment, then the Persistent Table in the target Environment will be dropped.

This is executed in two stages:

| **Stage** | **Description** |
|-----------|----------------|
| **Delete Table** | Drops table |
| **Drop Table or View** | Removes the table |

---

## Dimension

The Coalesce Dimension UDN lets you develop and deploy a Dimension table in Snowflake.

A dimension table or dimension entity is a table or entity in a star, snowflake, or starflake schema that stores details about the facts. Dimension tables describe the different aspects of a business process.

### Dimension Node Configuration

The Dimension Node type has two configuration groups:

* [Node Properties](#dimension-node-properties)
* [Options](#dimension-options)

![Dimension Node configuration](https://github.com/coalesceio/Coalesce-Base-Node-Types/assets/7216836/6f863c3b-3abd-4318-bd7e-ed50a829f911)

#### Dimension Node Properties

| **Property** | **Description** |
|----------|-------------|
| **Storage Location** | Storage Location where the dimension table or view will be created |
| **Node Type** | Name of template used to create Node objects |
| **Description** | A description of the Node's purpose |
| **Deploy Enabled** | If TRUE the Node will be deployed or redeployed when changes are detected<br/> If FALSE the Node will not be deployed or will be dropped during redeployment |

#### Dimension Options

##### Dimension Table Options

| **Options** | **Description** |
|---------|-------------|
| **Create As** | Table or View |
| **Insert Zero Key Record** | Toggle: True or False<br/>Insert Zero Key Record to Dimension<br/>**True**:  Zero Key Record Options enabled.<br/>**False**: Zero Key Record not added|
| **Multi Source** | Toggle: True or False<br/>Implementation of SQL UNIONs<br/>**True**: Combine multiple sources in a single Node<br/>True Options:<br/>- **UNION**: Combines with duplicate elimination<br/>- **UNION ALL**: Combines without duplicate elimination<br/>**False**: single-source Node or multiple sources combined using a join |
| **Business key** | Required column for both Type 1 and Type 2 Dimensions.<br/>**Note:** Geometry and Geography data type columns are not supported as business key columns. |
| **Last Modified Comparison** | **True**:When enabled, timestamp-based/ ID based CDC is performed.If the chosen column is timestamp-based, the test condition validates the source data for NULL values in the selected Last Modified column before the merge operation. The merge is blocked if NULL values are found and proceeds only after they are resolved<br/>**False**:Regular CDC based on Change tracking columns is performed |
| **Last Modified Column(Enabled for Last Modified Comparison)** | Timestamp/Incremental ID column can be chosen.Based on which CDC is done |
| **Type 2 Dimension(Enabled for Last Modified Comparison)**|CDC is based on timestamp/ID column chosen above.Change tracking columns are not enabled for this scenario|
| **Change tracking** | Required column for Type 2 Dimension |
| **Truncate Before** | Toggle: True or False<br/>This determines whether a table will be truncated before data load.<br/> **True**:Truncate table stage gets executed<br/>**False**: Table is not truncated before data load |
| **Enable tests** | Toggle: True or False<br/>Determines if tests are enabled |
| **Distinct** | Toggle: True or False<br/>**True**: Group by All is invisible. DISTINCT data is chosen for processing<br/>**False**: Group by All is visible |
| **Group by All** | Toggle: True or False<br/>**True**: DISTINCT is invisible. Data is grouped by all columns for processing<br/>**False**: DISTINCT is visible |
| **Order By** | Toggle: True or False<br/>**True**: Sort column and sort order drop down are visible and are required to form order by clause<br/>**False**: Sort column and sort order drop down are invisible |
| **Zero Key Record Options** |Add custom zero key record values for : <br/> -Default Surrogate Key Value<br/>  -Default String Value <br/> -Default Date Value (Date Format DD-MM-YYYY) <br/>-Default Timestamp Value (Timestamp Format YYYY-MM-DD HH24:MI:SS.FF) <br/> -Default Boolean Value|
| **Advanced Zero Key Record Options** | Toggle: True or False<br/>**True**: Select Columns and the default value of the column for zero key record <br/>**False**: Advanced Zero Key Record Options not enabled|
| **Pre-SQL** | SQL to execute before data insert operation |
| **Post-SQL** | SQL to execute after data insert operation |

##### Dimension View Options

![Work_options_view1](https://github.com/coalesceio/Coalesce-Base-Node-Types/assets/7216836/7881c46e-0424-46ca-9a89-d111b5dbc379)

| **Options** | **Description** |
|---------|-------------|
| **Override Create SQL** | Toggle: True or False<br/>**True**: Customized Create SQL specified in the Create SQL space is executed. All other options are invisible except 'Enable Tests'<br/>**False**: Create view SQL based on options chosen are framed and executed |
| **Multi Source** | Toggle: True or False<br/>Implementation of SQL UNIONs<br/>**True**: Combine multiple sources in a single Node<br/>True Options:<br/>- **UNION**: Combines with duplicate elimination<br/>- **UNION ALL**: Combines without duplicate elimination<br/>**False**: single-source Node or multiple sources combined using a join |
| **Business key** | Required column for both Type 1 and Type 2 Dimensions |
| **Enable tests** | Toggle: True or False<br/>Determines if tests are enabled |
| **Distinct** | Toggle: True or False<br/>**True**: Group by All is invisible. DISTINCT data is chosen for processing<br/>**False**: Group by All is visible |
| **Group by All** | Toggle: True or False<br/>**True**: DISTINCT is invisible. Data is grouped by all columns for processing<br/>**False**: DISTINCT is visible |

### Dimension Joins

Join conditions and other clauses can be specified in the join space next to mapping of columns in the Coalesce App.

![Dimension_join](https://github.com/coalesceio/Coalesce-Base-Node-Types/assets/7216836/5c3df3b0-f56d-4276-a51f-22364206b3c3)

> 📘 **Specify Group by and Order by Clauses**
>
> You should specify group by and order by clauses in this space if you are not opting for the group by all and order by provided in OPTIONS config.

### Dimension Deployment

#### Dimension Initial Deployment

When deployed for the first time into an Environment the Dimension Node of materialization type table will execute the Create Dimension Table stage.

| **Stage** | **Description** |
|-----------|----------------|
| **Create Dimension Table** | This will execute a CREATE OR REPLACE statement and create a table in the target Environment |
| **Create Dimension View** | This will execute a CREATE OR REPLACE statement and create a view in the target Environment |

#### Dimension Redeployment

After the Dimension Node of materialization type table has been deployed for the first time into a target Environment, subsequent deployments may result in either altering the Dimension Table or recreating the Dimension table.

#### Altering the Dimension Tables

A few types of column or table changes will result in an ALTER statement to modify the Dimension Table in the target Environment, whether these changes are made individually or all together:

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

#### Recreating the Dimension Tables

If any of the following changes are detected, then the table will be recreated using a CREATE OR REPLACE.

* Join clause
* Adding transformation
* Changes in configuration like adding distinct, group by, or order by

One of the following stages is executed:

| **Stage** | **Description** |
|-----------|----------------|
| **Create Table** | Creates a new table |
| **Replace Table** | Replaces an existing table|

#### Recreating the Dimension Views

Any of the following changes to views will result in deleting and recreating the Dimension view.

* View definition
* Adding table description
* Renaming the view

### Removing a Dimension Node

If a Dimension Node is deleted from a Workspace, that Workspace is committed to Git and that commit deployed to a higher-level Environment, then the Dimension Table in the target Environment will be dropped.

This is executed in two stages:

| **Stage** | **Description** |
|-----------|----------------|
| **Delete Table** | Coalesce Internal table is dropped |
| **Delete Table** | Target table in Snowflake is dropped |

If a Dimension Node of materialization type view is deleted from a Workspace, that Workspace is committed to Git and that commit deployed to a higher-level Environment, then the Dimension View in the target Environment will be dropped.

| **Stage** | **Description** |
|-----------|----------------|
| **Delete View** | Drops the existing Dimension view from the target Environment. |

---

## Fact

The Coalesce Fact UDN lets you develop and deploy a Fact table in Snowflake.

A fact table or a fact entity is a table or entity in a star or snowflake schema that stores measures that measure the business, such as sales, cost of goods, or profit. Fact tables and entities aggregate measures, or the numerical data of a business.

### Fact Node Configuration

The Fact Node has two configuration groups:

* [Node Properties](#fact-node-properties)
* [Options](#fact-options)

![Fact Node configuration](https://github.com/coalesceio/Coalesce-Base-Node-Types/assets/7216836/6f863c3b-3abd-4318-bd7e-ed50a829f911)

#### Fact Node Properties

| **Properties** | **Description** |
|----------|-------------|
| **Storage Location** | Storage Location where the fact table will be created |
| **Node Type** | Name of template used to create Node objects |
| **Description** | A description of the Node's purpose |
| **Deploy Enabled** | If TRUE the Node will be deployed or redeployed when changes are detected<br/> If FALSE the Node will not be deployed or will be dropped during redeployment |

#### Fact Options

| **Options** | **Description** |
|---------|-------------|
| **Multi Source** | Toggle: True or False<br/>Implementation of SQL UNIONs<br/>**True**: Combine multiple sources in a single Node<br/>True Options:<br/>- **UNION**: Combines with duplicate elimination<br/>- **UNION ALL**: Combines without duplicate elimination<br/>**False**: single-source Node or multiple sources combined using a join |
| **Business key** | Required column for Fact table creation.<br/>**Note:** Geometry and Geography data type columns are not supported as business key columns. |
| **Last Modified Comparison** | **True**:When enabled, timestamp-based/ ID based CDC is performed.If the chosen column is timestamp-based, the test condition validates the source data for NULL values in the selected Last Modified column before the merge operation. The merge is blocked if NULL values are found and proceeds only after they are resolved<br/>**False**:Regular CDC based on Change tracking columns is done |
| **Last Modified Column(Enabled for Last Modified Comparison)** | Timestamp/Incremental ID column can be chosen.Based on which CDC is done |
| **Truncate Before** | Toggle: True or False<br/>This determines whether a table will be truncated before data load.<br/> **True**:Truncate table stage gets executed<br/>**False**: Table is not truncated before data load |
| **Enable tests** | Toggle: True or False<br/>Determines if tests are enabled |
| **Distinct** | Toggle: True or False<br/>**True**: Group by All is invisible. DISTINCT data is chosen for processing<br/>**False**: Group by All is visible |
| **Group by All** | Toggle: True or False<br/>**True**: DISTINCT is invisible. Data is grouped by all columns for processing<br/>**False**: DISTINCT is visible |
| **Order By** | Toggle: True or False<br/>**True**: Sort column and sort order drop down are visible and are required to form order by clause<br/>**False**: Sort column and sort order drop down are invisible |
| **Pre-SQL** | SQL to execute before data insert operation |
| **Post-SQL** | SQL to execute after data insert operation |

#### Fact View

![Work_options_view1](https://github.com/coalesceio/Coalesce-Base-Node-Types/assets/7216836/7881c46e-0424-46ca-9a89-d111b5dbc379)

| **Setting** | **Description** |
|---------|-------------|
| **Override Create SQL** | Toggle: True or False<br/>**True**: Customized Create SQL specified in the Create SQL space is executed. All other options are invisible except 'Enable Tests'<br/>**False**: Create view SQL based on options chosen are framed and executed |
| **Multi Source** | Toggle: True or False<br/>Implementation of SQL UNIONs<br/>**True**: Combine multiple sources in a single Node<br/>True Options:<br/>- **UNION**: Combines with duplicate elimination<br/>- **UNION ALL**: Combines without duplicate elimination<br/>**False**: single-source Node or multiple sources combined using a join |
| **Enable tests** | Toggle: True or False<br/>Determines if tests are enabled |
| **Distinct** | Toggle: True or False<br/>**True**: Group by All is invisible. DISTINCT data is chosen for processing<br/>**False**: Group by All is visible |
| **Group by All** | Toggle: True or False<br/>**True**: DISTINCT is invisible. Data is grouped by all columns for processing<br/>**False**: DISTINCT is visible |

### Fact Joins

Join conditions and other clauses like where, qualify can be specified in the join space next to mapping of columns in the Coalesce App.

![fact_join](https://github.com/coalesceio/Coalesce-Base-Node-Types/assets/7216836/e540d2d0-2623-4b99-a435-a26df5fe3306)

> 📘 **Specify Group by and Order by Clauses**
>
> You should specify group by and order by clauses in this space if you are not opting for the group by all and order by provided in OPTIONS config.

### Fact Deployment

#### Fact Initial Deployment

When deployed for the first time into an Environment the Fact Node of materialization type table will execute the Create Fact Table stage.

| **Stage** | **Description** |
|-----------|----------------|
| **Create Fact Table** | This will execute a CREATE OR REPLACE statement and create a table in the target Environment |
| **Create Fact View** | This will execute a CREATE OR REPLACE statement and create a view in the target Environment |

#### Fact Redeployment

After the Fact Node has been deployed for the first time into a target Environment, subsequent deployments may result in either altering the Fact Table or recreating the Fact table.

#### Altering the Fact Tables

A few types of column or table changes will result in an ALTER statement to modify the Fact Table in the target Environment, whether these changes are made individually or all together:

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

#### Recreating the Fact Tables

If any of the following changes are detected, the Fact table is recreated using `CREATE OR REPLACE`:

* Join clause
* Adding transformation
* Change in business key
* Changes in configuration like adding distinct, group by, or order by

One of the following stages is executed:

| **Stage** | **Description** |
|-----------|----------------|
| **Create Table** | Creates a new table |
| **Replace Table** | Replaces an existing table|

#### Recreating the Fact Views

The subsequent deployment of the Fact Node of materialization type view with changes in view definition, adding table description, or renaming the view results in deleting the existing view and recreating the view.

The following stages are executed:

| **Stage** | **Description** |
|-----------|----------------|
| **Delete View** | Removes existing view |
| **Create View** | Creates new view with updated definition |

### Removing a Fact Node

If a Fact Node is deleted from a Workspace, that Workspace is committed to Git and that commit deployed to a higher-level Environment, then the Fact Table in the target Environment will be dropped.

This is executed in two stages:

| **Stage** | **Description** |
|-----------|----------------|
| **Delete Table** | Coalesce Internal table is dropped |
| **Delete Table** | Target table in Snowflake is dropped |

---

## Factless Fact

The Coalesce Factless Fact UDN lets you develop and deploy a factless fact table in Snowflake.

A factless fact table is used to record events or situations that have no measures, and it has the same level of detail as the dimensions.

### Factless Fact Node Configuration

The Factless Fact Node has two configuration groups:

* [Node Properties](#factless-fact-node-properties)
* [Options](#factless-fact-options)

#### Factless Fact Node Properties

| **Properties** | **Description** |
|----------|-------------|
| **Storage Location** | Storage Location where the factless fact table will be created |
| **Node Type** | Name of template used to create Node objects |
| **Description** | A description of the Node's purpose |
| **Deploy Enabled** | If TRUE the Node will be deployed or redeployed when changes are detected<br/> If FALSE the Node will not be deployed or will be dropped during redeployment |

#### Factless Fact Options

![Factless_options](https://github.com/coalesceio/Coalesce-Base-Node-Types/assets/7216836/bf2430c4-2a62-4195-a817-e702461b2d14)

| **Options** | **Description** |
|---------|-------------|
| **Create As** | Table is the only option at this time |
| **Multi Source** | Toggle: True or False<br/>Implementation of SQL UNIONs<br/>**True**: Combine multiple sources in a single Node<br/>True Options:<br/>- **UNION**: Combines with duplicate elimination<br/>- **UNION ALL**: Combines without duplicate elimination<br/>**False**: single-source Node or multiple sources combined using a join |
| **Truncate Before** | Toggle: True or False<br/>This determines whether a table will be truncated before data load.<br/> **True**:Truncate table stage gets executed<br/>**False**: Table is not truncated before data load |
| **Enable tests** | Toggle: True or False<br/>Determines if tests are enabled |
| **Distinct** | Toggle: True or False<br/>**True**: Group by All is invisible. DISTINCT data is chosen for processing<br/>**False**: Group by All is visible |
| **Group by All** | Toggle: True or False<br/>**True**: DISTINCT is invisible. Data is grouped by all columns for processing<br/>**False**: DISTINCT is visible |
| **Order By** | Toggle: True or False<br/>**True**: Sort column and sort order drop down are visible and are required to form order by clause<br/>**False**: Sort column and sort order drop down are invisible |
| **Pre-SQL** | SQL to execute before data insert operation |
| **Post-SQL** | SQL to execute after data insert operation |

### Factless Fact Joins

Join conditions and other clauses like where, qualify can be specified in the join space next to mapping of columns in the Coalesce App.

![fact_join](https://github.com/coalesceio/Coalesce-Base-Node-Types/assets/7216836/fc432c42-0315-4fb5-8f93-7836190086ff)

> 📘 **Specify Group by and Order by Clauses**
>
> You should specify group by and order by clauses in this space if you are not opting for the group by all and order by provided in OPTIONS config.

### Factless Fact Deployment

#### Factless Fact Initial Deployment

When deployed for the first time into an Environment the Factless Fact Node of materialization type table will execute the Create Fact Table stage.

| **Stage** | **Description** |
|-----------|----------------|
| **Create Fact Table** | This will execute a CREATE OR REPLACE statement and create a table in the target Environment |

#### Factless Fact Redeployment

After the Factless Fact Node has been deployed for the first time into a target Environment, subsequent deployments may result in either altering the Factless Fact table or recreating the Factless Fact table.

#### Altering the Factless Fact Tables

A few types of column or table changes will result in an ALTER statement to modify the Factless Fact Table in the target Environment, whether these changes are made individually or all together:

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

#### Recreating the Factless Fact Tables

If any of the following changes are detected, then the table will be recreated using a CREATE OR REPLACE.

* Join clause
* Adding transformations
* Changes in configuration like adding distinct, group by, or order by

One of the following stages is executed:

| **Stage** | **Description** |
|-----------|----------------|
| **Create Table** | Creates a new table |
| **Replace Table** | Replaces an existing table|

### Removing a Factless Fact Node

If a Factless Fact Node is deleted from a Workspace, that Workspace is committed to Git and that commit deployed to a higher-level Environment, then the Factless Fact table in the target Environment will be dropped.

This is executed in two stages:

| **Stage** | **Description** |
|-----------|----------------|
| **Delete Table** | Coalesce Internal table is dropped |
| **Delete Table** | Target table in Snowflake is dropped |

---

## View

The Coalesce View UDN lets you develop and deploy a View in Snowflake.

A view allows the result of a query to be accessed as if it were a table. Views serve a variety of purposes, including combining, segregating, and protecting data.

### View Node Configuration

The View Node type has two configuration groups:

* [Node Properties](#view-node-properties)
* [Options](#view-options)

![View Node configuration](https://github.com/coalesceio/Coalesce-Base-Node-Types/assets/7216836/6f863c3b-3abd-4318-bd7e-ed50a829f911)

#### View Node Properties

| **Properties** | **Description** |
|----------|-------------|
| **Storage Location** | Storage Location where the view will be created |
| **Node Type** | Name of template used to create Node objects |
| **Description** | A description of the Node's purpose |
| **Deploy Enabled** | If TRUE the Node will be deployed or redeployed when changes are detected<br/> If FALSE the Node will not be deployed or will be dropped during redeployment |

#### View Options

| **Options** | **Description** |
|---------|-------------|
| **Override Create SQL** | Toggle: True or False<br/>**True**: Customized Create SQL specified in the Create SQL space is executed. All other options are invisible<br/>**False**: Create view SQL based on options chosen are framed and executed |
| **Multi Source** | Toggle: True or False<br/>Implementation of SQL UNIONs<br/>**True**: Combine multiple sources in a single Node<br/>True Options:<br/>- **UNION**: Combines with duplicate elimination<br/>- **UNION ALL**: Combines without duplicate elimination<br/>**False**: single-source Node or multiple sources combined using a join |
| **Distinct** | Toggle: True or False<br/>**True**: Group by All is invisible. DISTINCT data is chosen for processing<br/>**False**: Group by All is visible |
| **Group by All** | Toggle: True or False<br/>**True**: DISTINCT is invisible. Data is grouped by all columns for processing<br/>**False**: DISTINCT is visible |
| **Secure** | Toggle: True or False<br/>**True**: A secured view is created<br/>**False**: A normal view is created |

### View Joins

Join conditions and other clauses like where, qualify can be specified in the join space next to mapping of columns in the Coalesce App.

> 📘 **Specify Group by Clauses**
>
> Best Practice is to specify group by clauses in this space if you are not opting for the group by all provided in OPTIONS config.

### View Deployment

#### View Initial Deployment

When deployed for the first time into an Environment the View Node will execute the Create View stage.

| **Stage** | **Description** |
|-----------|----------------|
| **Create View** | This will execute a CREATE OR REPLACE statement and create a View in the target Environment |

#### View Redeployment

The subsequent deployment of the View Node with changes in view definition, adding table description, adding secure option or renaming view results in deleting the existing view and recreating the view.

The following stages are executed:

| **Stage** | **Description** |
|-----------|----------------|
| **Delete View** | Removes existing view |
| **Create View** | Creates new view with updated definition |

#### Removing a View Node

If a View Node is deleted from a Workspace, that Workspace is committed to Git and that commit deployed to a higher-level Environment, then the View in the target Environment will be dropped.

This is executed in the below stage:

| **Stage** | **Description** |
|-----------|----------------|
| **Delete View** | Removes the view from the Environment |

---

## SQL Work

The SQL Work node is a powerful transformation tool within Coalesce that allows developers to write custom, hand-coded SQL instead of using the standard graphical column-mapping interface. It is ideal for complex transformations, advanced window functions, or multi-step logic that is difficult to represent with the standard UI. While it provides maximum flexibility, it shifts the responsibility of column definition and logic maintenance to the SQL author.

### SQL Work Node Configuration

The SQL Work Node type has three configuration groups:

| |
|---|
| <img width="487" height="250" alt="image" src="https://github.com/user-attachments/assets/a342656c-66a8-4a6c-abe1-adbca4505163" /> |

* [General](#sql-work-general)
* [Node Annotations](#sql-work-node-annotations)
* [Column Annotations](#sql-work-column-annotations)

#### SQL Work General Options

| **Property** | **Description** |
|----------|-------------|
| **Storage Location** | Storage Location where the SQL Work table or view will be created |


### SQL Work Node Annotations

| |
|---|
| <img width="441" height="474" alt="image" src="https://github.com/user-attachments/assets/ed2cd106-7a03-4ef3-9237-fb803eaf0bf4" /> |

| **Property** | **Description** |
|---------|-------------|
| `@materializationType(type)` | Table/View |
| `@truncateBefore` | This determines whether a table will be truncated before data load.<br/>Table is truncated if **@truncateBefore** is added to the SQL, the truncate stage is executed; if absent, it is not executed.<br/> **Note:** Ignored on Views. |
| `@testsEnabled¹` | Tests are enabled if **@testsEnabled** is added to the SQL, tests are executed; if absent, they are not executed. |
| `@tests(querySQL, runOrder?, continueOnFailure?)` |(repeatable) Tests are performed only when **@testsEnabled** is added to the SQL. |
| `@preSQL("querySQL")` |(repeatable) SQL to execute before data insert operation. <br/> **Note:** Ignored on Views. |
| `@postSQL(querySQL)` | (repeatable) SQL to execute after data insert operation. <br/> **Note:** Ignored on Views. |


### SQL Work Column Annotations

| |
|---|
| <img width="451" height="416" alt="image" src="https://github.com/user-attachments/assets/8a2e5186-c6e4-4db7-a7c1-ff363f1e3a22" /> |

| **Property** | **Description** |
|---------|-------------|
| `@notNull` | Marks column as NOT NULL. <br/> **Note:** Ignored on Views.  |
| `@description("<descText>")` | Adds column description |
| `@defaultValue("<value>")` | Adds default value. <br/> Default value must match the column's data type — use quotes for strings, and quotes can be omitted for non-string values. <br/> **Note:** Ignored on Views.  |
| `@tests(type)` |(repeatable) Column tests are defined at the individual column level and are used to validate specific column attributes and data quality requirements.<br/>**Supported Tests**<br/>- **null** → Checks for NULL values<br/>- **unique** → Checks to ensure all values are unique. <br/> **Note:** Applicable only when **@testsEnabled** is added to the SQL. |
| `@inHash("<hash_name>",<hash_order>)` **²** |(repeatable) Generates a hash key by combining and hashing the values of columns associated with a given hash group, ensuring consistent change detection and key generation.<br/>**Default:** Uses `SHA1` algorithm. |

---

### Notes

- Verify that all **column datatypes** are successfully resolved before creating the object. Columns with an `UNKNOWN` datatype may cause stage generation or runtime failures.
- It is recommended to use **DISTINCT**, **UNION** and **UNION ALL** within a CTE rather than directly in the final **SELECT** query.
- **¹** Tests are performed only when `Enable tests` is ON
    ```text
    @tests("<querySQL>", "<runOrder>", <continueOnFailure>)
    ```
    | Parameter | Description |
    |-----------|-------------|
    | querySQL | SQL statement to execute as a validation test. The test fails if the query returns any records. |
    | runOrder |**(optional)** `Before` or `After`. Determines whether the test is executed before or after the load operation. |
    | continueOnFailure |**(optional)** `true` or `false`. Determines whether execution continues when the test fails. |
    
    **Examples**
    
    ```text
    @tests("SELECT 1 FROM {{ this }} GROUP BY N_COMMENT HAVING COUNT(*) > 1", "Before", true)
    
    @tests("SELECT 1 FROM {{ this }} GROUP BY N_COMMENT HAVING COUNT(*) > 1", "After", true)
    ```
- **²** The hash transformation can be defined either using the reusable macro or by writing the full hash expression explicitly. Both approaches are supported and will produce the same result. Choose the macro approach for better reusability and cleaner code, or use the explicit expression when custom logic is required.

    Use `get_hash()` to generate a hash value for one or more columns. The same `hash_name` can be used across columns to **group columns** which belong to the same hash.
    
    ```sql
    {{ get_hash(<hash_name>, <algo>, <delimiter>, <datatype>) }}
    ```
    
    | Parameter | Description |
    |-----------|-------------|
    | `hash_name` | Hash name used across columns to identify the columns included in the hash. |
    | `algo` | **(optional)** Hashing algorithm to use. Supported values include `SHA1`, `SHA256`, and `MD5`. Defaults to `SHA1`. |
    | `delimiter` | **(optional)** Delimiter used to separate column values when generating the hash. Defaults to `\|\|` and can be customized. |
    | `datatype` | **(optional)** Data type of the returned hash value. Defaults to `STRING`. |

    #### Examples:
    
    Using hash macro(default-SHA1)
    ```sql
    <col_name> AS <col_name> @inHash("GH_COL",1),
    {{ get_hash('GH_COL') }}::STRING AS "GH_COL"
    ```
    Using hash macro(MD5)
    ```sql
    <col_name> AS <col_name> @inHash("GH_COL",1),
    {{ get_hash('GH_COL', 'MD5') }}::STRING AS "GH_COL"<SHA256
    ```
    Using hash macro(SHA256)
    ```sql
    <col_name> AS <col_name> @inHash("GH_COL",1),
    {{ get_hash('GH_COL', 'SHA256') }}::STRING AS "GH_COL"
    ```
    Using hash macro(algo=SHA256, delimeter='~' )
    ```sql
    <col_name> AS <col_name> @inHash("GH_COL",1),
    {{ get_hash('GH_COL', algo='SHA256', delimiter='~') }}::STRING AS "GH_COL"
    ```
    Using multiple keys hash macro
    ```sql
    <col_name1> AS <col_name1> @inHash("GH_COL", 1),
    <col_name2> AS <col_name2> @inHash("GH_COL", 2),
    {{ get_hash('GH_COL') }}::STRING AS "GH_COL_COMBINED"
    ```
    Using multiple hash macros
    ```sql
    <col_name1> AS <col_name1> @inHash("GH_COL1",1 , "GH_COL2",2),
    <col_name2> AS <col_name2> @inHash("GH_COL1",2),
    <col_name3> AS <col_name3> @inHash("GH_COL2",1),
    {{ get_hash('GH_COL1') }}::STRING AS "GH_COL_COMBINED1",
    {{ get_hash('GH_COL2', delimiter='~') }}::STRING AS "GH_COL_COMBINED2"
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

### Known Limitations

Users should be aware of the following technical constraints when using SQL:

* **Parsable SQL Only**:
 The node only supports SQL that can be fully parsed by the platform’s engine. Non-standard SQL or vendor-specific "semantic views" that bypass standard parsing will not work.

* **SELECT Statements Only**:  
This node only supports data retrieval and transformation logic. DML or DDL commands such as `CREATE`, `MERGE`, `DELETE`, `UPDATE`, or `TRUNCATE` are not supported and will cause execution failures.

* **Support for `DISTINCT`, `UNION`, and `UNION ALL`**:  
`DISTINCT`, `UNION`, and `UNION ALL` are fully supported when used within **Common Table Expressions (CTEs)**. While these keywords can also be used in standard `SELECT` statements without generating an error, they may not parsed correctly by the platform. As a result, subsequent clauses (such as `JOIN`s) may be interpreted as part of a standard join structure, causing the generated SQL to differ from the intended query and potentially leading to inconsistent data loads. To ensure the SQL is parsed and executed as expected, always implement these operations inside a CTE.

* **Other Keywords**:  
GROUP BY, ORDER BY and HAVING clauses can be included as part of the join query and will be parsed and processed accordingly.

---

### Usage Examples 

The following patterns represent common ways to use the SQL Node.<br/>

**Sample node with Annotations**
```sql
SELECT
     "N_NATIONKEY" AS "N_NATIONKEY" @notNull  @inHash("GH_COL",1),
     "N_NAME" AS "N_NAME" @defaultValue("NA"),
     "N_REGIONKEY" AS "N_REGIONKEY" @description("region key"),
     "N_COMMENT" AS "N_COMMENT" @inHash("GH_COL",2),
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP" @tests("null", "unique"),
     {{ get_hash('GH_COL') }}::STRING AS "GH_COL"
FROM {{ ref('SOURCE_DATA', 'NATION') }} "NATION"
```
**Basic Transformation & Cleaning** - Standard pattern for renaming columns and handling nulls.

```sql
SELECT
     "O_ORDERKEY" AS "O_ORDERKEY",
     "O_CUSTKEY" AS "O_CUSTKEY",
     UPPER("O_ORDERSTATUS") AS "O_ORDERSTATUS",
     COALESCE("O_TOTALPRICE", 0) AS "O_TOTALPRICE",
     "O_ORDERDATE" AS "O_ORDERDATE"
FROM {{ ref('SRC', 'ORDERS') }} "ORDERS"
WHERE "O_ORDERSTATUS" != 'F'
```
**Using CTEs (Common Table Expressions)** - For more complex, multi-step logic

```sql
WITH PRIORITY_COUNTS AS (
    SELECT 
        "O_ORDERPRIORITY" AS "O_ORDERPRIORITY",
        COUNT(*) AS ORDER_COUNT
    FROM {{ ref('SRC', 'ORDERS') }}
    GROUP BY 1
)
SELECT * FROM PRIORITY_COUNTS
```
**Multi-CTE Transformation With Window Functions** <br/>
Complex transformations that would otherwise require multiple nodes can be written as a single SQL statement. Coalesce tracks lineage through each CTE and down to the source tables
```sql
WITH ORDERED_ORDERS AS (
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
) AS ORDER_RANK
FROM {{ ref('SRC', 'ORDERS') }}
),
FIRST_ORDERS AS (
-- CTE 2: Filter to keep only the first order (rank 1) for each customer
SELECT
O_CUSTKEY,
O_ORDERKEY AS FIRST_ORDER_ID,
O_ORDERDATE AS FIRST_PURCHASE_DATE,
O_TOTALPRICE AS FIRST_ORDER_VALUE,
O_ORDERSTATUS
FROM ORDERED_ORDERS
WHERE ORDER_RANK = 1
)
-- Final Select: Add metadata and return the results
SELECT
F.O_CUSTKEY,
F.FIRST_ORDER_ID,
F.FIRST_PURCHASE_DATE,
F.FIRST_ORDER_VALUE,
F.O_ORDERSTATUS @notNull,
CURRENT_TIMESTAMP() AS REFRESHED_AT,
'Initial Customer Purchase' AS RECORD_TYPE
FROM FIRST_ORDERS F
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
    SELECT *
    FROM {{ ref('SOURCE_DATA', 'NATION_COPY1') }}
    UNION
    SELECT *
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
  
- If a CTE is referenced in templates that may include joins, always use a **table alias** and qualify all column references with that alias. This prevents ambiguous column errors and ensures the template remains extensible as additional joins are introduced.

----

### SQL Work Deployment

#### SQL Work Initial Deployment

When deployed for the first time into an Environment the SQL Work Node of materialization type table will execute the below stage:

| **Stage** | **Description** |
|-----------|----------------|
| **Create SQL Work Table** | This will execute a CREATE OR REPLACE statement and create a table in the target Environment |
| **Create SQL Work View** | This will execute a CREATE OR REPLACE statement and create a view in the target Environment |

#### SQL Work Redeployment

After the SQL Work Node with materialization type table has been deployed for the first time into a target Environment, subsequent deployments may result in either altering the SQL Work Table or recreating the SQL Work table.

#### Altering the SQL Work Tables

A few types of column or table changes will result in an ALTER statement to modify the SQL Work Table in the target Environment, whether these changes are made individually or all together:

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

> **Note:** Renaming a column results in the existing column being dropped and a new column being created. This operation may lead to data loss and should be performed with caution.

#### Recreating the SQL Work Tables

If any of the following changes are detected, then the table will be recreated using a CREATE OR REPLACE.

* Join clause
* Adding transformation
* Changes in configuration like adding distinct, group by, or order by

One of the following stages is executed:

| **Stage** | **Description** |
|-----------|----------------|
| **Create Table** | Creates a new table |
| **Replace Table** | Replaces an existing table|

#### Recreating the SQL Work Views

The subsequent deployment of the SQL Work Node of materialization type view with changes in view definition, adding table description or renaming view results in deleting the existing view and recreating the view.

The following stages are executed:

| **Stage** | **Description** |
|-----------|----------------|
| **Delete View** | Removes existing view |
| **Create View** | Creates new view with updated definition |

### Removing a SQL Work Node

If a SQL Work Node of materialization type table is deleted from a SQL Workspace, that SQL Workspace is committed to Git and that commit deployed to a higher-level Environment, then the SQL WorkTable in the target Environment will be dropped.

This is executed in two stages:

| **Stage** | **Description** |
|-----------|----------------|
| **Delete Table** | Coalesce Internal table is dropped |
| **Delete Table** | Target table in Snowflake is dropped |

If a SQL Work Node of materialization type view is deleted from a Workspace, that Workspace is committed to Git and that commit deployed to a higher-level Environment, then the WorkView in the target Environment will be dropped.

The stage executed:

| **Stage** | **Description** |
|-----------|----------------|
| **Delete View** | Drops the existing SQL Work view from the target Environment |

---

## Code

### Work Code

* [Node definition](https://github.com/coalesceio/Coalesce-Base-Node-Types/blob/main/nodeTypes/Work-204/definition.yml)
* [Create Template](https://github.com/coalesceio/Coalesce-Base-Node-Types/blob/main/nodeTypes/Work-204/create.sql.j2)
* [Run Template](https://github.com/coalesceio/Coalesce-Base-Node-Types/blob/main/nodeTypes/Work-204/run.sql.j2)

### Persistent Stage Code

* [Node definition](https://github.com/coalesceio/Coalesce-Base-Node-Types/blob/main/nodeTypes/PersistentStage-173/definition.yml)
* [Create Template](https://github.com/coalesceio/Coalesce-Base-Node-Types/blob/main/nodeTypes/PersistentStage-173/create.sql.j2)
* [Run Template](https://github.com/coalesceio/Coalesce-Base-Node-Types/blob/main/nodeTypes/PersistentStage-173/run.sql.j2)

### Dimension Code

* [Node definition](https://github.com/coalesceio/Coalesce-Base-Node-Types/blob/main/nodeTypes/Dimension-194/definition.yml)
* [Create Template](https://github.com/coalesceio/Coalesce-Base-Node-Types/blob/main/nodeTypes/Dimension-194/create.sql.j2)
* [Run Template](https://github.com/coalesceio/Coalesce-Base-Node-Types/blob/main/nodeTypes/Dimension-194/run.sql.j2)

### Fact Code

* [Node definition](https://github.com/coalesceio/Coalesce-Base-Node-Types/blob/main/nodeTypes/Fact-205/definition.yml)
* [Create Template](https://github.com/coalesceio/Coalesce-Base-Node-Types/blob/main/nodeTypes/Fact-205/create.sql.j2)
* [Run Template](https://github.com/coalesceio/Coalesce-Base-Node-Types/blob/main/nodeTypes/Fact-205/run.sql.j2)

### Factless Fact Code

* [Node definition](https://github.com/coalesceio/Coalesce-Base-Node-Types/blob/main/nodeTypes/FactlessFact-248/definition.yml)
* [Create Template](https://github.com/coalesceio/Coalesce-Base-Node-Types/blob/main/nodeTypes/FactlessFact-248/create.sql.j2)
* [Run Template](https://github.com/coalesceio/Coalesce-Base-Node-Types/blob/main/nodeTypes/FactlessFact-248/run.sql.j2)

### View Code

* [Node definition](https://github.com/coalesceio/Coalesce-Base-Node-Types/blob/main/nodeTypes/View-188/definition.yml)
* [Create Template](https://github.com/coalesceio/Coalesce-Base-Node-Types/blob/main/nodeTypes/View-188/create.sql.j2)
* [Run Template](https://github.com/coalesceio/Coalesce-Base-Node-Types/blob/main/nodeTypes/View-188/run.sql.j2)

### SQL Work Code

* [Node definition]()
* [Create Template]()
* [Run Template]()

### Macros

* [macro-1.yml](https://github.com/coalesceio/Coalesce-Base-Node-Types/blob/main/macros/macro-1.yml)
