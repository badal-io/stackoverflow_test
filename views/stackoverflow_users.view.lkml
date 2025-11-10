view: stackoverflow_users {
  sql_table_name: `@{stackoverflow_users_table}` ;;

  # Primary Key (hidden)
  dimension: id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  # Regular Dimensions
  dimension: display_name {
    type: string
    label: "Display Name"
    description: "User's display name"
    sql: ${TABLE}.display_name ;;
  }

  dimension: about_me {
    type: string
    label: "About Me"
    description: "User's about me section"
    sql: ${TABLE}.about_me ;;
  }

  dimension: age {
    type: string
    label: "Age"
    description: "User's age"
    sql: ${TABLE}.age ;;
  }

  dimension: profile_image_url {
    type: string
    label: "Profile Image URL"
    description: "URL to user's profile image"
    sql: ${TABLE}.profile_image_url ;;
  }

  dimension: website_url {
    type: string
    label: "Website URL"
    description: "User's website URL"
    sql: ${TABLE}.website_url ;;
  }

  dimension: location {
    type: string
    label: "Location"
    description: "User's location (contains many NULL values)"
    sql: ${TABLE}.location ;;
  }

  # Time Dimensions
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

  dimension_group: last_access {
    type: time
    label: "Last Access"
    timeframes: [time, date, week, month, raw]
    sql: ${TABLE}.last_access_date ;;
  }

  dimension: last_access_month_year {
    group_label: "Last Access Date"
    label: "Month + Year"
    type: string
    sql: DATE_TRUNC(${last_access_date}, MONTH) ;;
    html: {{ rendered_value | date: "%B %Y" }};;
  }

  # Hidden Dimensions for Measures
  dimension: _reputation {
    hidden: yes
    type: number
    sql: ${TABLE}.reputation ;;
  }

  dimension: _up_votes {
    hidden: yes
    type: number
    sql: ${TABLE}.up_votes ;;
  }

  dimension: _down_votes {
    hidden: yes
    type: number
    sql: ${TABLE}.down_votes ;;
  }

  dimension: _views {
    hidden: yes
    type: number
    sql: ${TABLE}.views ;;
  }

  # Measures
  measure: reputation {
    type: sum
    label: "Total Reputation"
    description: "Sum of user reputation scores"
    sql: IFNULL(${_reputation}, 0) ;;
    value_format: "#,##0.00"
  }

  measure: up_votes {
    type: sum
    label: "Total Up Votes"
    description: "Sum of up votes received by users"
    sql: IFNULL(${_up_votes}, 0) ;;
    value_format: "#,##0.00"
  }

  measure: down_votes {
    type: sum
    label: "Total Down Votes"
    description: "Sum of down votes received by users"
    sql: IFNULL(${_down_votes}, 0) ;;
    value_format: "#,##0.00"
  }

  measure: views {
    type: sum
    label: "Total Views"
    description: "Sum of views on user profiles"
    sql: IFNULL(${_views}, 0) ;;
    value_format: "#,##0.00"
  }

  measure: count {
    type: count
    label: "Number of Users"
    description: "Total count of users"
  }
}
