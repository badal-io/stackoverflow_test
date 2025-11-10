view: stackoverflow_comments {
  sql_table_name: `@{stackoverflow_comments_table}` ;;

  dimension: id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: text {
    type: string
    label: "Text"
    description: "Comment text"
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
    description: "ID of the user who wrote the comment"
    sql: ${TABLE}.user_id ;;
  }

  dimension: user_display_name {
    type: string
    label: "User Display Name"
    description: "Display name of the user who wrote the comment"
    sql: ${TABLE}.user_display_name ;;
  }

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

  dimension: score_hidden {
    hidden: yes
    type: number
    sql: COALESCE(${TABLE}.score, 0) ;;
  }

  measure: score {
    type: sum
    label: "Score"
    description: "Total score of comments"
    sql: ${score_hidden} ;;
    value_format: "#,##0.00"
  }

  measure: count {
    type: count
    label: "Count"
    description: "Number of comments"
  }
}
