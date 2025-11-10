view: stackoverflow_users {
  sql_table_name: `@{stackoverflow_users_table}` ;;

  # Primary Key (hidden)
  dimension: id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  # Dimensions
  dimension: user_id {
    type: number
    primary_key: yes
    label: "User ID"
    description: "Unique identifier for the user"
    sql: ${TABLE}.id ;;
  }

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

  # Hidden dimensions for measures
  dimension: reputation_value {
    hidden: yes
    type: number
    sql: ${TABLE}.reputation ;;
  }

  dimension: up_votes_value {
    hidden: yes
    type: number
    sql: ${TABLE}.up_votes ;;
  }

  dimension: down_votes_value {
    hidden: yes
    type: number
    sql: ${TABLE}.down_votes ;;
  }

  dimension: views_value {
    hidden: yes
    type: number
    sql: ${TABLE}.views ;;
  }

  # Measures
  measure: total_reputation {
    type: sum
    label: "Total Reputation"
    description: "Sum of all user reputation"
    sql: COALESCE(${reputation_value}, 0) ;;
    value_format: "#,##0.00"
  }

  measure: total_up_votes {
    type: sum
    label: "Total Up Votes"
    description: "Total number of up votes received"
    sql: COALESCE(${up_votes_value}, 0) ;;
    value_format: "#,##0.00"
  }

  measure: total_down_votes {
    type: sum
    label: "Total Down Votes"
    description: "Total number of down votes received"
    sql: COALESCE(${down_votes_value}, 0) ;;
    value_format: "#,##0.00"
  }

  measure: total_views {
    type: sum
    label: "Total Views"
    description: "Total number of views"
    sql: COALESCE(${views_value}, 0) ;;
    value_format: "#,##0.00"
  }

  measure: count {
    type: count
    label: "Count of Users"
    description: "Total number of users"
    drill_fields: [user_id, display_name, location, creation_date]
  }
}
