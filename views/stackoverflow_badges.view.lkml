view: stackoverflow_badges {
  sql_table_name: `@{stackoverflow_badges_table}` ;;

  # Primary Key (hidden)
  dimension: id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  # Regular Dimensions!
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
    description: "Class level of the badge"
    sql: ${TABLE}.class ;;
  }

  dimension: tag_based {
    type: yesno
    label: "Tag Based"
    description: "Whether the badge is tag-based"
    sql: ${TABLE}.tag_based ;;
  }

  # Time Dimension
  dimension_group: date {
    type: time
    label: "Date"
    timeframes: [time, date, week, month, raw]
    sql: ${TABLE}.date ;;
  }

  dimension: date_month_year {
    group_label: "Date Date"
    label: "Month + Year"
    type: string
    sql: DATE_TRUNC(${date_date}, MONTH) ;;
    html: {{ rendered_value | date: "%B %Y" }};;
  }

  # Measures
  measure: count {
    type: count
    label: "Number of Badges"
    description: "Total count of badges earned"
  }
}
