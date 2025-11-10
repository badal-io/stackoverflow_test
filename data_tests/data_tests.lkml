# Data Tests for StackOverflow Project
# These tests ensure data quality and consistency across views

# Data Test 1: User Display Name Not Null
# This test verifies that all users have a display name (no null values)
test: user_display_name_not_null {
  explore_source: stackoverflow_users {
    column: display_name {}
    sorts: [stackoverflow_users.display_name: desc]
    limit: 1
  }
  assert: display_name_is_not_null {
    expression: NOT is_null(${stackoverflow_users.display_name}) ;;
  }
}

# Data Test 2: Badges Class Check
# This test verifies that all badge class values are valid (1, 2, or 3)
# Badge classes represent: 1 = Gold, 2 = Silver, 3 = Bronze
test: badges_class_check {
  explore_source: stackoverflow_badges {
    column: class {}
  }
  assert: class_is_valid {
    expression: ${stackoverflow_badges.class} IN (1, 2, 3) ;;
  }
}
