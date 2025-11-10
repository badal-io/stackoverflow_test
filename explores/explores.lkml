include: "/views/*.view.lkml"

# Explore 1: Badges with Users
explore: stackoverflow_badges_users {
  label: "StackOverflow. Badges with Users"
  description: "Explore badges data joined with user information"
  view_name: stackoverflow_badges
  view_label: "Badges"
  persist_with: twelve_hour_update

  join: stackoverflow_users {
    type: left_outer
    relationship: many_to_one
    view_label: "Users"
    sql_on: ${stackoverflow_badges.user_id} = ${stackoverflow_users.id} ;;
  }
}

# Explore 2: Comments with Users
explore: stackoverflow_comments_users {
  label: "StackOverflow. Comments with Users"
  description: "Explore comments data joined with user information"
  view_name: stackoverflow_comments
  view_label: "Comments"
  persist_with: twelve_hour_update

  join: stackoverflow_users {
    type: left_outer
    relationship: many_to_one
    view_label: "Users"
    sql_on: ${stackoverflow_comments.user_id} = ${stackoverflow_users.id} ;;
  }
}

# Explore 3: Badges (single view)
explore: stackoverflow_badges {
  label: "StackOverflow. Badges"
  description: "Explore badges data"
  view_label: "Badges"
  persist_with: twelve_hour_update
}

# Explore 4: Comments (single view)
explore: stackoverflow_comments {
  label: "StackOverflow. Comments"
  description: "Explore comments data"
  view_label: "Comments"
  persist_with: twelve_hour_update
}

# Explore 5: Users (single view)
explore: stackoverflow_users {
  label: "StackOverflow. Users"
  description: "Explore users data"
  view_label: "Users"
  persist_with: twelve_hour_update
}
