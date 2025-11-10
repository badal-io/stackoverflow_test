# Data Test 1: User Display Name Not Null
test: user_display_name_not_null {
  description: "Validates that all users have a non-null display name. This test ensures data quality by checking that the display_name field is populated for every user record."

  explore_source: stackoverflow_users {
    column: display_name {}
    sorts: [stackoverflow_users.display_name: desc]
    limit: 1
  }

  assert: display_name_is_not_null {
    expression: NOT is_null(${stackoverflow_users.display_name}) ;;
  }
}

# Data Test 2: Badge Class Values Validation
test: badges_class_check {
  description: "Validates that all badge class values are 1, 2, or 3. This test ensures badge classification is consistent and within expected values."

  explore_source: stackoverflow_badges {
    column: class {}
    filters: [stackoverflow_badges.class: "-1,-2,-3"]
  }

  assert: class_is_valid {
    expression: ${stackoverflow_badges.class} = 1 OR ${stackoverflow_badges.class} = 2 OR ${stackoverflow_badges.class} = 3 ;;
  }
}
