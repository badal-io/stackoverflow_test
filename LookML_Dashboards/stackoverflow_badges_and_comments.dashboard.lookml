- dashboard: stackoverflow_badges_and_comments
  title: StackOverflow Badges and Comments
  layout: newspaper
  preferred_viewer: dashboards-next
  description: 'A comprehensive dashboard showing badge and comment statistics from StackOverflow'
  elements:
  # Text tile with dashboard description
  - title: Dashboard Description
    name: Dashboard Description
    type: text
    body_text: |
      <h2>StackOverflow Badges and Comments Analysis</h2>
      <p>This dashboard provides insights into badge distribution and user comments on StackOverflow.
      Explore the total counts, distributions by date, and user engagement metrics using the filters above.</p>
    row: 0
    col: 0
    width: 24
    height: 3

  # Single Value Tiles - Row 1
  - title: Total Badges Awarded
    name: Total Badges Awarded
    model: stackoverflow_test
    explore: stackoverflow_badges_users
    type: single_value
    fields: [stackoverflow_badges.count]
    limit: 500
    column_limit: 50
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    listen:
      Badge Name: stackoverflow_badges.name
      Creation Date: stackoverflow_badges.creation_date
      Location: stackoverflow_users.location
    row: 3
    col: 0
    width: 5
    height: 4

  - title: Total Users with Badges
    name: Total Users with Badges
    model: stackoverflow_test
    explore: stackoverflow_badges_users
    type: single_value
    fields: [stackoverflow_badges.count_users_with_badges]
    limit: 500
    column_limit: 50
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    listen:
      Badge Name: stackoverflow_badges.name
      Creation Date: stackoverflow_badges.creation_date
      Location: stackoverflow_users.location
    row: 3
    col: 5
    width: 5
    height: 4

  - title: Total Comments
    name: Total Comments
    model: stackoverflow_test
    explore: stackoverflow_comments_users
    type: single_value
    fields: [stackoverflow_comments.count]
    limit: 500
    column_limit: 50
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    listen:
      User Display Name: stackoverflow_comments.user_display_name
      Comments Creation Date: stackoverflow_comments.creation_date
      Location: stackoverflow_users.location
    row: 3
    col: 10
    width: 5
    height: 4

  - title: Total Comments Score
    name: Total Comments Score
    model: stackoverflow_test
    explore: stackoverflow_comments_users
    type: single_value
    fields: [stackoverflow_comments.total_score]
    limit: 500
    column_limit: 50
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    listen:
      User Display Name: stackoverflow_comments.user_display_name
      Comments Creation Date: stackoverflow_comments.creation_date
      Location: stackoverflow_users.location
    row: 3
    col: 15
    width: 5
    height: 4

  # Bar/Column Charts - Row 2
  - title: Badges by Badge Name
    name: Badges by Badge Name
    model: stackoverflow_test
    explore: stackoverflow_badges_users
    type: looker_column
    fields: [stackoverflow_badges.name, stackoverflow_badges.count]
    sorts: [stackoverflow_badges.count desc]
    limit: 15
    column_limit: 50
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    x_axis_zoom: false
    y_axis_zoom: false
    series_colors:
      stackoverflow_badges.count: "#2B99F7"
    defaults_version: 1
    value_labels: labels
    label_type: labPer
    hidden_pivots: {}
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    listen:
      Badge Name: stackoverflow_badges.name
      Creation Date: stackoverflow_badges.creation_date
      Location: stackoverflow_users.location
    row: 7
    col: 0
    width: 12
    height: 9

  - title: Comments Over Time
    name: Comments Over Time
    model: stackoverflow_test
    explore: stackoverflow_comments_users
    type: looker_line
    fields: [stackoverflow_comments.creation_month_year, stackoverflow_comments.count]
    fill_fields: [stackoverflow_comments.creation_month_year]
    sorts: [stackoverflow_comments.creation_month_year]
    limit: 500
    column_limit: 50
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    x_axis_zoom: true
    y_axis_zoom: true
    defaults_version: 1
    value_labels: legend
    label_type: labPer
    hidden_pivots: {}
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    listen:
      User Display Name: stackoverflow_comments.user_display_name
      Comments Creation Date: stackoverflow_comments.creation_date
      Location: stackoverflow_users.location
    row: 7
    col: 12
    width: 12
    height: 9

  - title: Top Users by Comments
    name: Top Users by Comments
    model: stackoverflow_test
    explore: stackoverflow_comments_users
    type: looker_bar
    fields: [stackoverflow_comments.user_display_name, stackoverflow_comments.count]
    sorts: [stackoverflow_comments.count desc]
    limit: 10
    column_limit: 50
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    x_axis_zoom: true
    y_axis_zoom: true
    series_colors:
      stackoverflow_comments.count: "#EA4335"
    defaults_version: 1
    value_labels: legend
    label_type: labPer
    hidden_pivots: {}
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    listen:
      User Display Name: stackoverflow_comments.user_display_name
      Comments Creation Date: stackoverflow_comments.creation_date
      Location: stackoverflow_users.location
    row: 16
    col: 0
    width: 12
    height: 9

  - title: Badge Distribution by Class
    name: Badge Distribution by Class
    model: stackoverflow_test
    explore: stackoverflow_badges_users
    type: looker_pie
    fields: [stackoverflow_badges.class, stackoverflow_badges.count]
    sorts: [stackoverflow_badges.count desc]
    limit: 10
    column_limit: 50
    value_labels: labels
    label_type: labPer
    series_colors:
      "1": "#34A853"
      "2": "#FBBC04"
      "3": "#EA4335"
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    hidden_pivots: {}
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    listen:
      Badge Name: stackoverflow_badges.name
      Creation Date: stackoverflow_badges.creation_date
      Location: stackoverflow_users.location
    row: 16
    col: 12
    width: 12
    height: 9

  # Dashboard Filters
  filters:
  - name: Badge Name
    title: Badge Name
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
    model: stackoverflow_test
    explore: stackoverflow_badges_users
    listens_to_filters: []
    field: stackoverflow_badges.name

  - name: Creation Date
    title: Badge Creation Date
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: relative_timeframes
      display: inline
      options: []
    model: stackoverflow_test
    explore: stackoverflow_badges_users
    listens_to_filters: []
    field: stackoverflow_badges.creation_date

  - name: User Display Name
    title: User Display Name
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
    model: stackoverflow_test
    explore: stackoverflow_comments_users
    listens_to_filters: []
    field: stackoverflow_comments.user_display_name

  - name: Comments Creation Date
    title: Comments Creation Date
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: relative_timeframes
      display: inline
      options: []
    model: stackoverflow_test
    explore: stackoverflow_comments_users
    listens_to_filters: []
    field: stackoverflow_comments.creation_date

  - name: Location
    title: User Location
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
    model: stackoverflow_test
    explore: stackoverflow_badges_users
    listens_to_filters: []
    field: stackoverflow_users.location
