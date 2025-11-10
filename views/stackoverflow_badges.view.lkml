view: stackoverflow_badges {
  sql_table_name: `@{stackoverflow_badges_table}` ;;

  # Primary Key (hidden)
  dimension: id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  # Dimensions
  dimension: badge_id {
    type: number
    label: "Badge ID"
    description: "Unique identifier for the badge"
    sql: ${TABLE}.id ;;
  }

  dimension: name {
    type: string
    label: "Badge Name"
    description: "Name of the badge"
    sql: ${TABLE}.name ;;
  }

  dimension: user_id {
    type: number
    label: "User ID"
    description: "ID of the user who earned the badge"
    sql: ${TABLE}.user_id ;;
  }

  dimension: class {
    type: number
    label: "Badge Class"
    description: "Class/level of the badge"
    sql: ${TABLE}.class ;;
  }

  dimension: tag_based {
    type: yesno
    label: "Tag Based"
    description: "Whether this badge is tag-based"
    sql: ${TABLE}.tag_based ;;
  }

  # Dimension Groups (Date/Time)
  dimension_group: date {
    type: time
    label: "Date"
    timeframes: [time, date, week, month, raw]
    sql: ${TABLE}.date ;;
  }

  dimension: date_month_year {
    group_label: "Date"
    label: "Month + Year"
    type: string
    sql: DATE_TRUNC(${date_date}, MONTH) ;;
    html: {{ rendered_value | date: "%B %Y" }};;
  }

  # Measures
  measure: count {
    type: count
    label: "Count of Badges"
    description: "Total number of badges awarded"
    drill_fields: [badge_id, name, user_id, date_date]
  }

  measure: count_users_with_badges {
    type: count_distinct
    label: "Count of Users with Badges"
    description: "Total number of unique users who earned badges"
    sql: ${user_id} ;;
    value_format: "#,##0.00"
  }

  measure: count_badge_types {
    type: count_distinct
    label: "Count of Unique Badge Types"
    description: "Total number of different badge types"
    sql: ${name} ;;
    value_format: "#,##0.00"
  }
}
