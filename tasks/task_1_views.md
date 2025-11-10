# Task

Generate LookML vies for a looker project 'stackoverflow_test' that uses 'stackoverflow_test' model file.

# Database/Connection

This Looker project is connected to a database in BigQuery

# Model file
The model file is already created with the connection defined.

* Add 'include` lines to include elements from Views folder

# Project structure

* Create folders:
   * Views (for view files)

# Manifest
Create a manifest file to define constants 

* note that manifest file should have only constants. there is no need to define connection there
* no need to include manifest file in the model file. Other files in the project automatically can access manifest file.

## Use of variables from manifest file
When a table name defined as a constant in the manifest file then the constant should be put in `` when is used in a view file.
For example:
* Manifeset constant:
'''
constant: table_name {
 value: "project_name.schema_name.table_name"
 export: override_required
}
'''
* View file:
```
view: view_name {
 sql_table_name: `@{table_name}` ;;
 ...
}
```

# Views
## View 1

Source:  `prj-s-dlp-dq-sandbox-0b3c.EK_test_data.stackoverflow_users`

Name: stackoverflow_users

Table's ddl:
CREATE TABLE `prj-s-dlp-dq-sandbox-0b3c.EK_test_data.stackoverflow_users`
(
  id INT64,
  display_name STRING,
  about_me STRING,
  age STRING,
  creation_date TIMESTAMP,
  last_access_date TIMESTAMP,
  location STRING,
  reputation INT64,
  up_votes INT64,
  down_votes INT64,
  views INT64,
  profile_image_url STRING,
  website_url STRING
);

Dimensions:
id INT64,
  display_name STRING,
  about_me STRING,
  age STRING,
  profile_image_url STRING,
  website_url STRING

Dimension_groups (type time):
  creation_date TIMESTAMP,
  last_access_date TIMESTAMP,

Specific_dimensions:
  location STRING (the field has a lot of NULL values, other values are like this: 
  Texas USA,
France,
Earth,
italy,
Brasil,
Hanamkonda,
Indore,
LAGOS MAINLAND,
Xian, 陕西省中国,
Churachandpur,
Bengaluru,
Argentina,
Conceição do Ouros - MG - Brasil)

Measures:
reputation INT64,
  up_votes INT64,
  down_votes INT64,
  views INT64,

## View 2 
Source: `prj-s-dlp-dq-sandbox-0b3c.EK_test_data.stackoverflow_badges`

Name: stackoverflow_badges

Table's ddl:
CREATE TABLE `prj-s-dlp-dq-sandbox-0b3c.EK_test_data.stackoverflow_badges`
(
  id INT64,
  name STRING,
  date TIMESTAMP,
  user_id INT64,
  class INT64,
  tag_based BOOL
);

Dimensions:
  id INT64,
  name STRING,
  user_id INT64,
  class INT64,
  tag_based BOOL

Dimension_groups (type time):
  date TIMESTAMP

## View 3

Source:  `prj-s-dlp-dq-sandbox-0b3c.EK_test_data.stackoverflow_comments`

Name: stackoverflow_comments

Table's ddl:
CREATE TABLE `prj-s-dlp-dq-sandbox-0b3c.EK_test_data.stackoverflow_comments`
(
  id INT64,
  text STRING,
  creation_date TIMESTAMP,
  post_id INT64,
  user_id INT64,
  user_display_name STRING,
  score INT64
);

Dimensions:
  id INT64,
  text STRING,
  post_id INT64,
  user_id INT64,
  user_display_name STRING,

Dimension_groups (type time):
  creation_date TIMESTAMP


Measures:
  score INT64

...


## How to build views

* All dimensions and measures should have labels and descriptions
   * if description for a field is not provided then either put something simple there if it can be derived from the field name or leave it empty
* All measures should be defined first as hidden dimensions and then created as measures based on those dimensions
* Measure values can be NULLs so please make sure to convert NULLs to 0 for measures otherwise aggregation won't work
* All measures should have the following format: value_format: "#,##0.00"
* None of the tables have a primary key so I would like you to add it to each view and declare it as a primary key and make it hidden
* define both table names as constants in the manifest file and use those constants in 'sql_table_name' or 'derived_table'


## Defining date dimensions
For date or timestamp type of dimension please use `dimension_group` with type `time`
Please follow this structure where `created` is just an example (please note that for `labal: "Created"` Looker will add `Date` automatically in the end as it's a dimension group)
```
dimension_group: created {
 type: time
 label: "Created"
 timeframes: [time, date, week, month, raw]
 sql: ${TABLE}.created_at ;;
}
```

also add a formated date as dimension that is going to be a part of this dimension group.
like this:
```
dimension: created_month_year {
   group_label: "Created Date"
   label: "Month + Year"
   type: string
   sql: DATE_TRUNC(${created_date}, MONTH) ;;
   html: {{ rendered_value | date: "%B %Y" }};;
 }
```

## Defining geo dimensions that can be used in map chart
### type: location
type: location is used in conjunction with the sql_latitude and sql_longitude parameters to create coordinates that you want to plot on a Map or Static Map (Points) visualization
```
view: view_name {
 dimension: field_name {
   type: location
   sql_latitude:${field_name_1} ;;
   sql_longitude:${field_name_2} ;;
 }
}
```

### type: zipcode
type: zipcode is used with zip code dimensions that you want to plot on a Static Map (Points) visualization (use a state or country field for Static Map (Regions)). Any dimension of type: zipcode is automatically given the map_layer_name of us_zipcode_tabulation_areas

```
dimension: zip {
 type: zipcode
 sql: ${TABLE}.zipcode ;;
}
```

# Rules/Best Practices

Please check Best Practices in the "best_practices.md" file that is located in the same folder
