
view: qoh_vs_actual {
  sql_table_name: `hca-sandbox-aaron-argolis.supply_chain.analytics_fact_combined_filtered_qoh_difference_vs_actual` ;;

#######################
### Original Dimensions
#######################

  dimension: coid_fac_dept_par_id {
    hidden: yes
    type: number
    sql: ${TABLE}.coid_fac_dept_par_id ;;
  }

  dimension_group: month {
    hidden: yes
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.month_date ;;
  }

  dimension: qoh_req_avg_estimate {
    type: number
    sql: ${TABLE}.qoh_req_avg_estimate ;;
  }

  dimension: qoh_req_issued_estimate {
    type: number
    sql: ${TABLE}.qoh_req_issued_estimate ;;
  }

  dimension: qoh_req_received_estimate {
    type: number
    sql: ${TABLE}.qoh_req_received_estimate ;;
  }

  dimension: reported_inv {
    hidden: yes
    type: number
    sql: ${TABLE}.reported_inv ;;
  }

#######################
### Derived Dimensions
#######################

#######################
### Measures
#######################

  measure: count {
    type: count
  }
}

# dimension: avg_lium_price {
#   type: number
#   sql: ${TABLE}.avg_lium_price ;;
# }

# dimension: change_group {
#   type: number
#   sql: ${TABLE}.change_group ;;
# }

# dimension: coid {
#   type: number
#   value_format_name: id
#   sql: ${TABLE}.coid ;;
# }

# dimension: dept_num {
#   type: number
#   sql: ${TABLE}.Dept_Num ;;
# }

# dimension: facility_item_alt_num {
#   type: number
#   sql: ${TABLE}.facility_item_alt_num ;;
# }

# dimension: facility_item_desc {
#   type: string
#   sql: ${TABLE}.facility_item_desc ;;
# }

# dimension: facility_item_num {
#   type: number
#   sql: ${TABLE}.facility_item_num ;;
# }

# dimension: facility_name {
#   type: string
#   sql: ${TABLE}.facility_name ;;
# }

# dimension: inventory_change {
#   type: number
#   sql: ${TABLE}.inventory_change ;;
# }

# dimension: max_lium_price {
#   type: number
#   sql: ${TABLE}.max_lium_price ;;
# }

# dimension: min_lium_price {
#   type: number
#   sql: ${TABLE}.min_lium_price ;;
# }

# dimension: par_class_code {
#   type: string
#   sql: ${TABLE}.PAR_Class_Code ;;
# }

# dimension: par_max {
#   type: number
#   sql: ${TABLE}.par_max ;;
# }

# dimension: par_min {
#   type: number
#   sql: ${TABLE}.par_min ;;
# }

# dimension: qoh_req_avg_since_last_inv {
#   type: number
#   sql: ${TABLE}.qoh_req_avg_since_last_inv ;;
# }

# dimension: qoh_req_issued_since_last_inv {
#   type: number
#   sql: ${TABLE}.qoh_req_issued_since_last_inv ;;
# }

# dimension: qoh_req_received_since_last_inv {
#   type: number
#   sql: ${TABLE}.qoh_req_received_since_last_inv ;;
# }

# dimension: req_issued_qty {
#   type: number
#   sql: ${TABLE}.req_issued_qty ;;
# }

# dimension: req_recieved_qty {
#   type: number
#   sql: ${TABLE}.req_recieved_qty ;;
# }

# dimension: standard_item_alt_num {
#   type: number
#   sql: ${TABLE}.standard_item_alt_num ;;
# }

# dimension: standard_item_num {
#   type: number
#   sql: ${TABLE}.standard_item_num ;;
# }

# dimension: usd_qty {
#   type: number
#   sql: ${TABLE}.usd_qty ;;
# }

# dimension: difference_estimate_qoh_req_avg {
#   type: number
#   sql: ${TABLE}.difference_estimate_qoh_req_avg ;;
# }

# dimension: difference_estimate_qoh_req_issued {
#   type: number
#   sql: ${TABLE}.difference_estimate_qoh_req_issued ;;
# }

# dimension: difference_estimate_qoh_req_received {
#   type: number
#   sql: ${TABLE}.difference_estimate_qoh_req_received ;;
# }
