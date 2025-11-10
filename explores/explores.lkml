# Include view files for explores
include: "/views/*.view.lkml"

# ========================================
# Single View Explores
# ========================================

explore: stackoverflow_users {
  label: "StackOverflow Users"
  description: "Explore user data from StackOverflow"
  view_name: stackoverflow_users
  persist_with: twelve_hour_update
}

explore: stackoverflow_badges {
  label: "StackOverflow Badges"
  description: "Explore badge data from StackOverflow"
  view_name: stackoverflow_badges
  persist_with: twelve_hour_update
}

explore: stackoverflow_comments {
  label: "StackOverflow Comments"
  description: "Explore comment data from StackOverflow"
  view_name: stackoverflow_comments
  persist_with: twelve_hour_update
}

# ========================================
# Multi-View Explores with Joins
# ========================================

explore: stackoverflow_badges_users {
  label: "StackOverflow. Badges with Users"
  description: "Explore badges along with user information"
  view_name: stackoverflow_badges
  view_label: "Badges"
  persist_with: twelve_hour_update

  join: stackoverflow_users {
    type: left_outer
    relationship: many_to_one
    view_label: "Users"
    sql_on: ${stackoverflow_badges.user_id} = ${stackoverflow_users.user_id} ;;
  }
}

explore: stackoverflow_comments_users {
  label: "StackOverflow. Comments with Users"
  description: "Explore comments along with user information"
  view_name: stackoverflow_comments
  view_label: "Comments"
  persist_with: twelve_hour_update

  join: stackoverflow_users {
    type: left_outer
    relationship: many_to_one
    view_label: "Users"
    sql_on: ${stackoverflow_comments.user_id} = ${stackoverflow_users.user_id} ;;
  }
}
