test: user_display_name_not_null {
  description: "Validates that all user display names are not null. This ensures data integrity and that users have valid display names in the system."
  explore_source: stackoverflow_users {
    column: display_name {
      field: stackoverflow_users.display_name
    }
    sorts: [stackoverflow_users.display_name: desc]
    limit: 1
  }
  assert: display_name_is_not_null {
    expression: NOT is_null(${stackoverflow_users.display_name}) ;;
  }
}

test: badges_class_check {
  description: "Validates that all badge class values are within the expected range (1, 2, or 3). This ensures data quality and consistency for badge classifications."
  explore_source: stackoverflow_badges {
    column: class {
      field: stackoverflow_badges.class
    }
  }
  assert: class_is_valid {
    expression: ${stackoverflow_badges.class} IN (1, 2, 3) ;;
  }
}
