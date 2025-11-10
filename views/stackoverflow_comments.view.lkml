view: stackoverflow_comments {
  sql_table_name: `@{stackoverflow_comments_table}` ;;

  # Primary Key (hidden)
  dimension: id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  # Regular Dimensions
  dimension: text {
    type: string
    label: "Comment Text"
    description: "Text content of the comment"
    sql: ${TABLE}.text ;;
  }

  dimension: post_id {
    type: number
    label: "Post ID"
    description: "ID of the post this comment belongs to"
    sql: ${TABLE}.post_id ;;
  }

  dimension: user_id {
    type: number
    label: "User ID"
    description: "ID of the user who made the comment"
    sql: ${TABLE}.user_id ;;
  }

  dimension: user_display_name {
    type: string
    label: "User Display Name"
    description: "Display name of the user who made the comment"
    sql: ${TABLE}.user_display_name ;;
  }

  # Time Dimension
  dimension_group: creation {
    type: time
    label: "Creation"
    timeframes: [time, date, week, month, raw]
    sql: ${TABLE}.creation_date ;;
  }

  dimension: creation_month_year {
    group_label: "Creation Date"
    label: "Month + Year"
    type: string
    sql: DATE_TRUNC(${creation_date}, MONTH) ;;
    html: {{ rendered_value | date: "%B %Y" }};;
  }

  # Hidden Dimension for Measure
  dimension: _score {
    hidden: yes
    type: number
    sql: ${TABLE}.score ;;
  }

  # Measures
  measure: score {
    type: sum
    label: "Total Score"
    description: "Sum of comment scores"
    sql: IFNULL(${_score}, 0) ;;
    value_format: "#,##0.00"
  }

  measure: count {
    type: count
    label: "Number of Comments"
    description: "Total count of comments"
  }
}
