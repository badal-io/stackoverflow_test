- dashboard: stackoverflow_badges_and_comments
  title: StackOverflow Badges and Comments
  layout: newspaper
  preferred_viewer: dashboards-next
  description: Comprehensive dashboard showing general information from StackOverflow badges and comments
  elements:
  - title: Dashboard Description
    name: Dashboard Description
    type: text
    body: '<div style="font-size: 14px; padding: 10px; background-color: #f0f0f0; border-radius: 4px;">
      <p><strong>StackOverflow Badges and Comments Dashboard</strong></p>
      <p>This dashboard provides a comprehensive view of StackOverflow badges and comments across users.
      Explore badge distributions by class, analyze user comment activity, and track overall engagement metrics.</p>
      </div>'
    row: 0
    col: 0
    width: 24
    height: 3
  - title: Total Badges
    name: Total Badges
    model: stackoverflow_test
    explore: stackoverflow_badges_users
    type: single_value
    fields: [stackoverflow_badges_users.count]
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
    defaults_version: 1
    listen:
      Badge Name: stackoverflow_badges.name
      User Display Name: stackoverflow_users.display_name
    row: 3
    col: 0
    width: 6
    height: 4
  - title: Total Comments
    name: Total Comments
    model: stackoverflow_test
    explore: stackoverflow_comments_users
    type: single_value
    fields: [stackoverflow_comments_users.count]
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
    defaults_version: 1
    listen:
      User Display Name: stackoverflow_users.display_name
    row: 3
    col: 6
    width: 6
    height: 4
  - title: Total Users with Badges
    name: Total Users with Badges
    model: stackoverflow_test
    explore: stackoverflow_badges_users
    type: single_value
    fields: [stackoverflow_users.count]
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
    defaults_version: 1
    listen:
      Badge Name: stackoverflow_badges.name
      User Display Name: stackoverflow_users.display_name
    row: 3
    col: 12
    width: 6
    height: 4
  - title: Total Users with Comments
    name: Total Users with Comments
    model: stackoverflow_test
    explore: stackoverflow_comments_users
    type: single_value
    fields: [stackoverflow_users.count]
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
    defaults_version: 1
    listen:
      User Display Name: stackoverflow_users.display_name
    row: 3
    col: 18
    width: 6
    height: 4
  - title: Total Users by Badge Class
    name: Total Users by Badge Class
    model: stackoverflow_test
    explore: stackoverflow_badges_users
    type: looker_bar
    fields: [stackoverflow_badges.class, stackoverflow_badges_users.count]
    sorts: [stackoverflow_badges_users.count desc]
    limit: 25
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
    defaults_version: 1
    value_labels: legend
    label_type: labPer
    hidden_pivots: {}
    series_colors:
      stackoverflow_badges_users.count: "#2B99F7"
    listen:
      Badge Name: stackoverflow_badges.name
      User Display Name: stackoverflow_users.display_name
    row: 7
    col: 0
    width: 12
    height: 8
  - title: Top 25 Users by Comment Count
    name: Top 25 Users by Comment Count
    model: stackoverflow_test
    explore: stackoverflow_comments_users
    type: looker_column
    fields: [stackoverflow_users.display_name, stackoverflow_comments_users.count]
    sorts: [stackoverflow_comments_users.count desc]
    limit: 25
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
    defaults_version: 1
    value_labels: legend
    label_type: labPer
    hidden_pivots: {}
    series_colors:
      stackoverflow_comments_users.count: "#2B99F7"
    listen:
      User Display Name: stackoverflow_users.display_name
    row: 7
    col: 12
    width: 12
    height: 8
  - title: Comment Details Report
    name: Comment Details Report
    model: stackoverflow_test
    explore: stackoverflow_comments_users
    type: table
    fields: [stackoverflow_comments.id, stackoverflow_comments.post_id, stackoverflow_users.id,
      stackoverflow_users.display_name, stackoverflow_comments.score]
    sorts: [stackoverflow_comments.id desc]
    limit: 25
    column_limit: 50
    show_view_names: false
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
    defaults_version: 1
    hidden_pivots: {}
    listen:
      User Display Name: stackoverflow_users.display_name
    row: 15
    col: 0
    width: 24
    height: 8
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
    field: stackoverflow_users.display_name
