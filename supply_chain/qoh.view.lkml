view: qoh {
  sql_table_name: `hca-sandbox-aaron-argolis.supply_chain.analytics_fact_combined_filtered_qoh` ;;

#######################
### Original Dimensions
#######################

#### Info

  dimension: avg_lium_price {
    group_label: "Info"
    type: number
    sql: ${TABLE}.avg_lium_price ;;
  }

  dimension: facility_item_alt_num {
    group_label: "Info"
    type: number
    sql: ${TABLE}.facility_item_alt_num ;;
  }

  dimension: facility_item_desc {
    group_label: "Info"
    type: string
    sql: ${TABLE}.facility_item_desc ;;
  }

  dimension: facility_name {
    group_label: "Info"
    type: string
    sql: ${TABLE}.facility_name ;;
  }

  dimension: max_lium_price {
    group_label: "Info"
    type: number
    sql: ${TABLE}.max_lium_price ;;
  }

  dimension: min_lium_price {
    group_label: "Info"
    type: number
    sql: ${TABLE}.min_lium_price ;;
  }

  dimension: par_max {
    group_label: "Info"
    type: number
    sql: ${TABLE}.par_max ;;
  }

  dimension: par_min {
    group_label: "Info"
    type: number
    sql: ${TABLE}.par_min ;;
  }

  dimension: standard_item_alt_num {
    group_label: "Info"
    type: number
    sql: ${TABLE}.standard_item_alt_num ;;
  }

  dimension: standard_item_num {
    group_label: "Info"
    type: number
    sql: ${TABLE}.standard_item_num ;;
  }

#### ID

  dimension: coid {
    group_label: "IDs"
    type: number
    value_format_name: id
    sql: ${TABLE}.coid ;;
  }

  dimension: coid_fac_dept_par_id {
    group_label: "IDs"
    type: number
    sql: ${TABLE}.coid_fac_dept_par_id ;;
  }

  dimension: dept_num {
    group_label: "IDs"
    type: number
    sql: ${TABLE}.Dept_Num ;;
  }

  dimension: facility_item_num {
    group_label: "IDs"
    type: number
    sql: ${TABLE}.facility_item_num ;;
  }

  dimension: par_class_code {
    group_label: "IDs"
    type: string
    sql: ${TABLE}.PAR_Class_Code ;;
  }

#### QOH Estimates

  dimension: change_group {
    group_label: "QOH Esimate"
    type: number
    sql: ${TABLE}.change_group ;;
  }

  dimension: inventory_change {
    group_label: "QOH Esimate"
    type: number
    sql: ${TABLE}.inventory_change ;;
  }

  dimension: usd_qty {
    group_label: "QOH Esimate"
    type: number
    sql: ${TABLE}.usd_qty ;;
  }

#### Reporting Time

  dimension_group: reporting {
    type: time
    timeframes: [raw, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.month_date ;;
  }

#### Hidden

  dimension: qoh_req_avg_since_last_inv {
    hidden: yes
    type: number
    sql: ${TABLE}.qoh_req_avg_since_last_inv ;;
  }

  dimension: qoh_req_issued_since_last_inv {
    hidden: yes
    type: number
    sql: ${TABLE}.qoh_req_issued_since_last_inv ;;
  }

  dimension: qoh_req_received_since_last_inv {
    hidden: yes
    type: number
    sql: ${TABLE}.qoh_req_received_since_last_inv ;;
  }

  dimension: reported_inv {
    hidden: yes
    type: number
    sql: ${TABLE}.reported_inv ;;
  }

  dimension: req_issued_qty {
    hidden: yes
    type: number
    sql: ${TABLE}.req_issued_qty ;;
  }

  dimension: req_recieved_qty {
    hidden: yes
    type: number
    sql: ${TABLE}.req_recieved_qty ;;
  }

#######################
### Derived Dimensions
#######################

  dimension: req_avg_qty {
    hidden: yes
    type: number
    sql: (${req_issued_qty} + ${req_recieved_qty}) / 2 ;;
    value_format_name: decimal_1
  }

  parameter: req_type {
    type: unquoted
    default_value: "avg"
    allowed_value: {label: "Issued" value: "iss"}
    allowed_value: {label: "Received" value: "rec"}
    allowed_value: {label: "Average" value: "avg"}
  }

  dimension: req_qty {
    group_label: "QOH Esimate"
    type: number
    sql:
      {% if    req_type._parameter_value == 'iss' %} ${req_issued_qty}
      {% elsif req_type._parameter_value == 'rec' %} ${req_recieved_qty}
      {% elsif req_type._parameter_value == 'avg' %} ${req_avg_qty}
      {% else %} ${req_avg_qty}
      {% endif %}
    ;;
  }

  dimension: qoh_since_last_inv {
    group_label: "QOH Esimate"
    type: number
    sql:
      {% if    req_type._parameter_value == 'iss' %} ${qoh_req_issued_since_last_inv}
      {% elsif req_type._parameter_value == 'rec' %} ${qoh_req_received_since_last_inv}
      {% elsif req_type._parameter_value == 'avg' %} ${qoh_req_avg_since_last_inv}
      {% else %} ${qoh_req_avg_since_last_inv}
      {% endif %}
    ;;
  }

  dimension: qoh_esimate {
    group_label: "QOH Esimate"
    label: "QOH Est (Last Month)"
    type: number
    sql:
      {% if    req_type._parameter_value == 'iss' %} ${qoh_vs_actual.qoh_req_issued_estimate}
      {% elsif req_type._parameter_value == 'rec' %} ${qoh_vs_actual.qoh_req_issued_estimate}
      {% elsif req_type._parameter_value == 'avg' %} ${qoh_vs_actual.qoh_req_avg_estimate}
      {% else %} ${qoh_vs_actual.qoh_req_avg_estimate}
      {% endif %}
    ;;
  }

  dimension: diff_estimate {
    group_label: "QOH Esimate"
    label: "QOH Estimate vs Actual"
    type: number
    sql: ${qoh_esimate} - ${reported_inv} ;;
  }

#######################
### Measures
#######################

  measure: count {
    type: count
    drill_fields: [facility_name]
  }

  measure: total_req {
    label: "1a Total Req"
    type: sum
    sql: ${req_qty} ;;
  }

  measure: total_avg_req {
    label: "1b Avg Req"
    type: average
    sql: ${req_qty} ;;
    value_format_name: decimal_1
  }

  measure: total_used {
    label: "2a Total Used"
    type: sum
    sql: ${usd_qty} ;;
  }

  measure: total_avg_used {
    label: "2b Avg Used"
    type: average
    sql: ${usd_qty} ;;
    value_format_name: decimal_1
  }

  measure: total_req_min_used {
    label: "3a Total Req - Used"
    type: number
    sql: ${total_req} - ${total_used} ;;
  }

  measure: total_avg_req_min_used {
    label: "3b Avg Req - Used"
    type: number
    sql: ${total_avg_req} - ${total_avg_used} ;;
    value_format_name: decimal_1
  }

  measure: perc_req_used_to_used {
    label: "3c % Req - Used of Total"
    type: number
    sql: ${total_avg_req_min_used} / nullif(coalesce(${total_avg_used}, ${total_avg_req}),0) ;;
    value_format_name: percent_1
  }

  measure: total_inv {
    label: "4a Total Inv"
    type: sum
    sql: ${reported_inv} ;;
  }

  measure: total_avg_inv {
    label: "4b Avg Inv"
    type: average
    sql: ${reported_inv} ;;
    value_format_name: decimal_1
  }

  measure: total_qoh_since_last_inv_change {
    label: "5a Total QOH"
    type: sum
    sql: ${qoh_since_last_inv} ;;
  }

  measure: total_avg_since_last_inv_change {
    label: "5b Avg QOH"
    type: average
    sql: ${qoh_since_last_inv} ;;
    value_format_name: decimal_1
  }

  measure: avg_est_prior_month {
    label: "99 Avg Estimate (from Prior Month)"
    type: average
    sql: ${qoh_esimate} ;;
    value_format_name: decimal_1
  }

  measure: avg_error {
    label: "6 Avg Error"
    type: average
    sql: ${diff_estimate} ;;
    value_format_name: decimal_1
  }

  measure: avg_abs_error {
    label: "7 Avg Abs Error"
    type: average
    sql: abs(${diff_estimate}) ;;
    value_format_name: decimal_1
  }

  measure: avg_inventory {
    hidden: yes
    type: average
    sql: ${reported_inv} ;;
    value_format_name: decimal_1
  }

  measure: perc_error {
    label: "8 Avg % Error"
    type: number
    sql: ${avg_abs_error} / nullif(${avg_inventory},0) ;;
    value_format_name: percent_1
  }
}
