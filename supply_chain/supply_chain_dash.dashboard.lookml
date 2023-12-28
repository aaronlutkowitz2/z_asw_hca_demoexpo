---
- dashboard: supply_chain
  title: Supply Chain
  layout: newspaper
  preferred_viewer: dashboards-next
  description: ''
  preferred_slug: aTrGH8Xmqebui3Dug3zWUp
  elements:
  - title: Req, Used, Diff
    name: Req, Used, Diff
    model: supply_chain_qoh
    explore: qoh
    type: looker_line
    fields: [qoh.reporting_month, qoh.total_avg_req, qoh.total_avg_used, qoh.total_avg_req_min_used,
      qoh.total_avg_inv, qoh.total_avg_since_last_inv_change, qoh.total_avg_inv_actual,
      qoh.avg_est_prior_month, qoh.avg_error, qoh.avg_abs_error, qoh.perc_error]
    fill_fields: [qoh.reporting_month]
    filters: {}
    sorts: [qoh.reporting_month]
    limit: 500
    column_limit: 50
    total: true
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
    point_style: circle
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    color_application:
      collection_id: google
      palette_id: google-categorical-0
      options:
        steps: 5
    x_axis_zoom: true
    y_axis_zoom: true
    hidden_series: [qoh_vs_actual.count, qoh_vs_actual.count_inv_changes, qoh.avg_abs_error,
      qoh.total_req_min_used, qoh.avg_error, qoh.perc_error, qoh.count, qoh.total_avg_inv,
      qoh.total_avg_since_last_inv_change, qoh.total_req, qoh.total_avg_inv_actual,
      qoh.avg_est_prior_month]
    series_colors: {}
    defaults_version: 1
    hidden_pivots: {}
    listen:
      Req Type: qoh.req_type
      Has Item been Accurate in the Past? (Yes / No): item_filter.is_item_not_null
    row: 3
    col: 0
    width: 12
    height: 10
  - name: ''
    type: text
    title_text: ''
    subtitle_text: ''
    body_text: '[{"type":"h1","children":[{"text":"Overall Results - Req, Used"}],"align":"center"},{"type":"ul","children":[{"type":"li","children":[{"type":"lic","children":[{"text":"Req
      (blue) & Used (red) closely follow each other, except for Jan 23"}],"id":1703698398635}],"id":1703698400595},{"type":"li","children":[{"type":"lic","children":[{"text":"The
      difference between req & used (yellow) is close to 0"}],"id":1703698421572}],"id":1703698421572}],"id":1703698400592}]'
    rich_content_json: '{"format":"slate"}'
    row: 0
    col: 0
    width: 12
    height: 3
  - name: " (Copy)"
    type: text
    title_text: " (Copy)"
    subtitle_text: ''
    body_text: '[{"type":"h1","children":[{"text":"Overall Results - Inv Actual vs
      Est"}],"align":"center"},{"type":"ul","children":[{"type":"li","children":[{"type":"lic","children":[{"text":"Actual
      inv (blue) is relatively close to estimated inventory (QOH) (grey) "}],"id":1703698398635}],"id":1703698400595},{"type":"li","children":[{"type":"lic","children":[{"text":"This
      estimate is based on taking the latest available inventory + req - used"}],"id":1703698421572}],"id":1703698421572},{"type":"li","children":[{"type":"lic","children":[{"text":"Note:
      this is "},{"text":"only","underline":true},{"text":" looking at data points
      where inventory changed from the month prior (b/c those are the only months
      where we trust the inventory #s) — that''s why these 2 KPIs are the "},{"text":"known","underline":true},{"text":"
      actual & estimated inventory (vs. 4b Avg & 5b Avg QOH, which measure all months,
      regardless of how stale the inventory # has been)"}],"id":1703701182078}],"id":1703701182078}],"id":1703698400592}]'
    rich_content_json: '{"format":"slate"}'
    row: 0
    col: 12
    width: 12
    height: 3
  - title: Inv Estimate vs Actual
    name: Inv Estimate vs Actual
    model: supply_chain_qoh
    explore: qoh
    type: looker_line
    fields: [qoh.reporting_month, qoh.total_avg_req, qoh.total_avg_used, qoh.total_avg_req_min_used,
      qoh.total_avg_inv, qoh.total_avg_since_last_inv_change, qoh.total_avg_inv_actual,
      qoh.avg_est_prior_month, qoh.avg_error, qoh.avg_abs_error, qoh.perc_error]
    fill_fields: [qoh.reporting_month]
    filters: {}
    sorts: [qoh.reporting_month]
    limit: 500
    column_limit: 50
    total: true
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
    point_style: circle
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    color_application:
      collection_id: google
      palette_id: google-categorical-0
      options:
        steps: 5
    x_axis_zoom: true
    y_axis_zoom: true
    hidden_series: [qoh_vs_actual.count, qoh_vs_actual.count_inv_changes, qoh.avg_abs_error,
      qoh.total_req_min_used, qoh.avg_error, qoh.perc_error, qoh.count, qoh.total_req,
      qoh.total_avg_req_min_used, qoh.total_avg_used, qoh.total_avg_req, qoh.total_avg_inv,
      qoh.total_avg_since_last_inv_change]
    series_colors: {}
    defaults_version: 1
    hidden_pivots: {}
    listen:
      Req Type: qoh.req_type
      Has Item been Accurate in the Past? (Yes / No): item_filter.is_item_not_null
    row: 3
    col: 12
    width: 12
    height: 10
  - title: Example
    name: Example
    model: supply_chain_qoh
    explore: qoh
    type: looker_grid
    fields: [qoh.reporting_month, qoh.coid_fac_dept_par_id, qoh.coid, qoh.facility_item_desc_short,
      qoh.facility_item_desc, qoh.facility_name, qoh.dept_num, qoh.par_class_code,
      qoh.total_req, qoh.total_used, qoh.total_req_min_used, qoh.total_inv, qoh.total_qoh_since_last_inv_change,
      qoh.total_est_prior_month, qoh.avg_error, qoh.perc_error]
    filters:
      qoh.coid_fac_dept_par_id: '1239'
    sorts: [qoh.reporting_month]
    limit: 500
    column_limit: 50
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: true
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    truncate_header: false
    minimum_column_width: 75
    series_cell_visualizations:
      qoh.total_req:
        is_active: false
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: "#4285F4",
        font_color: !!null '', color_application: {collection_id: google, custom: {
            id: 698f98c0-bf1e-f7de-a6d8-46e015235219, label: Custom, type: continuous,
            stops: [{color: "#B31412", offset: 0}, {color: yellow, offset: 25}, {
                color: green, offset: 50}, {color: yellow, offset: 75}, {color: "#B31412",
                offset: 100}]}, options: {steps: 5, constraints: {min: {type: number,
                value: -0.5}, mid: {type: number, value: 0}, max: {type: number, value: 0.5}},
            mirror: false, reverse: false, stepped: false}}, bold: false, italic: false,
        strikethrough: false, fields: [qoh.perc_error]}, {type: along a scale...,
        value: !!null '', background_color: "#4285F4", font_color: !!null '', color_application: {
          collection_id: google, palette_id: google-diverging-0, options: {constraints: {
              min: {type: minimum}, mid: {type: number, value: 0}, max: {type: maximum}},
            mirror: true, reverse: false, stepped: false}}, bold: false, italic: false,
        strikethrough: false, fields: [qoh.total_req_min_used, qoh.total_req, qoh.total_used]},
      {type: along a scale..., value: !!null '', background_color: "#4285F4", font_color: !!null '',
        color_application: {collection_id: google, custom: {id: 626e7d54-6eb5-b33f-8204-e31d73157d3f,
            label: Custom, type: continuous, stops: [{color: "#ffffff", offset: 0},
              {color: purple, offset: 100}]}, options: {steps: 5, constraints: {min: {
                type: minimum}, mid: {type: number, value: 0}, max: {type: maximum}},
            mirror: true, reverse: false, stepped: false}}, bold: false, italic: false,
        strikethrough: false, fields: [qoh.total_inv, qoh.total_qoh_since_last_inv_change]}]
    x_axis_gridlines: false
    y_axis_gridlines: true
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
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    hidden_pivots: {}
    defaults_version: 1
    hidden_series: [qoh.total_avg_req_min_used, qoh.total_req_min_used, qoh.total_req,
      qoh.total_used, qoh.total_inv, qoh.total_qoh_since_last_inv_change, qoh.avg_est_prior_month]
    hidden_fields: [qoh.facility_name, qoh.dept_num, qoh.par_class_code, qoh.coid_fac_dept_par_id,
      qoh.facility_item_desc]
    listen:
      Req Type: qoh.req_type
    row: 31
    col: 5
    width: 11
    height: 9
  - name: " (Copy 2)"
    type: text
    title_text: " (Copy 2)"
    subtitle_text: ''
    body_text: '[{"type":"h1","children":[{"text":"Example - Sudden Jumps in Inv"}],"align":"center"},{"type":"ul","children":[{"type":"li","children":[{"type":"lic","children":[{"text":"QOH
      follows total inv closely until the last 3 months — a sudden drop to 0 in Oct
      23, then a sudden jump to 96 in Nov 23"}],"id":1703698421572}],"id":1703698400595},{"type":"li","children":[{"type":"lic","id":1703699114009,"children":[{"text":"Neither
      of these jumps are suggested based on the req & used #s"}]}],"id":1703699114012}],"id":1703698400592}]'
    rich_content_json: '{"format":"slate"}'
    row: 31
    col: 0
    width: 5
    height: 9
  - name: " (Copy 3)"
    type: text
    title_text: " (Copy 3)"
    subtitle_text: ''
    body_text: '[{"type":"h1","children":[{"text":"Example - Req''s not Meeting Use"}],"align":"center"},{"type":"ul","children":[{"type":"li","children":[{"type":"lic","id":1703699114009,"children":[{"text":"In
      July 21 there''s a sudden jump to 588 (not suggested in req or used) "}]}],"id":1703698400595},{"type":"li","children":[{"type":"lic","children":[{"text":"In
      Aug 21 it''s back down to 252, again, not suggested in the data"}],"id":1703699248067}],"id":1703699248067},{"type":"li","children":[{"type":"lic","children":[{"text":"In
      the year prior to Sept 23, there''s way more usage than req, suggesting a massive
      shortage. In Sept 23, turns out there was not a shortage"}],"id":1703699275862}],"id":1703699275862}],"id":1703698400592}]'
    rich_content_json: '{"format":"slate"}'
    row: 40
    col: 0
    width: 5
    height: 9
  - title: Example
    name: Example (2)
    model: supply_chain_qoh
    explore: qoh
    type: looker_grid
    fields: [qoh.reporting_month, qoh.coid_fac_dept_par_id, qoh.coid, qoh.facility_item_desc_short,
      qoh.facility_item_desc, qoh.facility_name, qoh.dept_num, qoh.par_class_code,
      qoh.total_req, qoh.total_used, qoh.total_req_min_used, qoh.total_inv, qoh.total_qoh_since_last_inv_change,
      qoh.total_est_prior_month, qoh.avg_error, qoh.perc_error]
    filters:
      qoh.coid_fac_dept_par_id: '60671'
    sorts: [qoh.reporting_month]
    limit: 500
    column_limit: 50
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: true
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    truncate_header: false
    minimum_column_width: 75
    series_cell_visualizations:
      qoh.total_req:
        is_active: false
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: "#4285F4",
        font_color: !!null '', color_application: {collection_id: google, custom: {
            id: 698f98c0-bf1e-f7de-a6d8-46e015235219, label: Custom, type: continuous,
            stops: [{color: "#B31412", offset: 0}, {color: yellow, offset: 25}, {
                color: green, offset: 50}, {color: yellow, offset: 75}, {color: "#B31412",
                offset: 100}]}, options: {steps: 5, constraints: {min: {type: number,
                value: -0.5}, mid: {type: number, value: 0}, max: {type: number, value: 0.5}},
            mirror: false, reverse: false, stepped: false}}, bold: false, italic: false,
        strikethrough: false, fields: [qoh.perc_error]}, {type: along a scale...,
        value: !!null '', background_color: "#4285F4", font_color: !!null '', color_application: {
          collection_id: google, palette_id: google-diverging-0, options: {constraints: {
              min: {type: minimum}, mid: {type: number, value: 0}, max: {type: maximum}},
            mirror: true, reverse: false, stepped: false}}, bold: false, italic: false,
        strikethrough: false, fields: [qoh.total_req_min_used, qoh.total_req, qoh.total_used]},
      {type: along a scale..., value: !!null '', background_color: "#4285F4", font_color: !!null '',
        color_application: {collection_id: google, custom: {id: 626e7d54-6eb5-b33f-8204-e31d73157d3f,
            label: Custom, type: continuous, stops: [{color: "#ffffff", offset: 0},
              {color: purple, offset: 100}]}, options: {steps: 5, constraints: {min: {
                type: minimum}, mid: {type: number, value: 0}, max: {type: maximum}},
            mirror: true, reverse: false, stepped: false}}, bold: false, italic: false,
        strikethrough: false, fields: [qoh.total_inv, qoh.total_qoh_since_last_inv_change]}]
    x_axis_gridlines: false
    y_axis_gridlines: true
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
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    hidden_pivots: {}
    defaults_version: 1
    hidden_series: [qoh.total_avg_req_min_used, qoh.total_req_min_used, qoh.total_req,
      qoh.total_used, qoh.total_inv, qoh.total_qoh_since_last_inv_change, qoh.avg_est_prior_month]
    hidden_fields: [qoh.facility_name, qoh.dept_num, qoh.par_class_code, qoh.coid_fac_dept_par_id,
      qoh.facility_item_desc]
    listen:
      Req Type: qoh.req_type
    row: 40
    col: 5
    width: 11
    height: 9
  - name: " (Copy 4)"
    type: text
    title_text: " (Copy 4)"
    subtitle_text: ''
    body_text: '[{"type":"h1","children":[{"text":"Example - Works Correctly"}],"align":"center"},{"type":"ul","children":[{"type":"li","children":[{"type":"lic","id":1703699114009,"children":[{"text":"Inventory
      starts at 10 in Jan 21"}]}],"id":1703698400595},{"type":"li","children":[{"type":"lic","children":[{"text":"Over
      the course of 2 years, changes in req vs usage suggests all 10 units were depleted
      "}],"id":1703699661068}],"id":1703699661068},{"type":"li","children":[{"type":"lic","children":[{"text":"Dec
      22, the new inventory is 0, exactly what we''re expecting"}],"id":1703699687129}],"id":1703699687129}],"id":1703698400592}]'
    rich_content_json: '{"format":"slate"}'
    row: 22
    col: 0
    width: 5
    height: 9
  - title: Example
    name: Example (3)
    model: supply_chain_qoh
    explore: qoh
    type: looker_grid
    fields: [qoh.reporting_month, qoh.coid_fac_dept_par_id, qoh.coid, qoh.facility_item_desc_short,
      qoh.facility_item_desc, qoh.facility_name, qoh.dept_num, qoh.par_class_code,
      qoh.total_req, qoh.total_used, qoh.total_req_min_used, qoh.total_inv, qoh.total_qoh_since_last_inv_change,
      qoh.total_est_prior_month, qoh.avg_error, qoh.perc_error]
    filters:
      qoh.coid_fac_dept_par_id: '25869'
    sorts: [qoh.reporting_month]
    limit: 500
    column_limit: 50
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: true
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    truncate_header: false
    minimum_column_width: 75
    series_cell_visualizations:
      qoh.total_req:
        is_active: false
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: "#4285F4",
        font_color: !!null '', color_application: {collection_id: google, custom: {
            id: 698f98c0-bf1e-f7de-a6d8-46e015235219, label: Custom, type: continuous,
            stops: [{color: "#B31412", offset: 0}, {color: yellow, offset: 25}, {
                color: green, offset: 50}, {color: yellow, offset: 75}, {color: "#B31412",
                offset: 100}]}, options: {steps: 5, constraints: {min: {type: number,
                value: -0.5}, mid: {type: number, value: 0}, max: {type: number, value: 0.5}},
            mirror: false, reverse: false, stepped: false}}, bold: false, italic: false,
        strikethrough: false, fields: [qoh.perc_error]}, {type: along a scale...,
        value: !!null '', background_color: "#4285F4", font_color: !!null '', color_application: {
          collection_id: google, palette_id: google-diverging-0, options: {constraints: {
              min: {type: minimum}, mid: {type: number, value: 0}, max: {type: maximum}},
            mirror: true, reverse: false, stepped: false}}, bold: false, italic: false,
        strikethrough: false, fields: [qoh.total_req_min_used, qoh.total_req, qoh.total_used]},
      {type: along a scale..., value: !!null '', background_color: "#4285F4", font_color: !!null '',
        color_application: {collection_id: google, custom: {id: 626e7d54-6eb5-b33f-8204-e31d73157d3f,
            label: Custom, type: continuous, stops: [{color: "#ffffff", offset: 0},
              {color: purple, offset: 100}]}, options: {steps: 5, constraints: {min: {
                type: minimum}, mid: {type: number, value: 0}, max: {type: maximum}},
            mirror: true, reverse: false, stepped: false}}, bold: false, italic: false,
        strikethrough: false, fields: [qoh.total_inv, qoh.total_qoh_since_last_inv_change]}]
    x_axis_gridlines: false
    y_axis_gridlines: true
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
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    hidden_pivots: {}
    defaults_version: 1
    hidden_series: [qoh.total_avg_req_min_used, qoh.total_req_min_used, qoh.total_req,
      qoh.total_used, qoh.total_inv, qoh.total_qoh_since_last_inv_change, qoh.avg_est_prior_month]
    hidden_fields: [qoh.facility_name, qoh.dept_num, qoh.par_class_code, qoh.coid_fac_dept_par_id,
      qoh.facility_item_desc]
    listen:
      Req Type: qoh.req_type
    row: 22
    col: 5
    width: 11
    height: 9
  - name: " (Copy 5)"
    type: text
    title_text: " (Copy 5)"
    subtitle_text: ''
    body_text: '[{"type":"h1","children":[{"text":"Example - QOH Example from Earlier"}],"align":"center"},{"type":"ul","children":[{"type":"li","children":[{"type":"lic","children":[{"text":"This
      is the blade in COID 34222 "}],"id":1703699687129}],"id":1703698400595},{"type":"li","children":[{"type":"lic","children":[{"text":"QOH
      is close when inv shifts up in Sept 22 from 39 to 55 (note: there''s a month-long
      gap at 0 in Aug 22 that is unaccounted for)"}],"id":1703700566985}],"id":1703700566985},{"type":"li","children":[{"type":"lic","children":[{"text":"But
      then req far outnumber used, so despite inv resesting in Aug 22, Sept 22, and
      Aug 23, QOH stays well above actual inventory"}],"id":1703700567513}],"id":1703700567513},{"type":"li","children":[{"type":"lic","children":[{"text":"Note:
      usually usage far outnumbers req, so QOH is usually way below total used"}],"id":1703700886230}],"id":1703700886230}],"id":1703698400592}]'
    rich_content_json: '{"format":"slate"}'
    row: 13
    col: 0
    width: 5
    height: 9
  - title: Example
    name: Example (4)
    model: supply_chain_qoh
    explore: qoh
    type: looker_line
    fields: [qoh.reporting_month, qoh.coid_fac_dept_par_id, qoh.coid, qoh.facility_item_desc_short,
      qoh.facility_item_desc, qoh.facility_name, qoh.dept_num, qoh.par_class_code,
      qoh.total_req, qoh.total_used, qoh.total_req_min_used, qoh.total_inv, qoh.total_qoh_since_last_inv_change,
      qoh.total_inv_actual, qoh.total_est_prior_month, qoh.avg_error, qoh.avg_abs_error,
      qoh.perc_error]
    filters:
      qoh.coid_fac_dept_par_id: '12232'
    sorts: [qoh.reporting_month]
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
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    enable_conditional_formatting: true
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    truncate_header: false
    minimum_column_width: 75
    series_cell_visualizations:
      qoh.total_req:
        is_active: false
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: "#4285F4",
        font_color: !!null '', color_application: {collection_id: google, custom: {
            id: 698f98c0-bf1e-f7de-a6d8-46e015235219, label: Custom, type: continuous,
            stops: [{color: "#B31412", offset: 0}, {color: yellow, offset: 25}, {
                color: green, offset: 50}, {color: yellow, offset: 75}, {color: "#B31412",
                offset: 100}]}, options: {steps: 5, constraints: {min: {type: number,
                value: -0.5}, mid: {type: number, value: 0}, max: {type: number, value: 0.5}},
            mirror: false, reverse: false, stepped: false}}, bold: false, italic: false,
        strikethrough: false, fields: [qoh.perc_error]}, {type: along a scale...,
        value: !!null '', background_color: "#4285F4", font_color: !!null '', color_application: {
          collection_id: google, palette_id: google-diverging-0, options: {constraints: {
              min: {type: minimum}, mid: {type: number, value: 0}, max: {type: maximum}},
            mirror: true, reverse: false, stepped: false}}, bold: false, italic: false,
        strikethrough: false, fields: [qoh.total_req_min_used, qoh.total_req, qoh.total_used]},
      {type: along a scale..., value: !!null '', background_color: "#4285F4", font_color: !!null '',
        color_application: {collection_id: google, custom: {id: 626e7d54-6eb5-b33f-8204-e31d73157d3f,
            label: Custom, type: continuous, stops: [{color: "#ffffff", offset: 0},
              {color: purple, offset: 100}]}, options: {steps: 5, constraints: {min: {
                type: minimum}, mid: {type: number, value: 0}, max: {type: maximum}},
            mirror: true, reverse: false, stepped: false}}, bold: false, italic: false,
        strikethrough: false, fields: [qoh.total_inv, qoh.total_qoh_since_last_inv_change]}]
    hidden_pivots: {}
    defaults_version: 1
    hidden_series: [qoh.total_avg_req_min_used, qoh.total_req_min_used, qoh.total_req,
      qoh.total_used, qoh.avg_est_prior_month, qoh.avg_error, qoh.avg_abs_error, qoh.perc_error,
      qoh.total_inv_actual, qoh.total_est_prior_month]
    hidden_fields: [qoh.facility_name, qoh.dept_num, qoh.par_class_code, qoh.coid_fac_dept_par_id,
      qoh.facility_item_desc, qoh.coid, qoh.facility_item_desc_short]
    listen:
      Req Type: qoh.req_type
    row: 13
    col: 16
    width: 8
    height: 9
  - title: Example
    name: Example (5)
    model: supply_chain_qoh
    explore: qoh
    type: looker_grid
    fields: [qoh.reporting_month, qoh.coid_fac_dept_par_id, qoh.coid, qoh.facility_item_desc_short,
      qoh.facility_item_desc, qoh.facility_name, qoh.dept_num, qoh.par_class_code,
      qoh.total_req, qoh.total_used, qoh.total_req_min_used, qoh.total_inv, qoh.total_qoh_since_last_inv_change,
      qoh.total_est_prior_month, qoh.avg_error, qoh.perc_error]
    filters:
      qoh.coid_fac_dept_par_id: '12232'
    sorts: [qoh.reporting_month]
    limit: 500
    column_limit: 50
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: true
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    truncate_header: false
    minimum_column_width: 75
    series_cell_visualizations:
      qoh.total_req:
        is_active: false
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: "#4285F4",
        font_color: !!null '', color_application: {collection_id: google, custom: {
            id: 698f98c0-bf1e-f7de-a6d8-46e015235219, label: Custom, type: continuous,
            stops: [{color: "#B31412", offset: 0}, {color: yellow, offset: 25}, {
                color: green, offset: 50}, {color: yellow, offset: 75}, {color: "#B31412",
                offset: 100}]}, options: {steps: 5, constraints: {min: {type: number,
                value: -0.5}, mid: {type: number, value: 0}, max: {type: number, value: 0.5}},
            mirror: false, reverse: false, stepped: false}}, bold: false, italic: false,
        strikethrough: false, fields: [qoh.perc_error]}, {type: along a scale...,
        value: !!null '', background_color: "#4285F4", font_color: !!null '', color_application: {
          collection_id: google, palette_id: google-diverging-0, options: {constraints: {
              min: {type: minimum}, mid: {type: number, value: 0}, max: {type: maximum}},
            mirror: true, reverse: false, stepped: false}}, bold: false, italic: false,
        strikethrough: false, fields: [qoh.total_req_min_used, qoh.total_req, qoh.total_used]},
      {type: along a scale..., value: !!null '', background_color: "#4285F4", font_color: !!null '',
        color_application: {collection_id: google, custom: {id: 626e7d54-6eb5-b33f-8204-e31d73157d3f,
            label: Custom, type: continuous, stops: [{color: "#ffffff", offset: 0},
              {color: purple, offset: 100}]}, options: {steps: 5, constraints: {min: {
                type: minimum}, mid: {type: number, value: 0}, max: {type: maximum}},
            mirror: true, reverse: false, stepped: false}}, bold: false, italic: false,
        strikethrough: false, fields: [qoh.total_inv, qoh.total_qoh_since_last_inv_change]}]
    x_axis_gridlines: false
    y_axis_gridlines: true
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
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    hidden_pivots: {}
    defaults_version: 1
    hidden_series: [qoh.total_avg_req_min_used, qoh.total_req_min_used, qoh.total_req,
      qoh.total_used, qoh.total_inv, qoh.total_qoh_since_last_inv_change, qoh.avg_est_prior_month]
    hidden_fields: [qoh.facility_name, qoh.dept_num, qoh.par_class_code, qoh.coid_fac_dept_par_id,
      qoh.facility_item_desc]
    listen:
      Req Type: qoh.req_type
    row: 13
    col: 5
    width: 11
    height: 9
  - title: Example
    name: Example (6)
    model: supply_chain_qoh
    explore: qoh
    type: looker_line
    fields: [qoh.reporting_month, qoh.coid_fac_dept_par_id, qoh.coid, qoh.facility_item_desc_short,
      qoh.facility_item_desc, qoh.facility_name, qoh.dept_num, qoh.par_class_code,
      qoh.total_req, qoh.total_used, qoh.total_req_min_used, qoh.total_inv, qoh.total_qoh_since_last_inv_change,
      qoh.total_inv_actual, qoh.total_est_prior_month, qoh.avg_error, qoh.avg_abs_error,
      qoh.perc_error]
    filters:
      qoh.coid_fac_dept_par_id: '25869'
    sorts: [qoh.reporting_month]
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
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    enable_conditional_formatting: true
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    truncate_header: false
    minimum_column_width: 75
    series_cell_visualizations:
      qoh.total_req:
        is_active: false
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: "#4285F4",
        font_color: !!null '', color_application: {collection_id: google, custom: {
            id: 698f98c0-bf1e-f7de-a6d8-46e015235219, label: Custom, type: continuous,
            stops: [{color: "#B31412", offset: 0}, {color: yellow, offset: 25}, {
                color: green, offset: 50}, {color: yellow, offset: 75}, {color: "#B31412",
                offset: 100}]}, options: {steps: 5, constraints: {min: {type: number,
                value: -0.5}, mid: {type: number, value: 0}, max: {type: number, value: 0.5}},
            mirror: false, reverse: false, stepped: false}}, bold: false, italic: false,
        strikethrough: false, fields: [qoh.perc_error]}, {type: along a scale...,
        value: !!null '', background_color: "#4285F4", font_color: !!null '', color_application: {
          collection_id: google, palette_id: google-diverging-0, options: {constraints: {
              min: {type: minimum}, mid: {type: number, value: 0}, max: {type: maximum}},
            mirror: true, reverse: false, stepped: false}}, bold: false, italic: false,
        strikethrough: false, fields: [qoh.total_req_min_used, qoh.total_req, qoh.total_used]},
      {type: along a scale..., value: !!null '', background_color: "#4285F4", font_color: !!null '',
        color_application: {collection_id: google, custom: {id: 626e7d54-6eb5-b33f-8204-e31d73157d3f,
            label: Custom, type: continuous, stops: [{color: "#ffffff", offset: 0},
              {color: purple, offset: 100}]}, options: {steps: 5, constraints: {min: {
                type: minimum}, mid: {type: number, value: 0}, max: {type: maximum}},
            mirror: true, reverse: false, stepped: false}}, bold: false, italic: false,
        strikethrough: false, fields: [qoh.total_inv, qoh.total_qoh_since_last_inv_change]}]
    hidden_pivots: {}
    defaults_version: 1
    hidden_series: [qoh.total_avg_req_min_used, qoh.total_req_min_used, qoh.total_req,
      qoh.total_used, qoh.avg_est_prior_month, qoh.avg_error, qoh.avg_abs_error, qoh.perc_error,
      qoh.total_inv_actual, qoh.total_est_prior_month]
    hidden_fields: [qoh.facility_name, qoh.dept_num, qoh.par_class_code, qoh.coid_fac_dept_par_id,
      qoh.facility_item_desc, qoh.facility_item_desc_short, qoh.coid]
    listen:
      Req Type: qoh.req_type
    row: 22
    col: 16
    width: 8
    height: 9
  - title: Example
    name: Example (7)
    model: supply_chain_qoh
    explore: qoh
    type: looker_line
    fields: [qoh.reporting_month, qoh.coid_fac_dept_par_id, qoh.coid, qoh.facility_item_desc_short,
      qoh.facility_item_desc, qoh.facility_name, qoh.dept_num, qoh.par_class_code,
      qoh.total_req, qoh.total_used, qoh.total_req_min_used, qoh.total_inv, qoh.total_qoh_since_last_inv_change,
      qoh.total_inv_actual, qoh.total_est_prior_month, qoh.avg_error, qoh.avg_abs_error,
      qoh.perc_error]
    filters:
      qoh.coid_fac_dept_par_id: '1239'
    sorts: [qoh.reporting_month]
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
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    enable_conditional_formatting: true
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    truncate_header: false
    minimum_column_width: 75
    series_cell_visualizations:
      qoh.total_req:
        is_active: false
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: "#4285F4",
        font_color: !!null '', color_application: {collection_id: google, custom: {
            id: 698f98c0-bf1e-f7de-a6d8-46e015235219, label: Custom, type: continuous,
            stops: [{color: "#B31412", offset: 0}, {color: yellow, offset: 25}, {
                color: green, offset: 50}, {color: yellow, offset: 75}, {color: "#B31412",
                offset: 100}]}, options: {steps: 5, constraints: {min: {type: number,
                value: -0.5}, mid: {type: number, value: 0}, max: {type: number, value: 0.5}},
            mirror: false, reverse: false, stepped: false}}, bold: false, italic: false,
        strikethrough: false, fields: [qoh.perc_error]}, {type: along a scale...,
        value: !!null '', background_color: "#4285F4", font_color: !!null '', color_application: {
          collection_id: google, palette_id: google-diverging-0, options: {constraints: {
              min: {type: minimum}, mid: {type: number, value: 0}, max: {type: maximum}},
            mirror: true, reverse: false, stepped: false}}, bold: false, italic: false,
        strikethrough: false, fields: [qoh.total_req_min_used, qoh.total_req, qoh.total_used]},
      {type: along a scale..., value: !!null '', background_color: "#4285F4", font_color: !!null '',
        color_application: {collection_id: google, custom: {id: 626e7d54-6eb5-b33f-8204-e31d73157d3f,
            label: Custom, type: continuous, stops: [{color: "#ffffff", offset: 0},
              {color: purple, offset: 100}]}, options: {steps: 5, constraints: {min: {
                type: minimum}, mid: {type: number, value: 0}, max: {type: maximum}},
            mirror: true, reverse: false, stepped: false}}, bold: false, italic: false,
        strikethrough: false, fields: [qoh.total_inv, qoh.total_qoh_since_last_inv_change]}]
    hidden_pivots: {}
    defaults_version: 1
    hidden_series: [qoh.total_avg_req_min_used, qoh.total_req_min_used, qoh.total_req,
      qoh.total_used, qoh.avg_est_prior_month, qoh.avg_error, qoh.avg_abs_error, qoh.perc_error,
      qoh.total_inv_actual, qoh.total_est_prior_month]
    hidden_fields: [qoh.facility_name, qoh.dept_num, qoh.par_class_code, qoh.coid_fac_dept_par_id,
      qoh.facility_item_desc, qoh.facility_item_desc_short, qoh.coid]
    listen:
      Req Type: qoh.req_type
    row: 31
    col: 16
    width: 8
    height: 9
  - title: Example
    name: Example (8)
    model: supply_chain_qoh
    explore: qoh
    type: looker_line
    fields: [qoh.reporting_month, qoh.coid_fac_dept_par_id, qoh.coid, qoh.facility_item_desc_short,
      qoh.facility_item_desc, qoh.facility_name, qoh.dept_num, qoh.par_class_code,
      qoh.total_req, qoh.total_used, qoh.total_req_min_used, qoh.total_inv, qoh.total_qoh_since_last_inv_change,
      qoh.total_inv_actual, qoh.total_est_prior_month, qoh.avg_error, qoh.avg_abs_error,
      qoh.perc_error]
    filters:
      qoh.coid_fac_dept_par_id: '60671'
    sorts: [qoh.reporting_month]
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
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    enable_conditional_formatting: true
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    truncate_header: false
    minimum_column_width: 75
    series_cell_visualizations:
      qoh.total_req:
        is_active: false
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: "#4285F4",
        font_color: !!null '', color_application: {collection_id: google, custom: {
            id: 698f98c0-bf1e-f7de-a6d8-46e015235219, label: Custom, type: continuous,
            stops: [{color: "#B31412", offset: 0}, {color: yellow, offset: 25}, {
                color: green, offset: 50}, {color: yellow, offset: 75}, {color: "#B31412",
                offset: 100}]}, options: {steps: 5, constraints: {min: {type: number,
                value: -0.5}, mid: {type: number, value: 0}, max: {type: number, value: 0.5}},
            mirror: false, reverse: false, stepped: false}}, bold: false, italic: false,
        strikethrough: false, fields: [qoh.perc_error]}, {type: along a scale...,
        value: !!null '', background_color: "#4285F4", font_color: !!null '', color_application: {
          collection_id: google, palette_id: google-diverging-0, options: {constraints: {
              min: {type: minimum}, mid: {type: number, value: 0}, max: {type: maximum}},
            mirror: true, reverse: false, stepped: false}}, bold: false, italic: false,
        strikethrough: false, fields: [qoh.total_req_min_used, qoh.total_req, qoh.total_used]},
      {type: along a scale..., value: !!null '', background_color: "#4285F4", font_color: !!null '',
        color_application: {collection_id: google, custom: {id: 626e7d54-6eb5-b33f-8204-e31d73157d3f,
            label: Custom, type: continuous, stops: [{color: "#ffffff", offset: 0},
              {color: purple, offset: 100}]}, options: {steps: 5, constraints: {min: {
                type: minimum}, mid: {type: number, value: 0}, max: {type: maximum}},
            mirror: true, reverse: false, stepped: false}}, bold: false, italic: false,
        strikethrough: false, fields: [qoh.total_inv, qoh.total_qoh_since_last_inv_change]}]
    hidden_pivots: {}
    defaults_version: 1
    hidden_series: [qoh.total_avg_req_min_used, qoh.total_req_min_used, qoh.total_req,
      qoh.total_used, qoh.avg_est_prior_month, qoh.avg_error, qoh.avg_abs_error, qoh.perc_error,
      qoh.total_inv_actual, qoh.total_est_prior_month]
    hidden_fields: [qoh.facility_name, qoh.dept_num, qoh.par_class_code, qoh.coid_fac_dept_par_id,
      qoh.facility_item_desc, qoh.coid, qoh.facility_item_desc_short]
    listen:
      Req Type: qoh.req_type
    row: 40
    col: 16
    width: 8
    height: 9
  - name: " (Copy 6)"
    type: text
    title_text: " (Copy 6)"
    subtitle_text: ''
    body_text: '[{"type":"h1","children":[{"text":"Largest Surplus & Shortages"}],"align":"center"},{"type":"ul","children":[{"type":"li","children":[{"type":"lic","children":[{"text":"Despite
      actual & estimated inventory moving somewhat closely together in aggregate,
      at the individual level, there can be a wide divergence in the % error observed"}],"id":1703698421572}],"id":1703698400595},{"type":"li","children":[{"type":"lic","children":[{"text":"The
      below 2 tables that identify largest surplus & shortage items for present (Dec
      ''23)"}],"id":1703773469304}],"id":1703773469304},{"type":"li","children":[{"type":"lic","children":[{"text":"If
      you set the filter for “Has Item been Accurate in the Past” to “Yes”, we will
      only include items that historically (prior to Dec ''23) had an error rate of
      ±25% or less (about 1 in 8 items meet that threshold)"}],"id":1703797848844}],"id":1703797848844},{"type":"li","children":[{"type":"lic","children":[{"text":"More
      investigation needs to be done to make more items have error rates within that
      threshold "}],"id":1703797907455}],"id":1703797907455}],"id":1703698400592}]'
    rich_content_json: '{"format":"slate"}'
    row: 49
    col: 0
    width: 24
    height: 3
  - title: Largest Surplus
    name: Largest Surplus
    model: supply_chain_qoh
    explore: qoh
    type: looker_grid
    fields: [qoh.coid, qoh.facility_name, qoh.facility_item_num, qoh.facility_item_desc,
      qoh.dept_num, qoh.par_class_code, qoh.total_avg_since_last_inv_change]
    filters:
      qoh.reporting_month: 2023-12
    sorts: [qoh.total_avg_since_last_inv_change desc 0]
    limit: 50
    column_limit: 50
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: true
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    truncate_header: false
    minimum_column_width: 75
    series_labels:
      qoh.total_avg_since_last_inv_change: QOH
    series_cell_visualizations:
      qoh.total_qoh_since_last_inv_change:
        is_active: false
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: "#4285F4",
        font_color: !!null '', color_application: {collection_id: google, palette_id: google-sequential-0},
        bold: false, italic: false, strikethrough: false, fields: [qoh.total_avg_since_last_inv_change]}]
    defaults_version: 1
    listen:
      Req Type: qoh.req_type
      Has Item been Accurate in the Past? (Yes / No): item_filter.is_item_not_null
    row: 52
    col: 0
    width: 12
    height: 11
  - title: Largest Shortage
    name: Largest Shortage
    model: supply_chain_qoh
    explore: qoh
    type: looker_grid
    fields: [qoh.coid, qoh.facility_name, qoh.facility_item_num, qoh.facility_item_desc,
      qoh.dept_num, qoh.par_class_code, qoh.total_avg_since_last_inv_change]
    filters:
      qoh.reporting_month: 2023-12
      qoh.total_avg_since_last_inv_change: NOT NULL
    sorts: [qoh.total_avg_since_last_inv_change]
    limit: 50
    column_limit: 50
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: true
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    truncate_header: false
    minimum_column_width: 75
    series_labels:
      qoh.total_avg_since_last_inv_change: QOH
    series_cell_visualizations:
      qoh.total_qoh_since_last_inv_change:
        is_active: false
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: "#4285F4",
        font_color: !!null '', color_application: {collection_id: google, custom: {
            id: f2a78732-f105-9956-4eef-a09ae9f9e8ac, label: Custom, type: continuous,
            stops: [{color: "#ffffff", offset: 0}, {color: red, offset: 100}]}, options: {
            steps: 5, reverse: true}}, bold: false, italic: false, strikethrough: false,
        fields: [qoh.total_avg_since_last_inv_change]}]
    defaults_version: 1
    listen:
      Req Type: qoh.req_type
      Has Item been Accurate in the Past? (Yes / No): item_filter.is_item_not_null
    row: 52
    col: 12
    width: 12
    height: 11
  filters:
  - name: Req Type
    title: Req Type
    type: field_filter
    default_value: avg
    allow_multiple_values: true
    required: false
    ui_config:
      type: radio_buttons
      display: inline
    model: supply_chain_qoh
    explore: qoh
    listens_to_filters: []
    field: qoh.req_type
  - name: Has Item been Accurate in the Past? (Yes / No)
    title: Has Item been Accurate in the Past? (Yes / No)
    type: field_filter
    default_value: 'Yes'
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
    model: supply_chain_qoh
    explore: qoh
    listens_to_filters: []
    field: item_filter.is_item_not_null
