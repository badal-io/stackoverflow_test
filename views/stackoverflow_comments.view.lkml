view: stackoverflow_comments {
  sql_table_name: `@{stackoverflow_comments_table}` ;;

  # Primary Key (hidden)
  dimension: id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  # Dimensions
  dimension: comment_id {
    type: number
    label: "Comment ID"
    description: "Unique identifier for the comment"
    sql: ${TABLE}.id ;;
  }

  dimension: text {
    type: string
    label: "Comment Text"
    description: "The comment content"
    sql: ${TABLE}.text ;;
  }

  dimension: post_id {
    type: number
    label: "Post ID"
    description: "ID of the post the comment belongs to"
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

  # Dimension Groups (Date/Time)
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

  # Hidden dimension for measures
  dimension: score_value {
    hidden: yes
    type: number
    sql: ${TABLE}.score ;;
  }

  # Measures
  measure: total_score {
    type: sum
    label: "Total Score"
    description: "Sum of all comment scores"
    sql: COALESCE(${score_value}, 0) ;;
    value_format: "#,##0.00"
  }

  measure: average_score {
    type: average
    label: "Average Score"
    description: "Average comment score"
    sql: COALESCE(${score_value}, 0) ;;
    value_format: "#,##0.00"
  }

  measure: count {
    type: count
    label: "Count of Comments"
    description: "Total number of comments"
    drill_fields: [comment_id, user_display_name, post_id, creation_date]
  }

  measure: count_users_commenting {
    type: count_distinct
    label: "Count of Users Commenting"
    description: "Total number of unique users who made comments"
    sql: ${user_id} ;;
    value_format: "#,##0.00"
  }

  measure: count_posts_commented {
    type: count_distinct
    label: "Count of Posts with Comments"
    description: "Total number of unique posts that have comments"
    sql: ${post_id} ;;
    value_format: "#,##0.00"
  }
}
