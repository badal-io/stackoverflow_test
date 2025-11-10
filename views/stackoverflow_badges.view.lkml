view: stackoverflow_badges {
  sql_table_name: `@{stackoverflow_badges_table}` ;;

  dimension: id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: name {
    type: string
    label: "Name"
    description: "Badge name"
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
    label: "Class"
    description: "Badge class"
    sql: ${TABLE}.class ;;
  }

  dimension: tag_based {
    type: yesno
    label: "Tag Based"
    description: "Whether this is a tag-based badge"
    sql: ${TABLE}.tag_based ;;
  }

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

  measure: count {
    type: count
    label: "Count"
    description: "Number of badges"
  }
}
