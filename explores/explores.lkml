include: "/views/*.view.lkml"

# Explore 1: Badges with Users
explore: stackoverflow_badges_users {
  label: "StackOverflow. Badges with Users"
  view_name: stackoverflow_badges
  view_label: "Badges"
  persist_with: twelve_hour_update

  join: stackoverflow_users {
    type: left_outer
    relationship: many_to_one
    sql_on: ${stackoverflow_badges.user_id} = ${stackoverflow_users.id} ;;
    view_label: "Users"
  }
}

# Explore 2: Comments with Users
explore: stackoverflow_comments_users {
  label: "StackOverflow. Comments with Users"
  view_name: stackoverflow_comments
  view_label: "Comments"
  persist_with: twelve_hour_update

  join: stackoverflow_users {
    type: left_outer
    relationship: many_to_one
    sql_on: ${stackoverflow_comments.user_id} = ${stackoverflow_users.id} ;;
    view_label: "Users"
  }
}

# Single view explores
explore: stackoverflow_users {
  label: "StackOverflow. Users"
  view_label: "Users"
  persist_with: twelve_hour_update
}

explore: stackoverflow_badges {
  label: "StackOverflow. Badges"
  view_label: "Badges"
  persist_with: twelve_hour_update
}

explore: stackoverflow_comments {
  label: "StackOverflow. Comments"
  view_label: "Comments"
  persist_with: twelve_hour_update
}
