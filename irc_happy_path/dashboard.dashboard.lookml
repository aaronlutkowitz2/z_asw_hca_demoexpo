- dashboard: 0__single_tile
  title: 0 - Single Tile
  layout: newspaper
  preferred_viewer: dashboards-next
  description: ''
  preferred_slug: jhr0J3qlXnBAJWcxSCXAkD
  elements:
  - title: "% by Element"
    name: "% by Element"
    model: irc_happy_path
    explore: analytics_view
    type: looker_bar
    fields: [analytics_view.bm_kpi_actual2, analytics_view.compare_values]
    filters: {}
    sorts: [analytics_view.bm_kpi_actual2 desc 0]
    limit: 500
    column_limit: 50
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
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
    y_axes: [{label: '', orientation: left, series: [{axisId: analytics_view.bm_kpi_actual2,
            id: analytics_view.bm_kpi_actual2, name: 1 - Actual}], showLabels: false,
        showValues: true, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    hidden_pivots: {}
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    listen:
      KPI Selector: analytics_view.count_vs_cost_bm2
      Values Selector: analytics_view.compare_selector
      Values Selection: analytics_view.compare_values
      Status: analytics_view.status_param
      3 Division: analytics_view.division_name
      4 Market: analytics_view.market_name
      L2 Service Line: analytics_view.esl_level_2_desc
      L3 DRG Superfamily: analytics_view.esl_level_3_desc
    row: 0
    col: 0
    width: 24
    height: 13
  filters:
  - name: Values Selector
    title: Values Selector
    type: field_filter
    default_value: facility^_name
    allow_multiple_values: true
    required: false
    ui_config:
      type: dropdown_menu
      display: inline
    model: irc_happy_path
    explore: analytics_view
    listens_to_filters: []
    field: analytics_view.compare_selector
  - name: Values Selection
    title: Values Selection
    type: field_filter
    default_value: "^ CENTENNIAL MEDICAL CENTER,^ CORPUS CHRISTI MEDICAL CENTER,^\
      \ MEDICAL CITY DALLAS"
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
    model: irc_happy_path
    explore: analytics_view
    listens_to_filters: [Values Selector]
    field: analytics_view.compare_values
  - name: KPI Selector
    title: KPI Selector
    type: field_filter
    default_value: count
    allow_multiple_values: true
    required: false
    ui_config:
      type: dropdown_menu
      display: inline
    model: irc_happy_path
    explore: analytics_view
    listens_to_filters: []
    field: analytics_view.count_vs_cost_bm2
  - name: Status
    title: Status
    type: field_filter
    default_value: 1s
    allow_multiple_values: true
    required: false
    ui_config:
      type: dropdown_menu
      display: inline
    model: irc_happy_path
    explore: analytics_view
    listens_to_filters: []
    field: analytics_view.status_param
  - name: 3 Division
    title: 3 Division
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
    model: irc_happy_path
    explore: analytics_view
    listens_to_filters: []
    field: analytics_view.division_name
  - name: 4 Market
    title: 4 Market
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
    model: irc_happy_path
    explore: analytics_view
    listens_to_filters: []
    field: analytics_view.market_name
  - name: L2 Service Line
    title: L2 Service Line
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
    model: irc_happy_path
    explore: analytics_view
    listens_to_filters: []
    field: analytics_view.esl_level_2_desc
  - name: L3 DRG Superfamily
    title: L3 DRG Superfamily
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
    model: irc_happy_path
    explore: analytics_view
    listens_to_filters: []
    field: analytics_view.esl_level_3_desc





- dashboard: 1__3_tiles
  title: 1 - 3 Tiles
  layout: newspaper
  preferred_viewer: dashboards-next
  description: ''
  preferred_slug: dOLVttMNX85oeIBg7BlMzX
  elements:
  - title: "% by Element"
    name: "% by Element"
    model: irc_happy_path
    explore: analytics_view
    type: looker_column
    fields: [analytics_view.bm_kpi_actual2, analytics_view.compare_values]
    filters: {}
    sorts: [analytics_view.bm_kpi_actual2 desc 0]
    limit: 500
    column_limit: 50
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
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
    y_axes: [{label: '', orientation: left, series: [{axisId: analytics_view.bm_kpi_actual2,
            id: analytics_view.bm_kpi_actual2, name: 1 - Actual}], showLabels: false,
        showValues: true, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    hidden_pivots: {}
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    listen:
      KPI Selector: analytics_view.count_vs_cost_bm2
      Values Selector: analytics_view.compare_selector
      Values Selection: analytics_view.compare_values
      Status: analytics_view.status_param
      3 Division: analytics_view.division_name
      4 Market: analytics_view.market_name
      L2 Service Line: analytics_view.esl_level_2_desc
      L3 DRG Superfamily: analytics_view.esl_level_3_desc
    row: 0
    col: 0
    width: 7
    height: 10
  - title: All Statuses
    name: All Statuses
    model: irc_happy_path
    explore: analytics_view
    type: looker_column
    fields: [analytics_view.compare_values, analytics_view.status, analytics_view.bm_kpi_actual2_raw]
    pivots: [analytics_view.status]
    filters: {}
    sorts: [analytics_view.status, analytics_view.compare_values]
    limit: 500
    column_limit: 50
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: percent
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
    y_axes: [{label: '', orientation: left, series: [{axisId: analytics_view.bm_kpi_actual2,
            id: analytics_view.bm_kpi_actual2, name: 1 - Actual}], showLabels: false,
        showValues: true, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    hidden_pivots: {}
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    listen:
      KPI Selector: analytics_view.count_vs_cost_bm2
      Values Selector: analytics_view.compare_selector
      Values Selection: analytics_view.compare_values
      Status: analytics_view.status_param
      3 Division: analytics_view.division_name
      4 Market: analytics_view.market_name
      L2 Service Line: analytics_view.esl_level_2_desc
      L3 DRG Superfamily: analytics_view.esl_level_3_desc
    row: 0
    col: 17
    width: 7
    height: 10
  - title: Status over Time
    name: Status over Time
    model: irc_happy_path
    explore: analytics_view
    type: looker_line
    fields: [analytics_view.bm_kpi_actual2, analytics_view.compare_values, analytics_view.admission_quarter]
    pivots: [analytics_view.compare_values]
    fill_fields: [analytics_view.admission_quarter]
    filters: {}
    sorts: [analytics_view.compare_values, analytics_view.admission_quarter]
    limit: 500
    column_limit: 50
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
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
    show_null_points: true
    interpolation: linear
    color_application:
      collection_id: brightview
      palette_id: brightview-categorical-0
      options:
        steps: 5
    y_axes: [{label: '', orientation: left, series: [{axisId: analytics_view.bm_kpi_actual2,
            id: " CENTENNIAL MEDICAL CENTER - analytics_view.bm_kpi_actual2", name: " CENTENNIAL\
              \ MEDICAL CENTER"}, {axisId: analytics_view.bm_kpi_actual2, id: " CORPUS\
              \ CHRISTI MEDICAL CENTER - analytics_view.bm_kpi_actual2", name: " CORPUS\
              \ CHRISTI MEDICAL CENTER"}, {axisId: analytics_view.bm_kpi_actual2,
            id: " MEDICAL CITY DALLAS - analytics_view.bm_kpi_actual2", name: " MEDICAL\
              \ CITY DALLAS"}], showLabels: false, showValues: true, unpinAxis: true,
        tickDensity: default, tickDensityCustom: 5, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    series_colors: {}
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    hidden_pivots: {}
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    listen:
      KPI Selector: analytics_view.count_vs_cost_bm2
      Values Selector: analytics_view.compare_selector
      Values Selection: analytics_view.compare_values
      Status: analytics_view.status_param
      3 Division: analytics_view.division_name
      4 Market: analytics_view.market_name
      L2 Service Line: analytics_view.esl_level_2_desc
      L3 DRG Superfamily: analytics_view.esl_level_3_desc
    row: 0
    col: 7
    width: 10
    height: 10
  filters:
  - name: Values Selector
    title: Values Selector
    type: field_filter
    default_value: facility^_name
    allow_multiple_values: true
    required: false
    ui_config:
      type: dropdown_menu
      display: inline
    model: irc_happy_path
    explore: analytics_view
    listens_to_filters: []
    field: analytics_view.compare_selector
  - name: Values Selection
    title: Values Selection
    type: field_filter
    default_value: "^ CENTENNIAL MEDICAL CENTER,^ CORPUS CHRISTI MEDICAL CENTER,^\
      \ MEDICAL CITY DALLAS"
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
    model: irc_happy_path
    explore: analytics_view
    listens_to_filters: [Values Selector]
    field: analytics_view.compare_values
  - name: KPI Selector
    title: KPI Selector
    type: field_filter
    default_value: count
    allow_multiple_values: true
    required: false
    ui_config:
      type: dropdown_menu
      display: inline
    model: irc_happy_path
    explore: analytics_view
    listens_to_filters: []
    field: analytics_view.count_vs_cost_bm2
  - name: Status
    title: Status
    type: field_filter
    default_value: 1s
    allow_multiple_values: true
    required: false
    ui_config:
      type: dropdown_menu
      display: inline
    model: irc_happy_path
    explore: analytics_view
    listens_to_filters: []
    field: analytics_view.status_param
  - name: 3 Division
    title: 3 Division
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
    model: irc_happy_path
    explore: analytics_view
    listens_to_filters: []
    field: analytics_view.division_name
  - name: 4 Market
    title: 4 Market
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
    model: irc_happy_path
    explore: analytics_view
    listens_to_filters: []
    field: analytics_view.market_name
  - name: L2 Service Line
    title: L2 Service Line
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
    model: irc_happy_path
    explore: analytics_view
    listens_to_filters: []
    field: analytics_view.esl_level_2_desc
  - name: L3 DRG Superfamily
    title: L3 DRG Superfamily
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
    model: irc_happy_path
    explore: analytics_view
    listens_to_filters: []
    field: analytics_view.esl_level_3_desc






- dashboard: 2__status_exercise
  title: 2 - Status Exercise
  layout: newspaper
  preferred_viewer: dashboards-next
  description: ''
  preferred_slug: VpLRTl0EDGGCawrZBaFEC8
  elements:
  - title: "% by Element"
    name: "% by Element"
    model: irc_happy_path
    explore: analytics_view
    type: looker_column
    fields: [analytics_view.bm_kpi_actual2, analytics_view.compare_values]
    filters: {}
    sorts: [analytics_view.bm_kpi_actual2 desc 0]
    limit: 500
    column_limit: 50
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
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
    y_axes: [{label: '', orientation: left, series: [{axisId: analytics_view.bm_kpi_actual2,
            id: analytics_view.bm_kpi_actual2, name: 1 - Actual}], showLabels: false,
        showValues: true, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    hidden_pivots: {}
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    listen:
      KPI Selector: analytics_view.count_vs_cost_bm2
      Values Selector: analytics_view.compare_selector
      Values Selection: analytics_view.compare_values
      Status: analytics_view.status_param
      3 Division: analytics_view.division_name
      4 Market: analytics_view.market_name
      L2 Service Line: analytics_view.esl_level_2_desc
      L3 DRG Superfamily: analytics_view.esl_level_3_desc
    row: 5
    col: 0
    width: 7
    height: 10
  - title: All Statuses
    name: All Statuses
    model: irc_happy_path
    explore: analytics_view
    type: looker_column
    fields: [analytics_view.compare_values, analytics_view.status, analytics_view.bm_kpi_actual2_raw]
    pivots: [analytics_view.status]
    filters: {}
    sorts: [analytics_view.status, analytics_view.compare_values]
    limit: 500
    column_limit: 50
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: percent
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
    y_axes: [{label: '', orientation: left, series: [{axisId: analytics_view.bm_kpi_actual2,
            id: analytics_view.bm_kpi_actual2, name: 1 - Actual}], showLabels: false,
        showValues: true, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    hidden_pivots: {}
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    listen:
      KPI Selector: analytics_view.count_vs_cost_bm2
      Values Selector: analytics_view.compare_selector
      Values Selection: analytics_view.compare_values
      Status: analytics_view.status_param
      3 Division: analytics_view.division_name
      4 Market: analytics_view.market_name
      L2 Service Line: analytics_view.esl_level_2_desc
      L3 DRG Superfamily: analytics_view.esl_level_3_desc
    row: 5
    col: 17
    width: 7
    height: 10
  - title: Status over Time
    name: Status over Time
    model: irc_happy_path
    explore: analytics_view
    type: looker_line
    fields: [analytics_view.bm_kpi_actual2, analytics_view.compare_values, analytics_view.admission_quarter]
    pivots: [analytics_view.compare_values]
    fill_fields: [analytics_view.admission_quarter]
    filters: {}
    sorts: [analytics_view.compare_values, analytics_view.admission_quarter]
    limit: 500
    column_limit: 50
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
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
    show_null_points: true
    interpolation: linear
    color_application:
      collection_id: brightview
      palette_id: brightview-categorical-0
      options:
        steps: 5
    y_axes: [{label: '', orientation: left, series: [{axisId: analytics_view.bm_kpi_actual2,
            id: " CENTENNIAL MEDICAL CENTER - analytics_view.bm_kpi_actual2", name: " CENTENNIAL\
              \ MEDICAL CENTER"}, {axisId: analytics_view.bm_kpi_actual2, id: " CORPUS\
              \ CHRISTI MEDICAL CENTER - analytics_view.bm_kpi_actual2", name: " CORPUS\
              \ CHRISTI MEDICAL CENTER"}, {axisId: analytics_view.bm_kpi_actual2,
            id: " MEDICAL CITY DALLAS - analytics_view.bm_kpi_actual2", name: " MEDICAL\
              \ CITY DALLAS"}], showLabels: false, showValues: true, unpinAxis: true,
        tickDensity: default, tickDensityCustom: 5, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    series_colors: {}
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    hidden_pivots: {}
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    listen:
      KPI Selector: analytics_view.count_vs_cost_bm2
      Values Selector: analytics_view.compare_selector
      Values Selection: analytics_view.compare_values
      Status: analytics_view.status_param
      3 Division: analytics_view.division_name
      4 Market: analytics_view.market_name
      L2 Service Line: analytics_view.esl_level_2_desc
      L3 DRG Superfamily: analytics_view.esl_level_3_desc
    row: 5
    col: 7
    width: 10
    height: 10
  - title: Total $s
    name: Total $s
    model: irc_happy_path
    explore: analytics_view
    type: single_value
    fields: [analytics_view.sum_owed]
    filters: {}
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
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
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
    y_axes: [{label: '', orientation: left, series: [{axisId: analytics_view.bm_kpi_actual2,
            id: analytics_view.bm_kpi_actual2, name: 1 - Actual}], showLabels: false,
        showValues: true, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    hidden_pivots: {}
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    defaults_version: 1
    listen:
      KPI Selector: analytics_view.count_vs_cost_bm2
      Values Selector: analytics_view.compare_selector
      Values Selection: analytics_view.compare_values
      Status: analytics_view.status_param
      3 Division: analytics_view.division_name
      4 Market: analytics_view.market_name
      L2 Service Line: analytics_view.esl_level_2_desc
      L3 DRG Superfamily: analytics_view.esl_level_3_desc
    row: 0
    col: 4
    width: 4
    height: 5
  - title: "# Encounters"
    name: "# Encounters"
    model: irc_happy_path
    explore: analytics_view
    type: single_value
    fields: [analytics_view.count]
    filters: {}
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
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
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
    y_axes: [{label: '', orientation: left, series: [{axisId: analytics_view.bm_kpi_actual2,
            id: analytics_view.bm_kpi_actual2, name: 1 - Actual}], showLabels: false,
        showValues: true, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    hidden_pivots: {}
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    defaults_version: 1
    listen:
      KPI Selector: analytics_view.count_vs_cost_bm2
      Values Selector: analytics_view.compare_selector
      Values Selection: analytics_view.compare_values
      Status: analytics_view.status_param
      3 Division: analytics_view.division_name
      4 Market: analytics_view.market_name
      L2 Service Line: analytics_view.esl_level_2_desc
      L3 DRG Superfamily: analytics_view.esl_level_3_desc
    row: 0
    col: 0
    width: 4
    height: 5
  - title: "# Encounters by Status"
    name: "# Encounters by Status"
    model: irc_happy_path
    explore: analytics_view
    type: looker_bar
    fields: [analytics_view.count, analytics_view.status]
    pivots: [analytics_view.status]
    filters: {}
    sorts: [analytics_view.status]
    limit: 500
    column_limit: 50
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: percent
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
    y_axes: [{label: '', orientation: left, series: [{axisId: analytics_view.bm_kpi_actual2,
            id: analytics_view.bm_kpi_actual2, name: 1 - Actual}], showLabels: false,
        showValues: true, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    hidden_pivots: {}
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    listen:
      KPI Selector: analytics_view.count_vs_cost_bm2
      Values Selector: analytics_view.compare_selector
      Values Selection: analytics_view.compare_values
      Status: analytics_view.status_param
      3 Division: analytics_view.division_name
      4 Market: analytics_view.market_name
      L2 Service Line: analytics_view.esl_level_2_desc
      L3 DRG Superfamily: analytics_view.esl_level_3_desc
    row: 0
    col: 8
    width: 16
    height: 5
  filters:
  - name: Values Selector
    title: Values Selector
    type: field_filter
    default_value: facility^_name
    allow_multiple_values: true
    required: false
    ui_config:
      type: dropdown_menu
      display: inline
    model: irc_happy_path
    explore: analytics_view
    listens_to_filters: []
    field: analytics_view.compare_selector
  - name: Values Selection
    title: Values Selection
    type: field_filter
    default_value: "^ CENTENNIAL MEDICAL CENTER,^ CORPUS CHRISTI MEDICAL CENTER,^\
      \ MEDICAL CITY DALLAS"
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
    model: irc_happy_path
    explore: analytics_view
    listens_to_filters: [Values Selector]
    field: analytics_view.compare_values
  - name: KPI Selector
    title: KPI Selector
    type: field_filter
    default_value: count
    allow_multiple_values: true
    required: false
    ui_config:
      type: dropdown_menu
      display: inline
    model: irc_happy_path
    explore: analytics_view
    listens_to_filters: []
    field: analytics_view.count_vs_cost_bm2
  - name: Status
    title: Status
    type: field_filter
    default_value: 1s
    allow_multiple_values: true
    required: false
    ui_config:
      type: dropdown_menu
      display: inline
    model: irc_happy_path
    explore: analytics_view
    listens_to_filters: []
    field: analytics_view.status_param
  - name: 3 Division
    title: 3 Division
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
    model: irc_happy_path
    explore: analytics_view
    listens_to_filters: []
    field: analytics_view.division_name
  - name: 4 Market
    title: 4 Market
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
    model: irc_happy_path
    explore: analytics_view
    listens_to_filters: []
    field: analytics_view.market_name
  - name: L2 Service Line
    title: L2 Service Line
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
    model: irc_happy_path
    explore: analytics_view
    listens_to_filters: []
    field: analytics_view.esl_level_2_desc
  - name: L3 DRG Superfamily
    title: L3 DRG Superfamily
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
    model: irc_happy_path
    explore: analytics_view
    listens_to_filters: []
    field: analytics_view.esl_level_3_desc
