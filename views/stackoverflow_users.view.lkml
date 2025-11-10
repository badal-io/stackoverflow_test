view: stackoverflow_users {
  sql_table_name: `@{stackoverflow_users_table}` ;;

  dimension: id {
    primary_key: yes
    hidden: yes
    type: number
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
    description: "User's about me information"
    sql: ${TABLE}.about_me ;;
  }

  dimension: age {
    type: string
    label: "Age"
    description: "User's age"
    sql: ${TABLE}.age ;;
  }

  dimension: location {
    type: string
    label: "Location"
    description: "User's location"
    sql: ${TABLE}.location ;;
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

  dimension: reputation_hidden {
    hidden: yes
    type: number
    sql: COALESCE(${TABLE}.reputation, 0) ;;
  }

  dimension: up_votes_hidden {
    hidden: yes
    type: number
    sql: COALESCE(${TABLE}.up_votes, 0) ;;
  }

  dimension: down_votes_hidden {
    hidden: yes
    type: number
    sql: COALESCE(${TABLE}.down_votes, 0) ;;
  }

  dimension: views_hidden {
    hidden: yes
    type: number
    sql: COALESCE(${TABLE}.views, 0) ;;
  }

  measure: reputation {
    type: sum
    label: "Reputation"
    description: "Total reputation"
    sql: ${reputation_hidden} ;;
    value_format: "#,##0.00"
  }

  measure: up_votes {
    type: sum
    label: "Up Votes"
    description: "Total up votes"
    sql: ${up_votes_hidden} ;;
    value_format: "#,##0.00"
  }

  measure: down_votes {
    type: sum
    label: "Down Votes"
    description: "Total down votes"
    sql: ${down_votes_hidden} ;;
    value_format: "#,##0.00"
  }

  measure: views {
    type: sum
    label: "Views"
    description: "Total views"
    sql: ${views_hidden} ;;
    value_format: "#,##0.00"
  }

  measure: count {
    type: count
    label: "Count"
    description: "Number of users"
  }
}
