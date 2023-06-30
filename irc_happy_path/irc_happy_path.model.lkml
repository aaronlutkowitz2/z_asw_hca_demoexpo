connection: "z_asw_argolis"

include: "/irc_happy_path/*.view.lkml"                # include all views in the views/ folder in this project
# include: "/**/*.view.lkml"                 # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard
# include: "*.dashboard.lookml"   # include a LookML dashboard called my_dashboard

datagroup: irc_poc_data_group {
  max_cache_age: "24 hours"
}

explore: analytics_view {
  label: "Case Management Denials"
  view_label: "Fact Table"

  join: benchmark_table {
    relationship: many_to_one
    sql_on: ${analytics_view.bm_combined} = ${benchmark_table.bm_combined} ;;
  }

  join: benchmark_table2 {
    relationship: many_to_one
    sql_on: ${analytics_view.bm_combined2} = ${benchmark_table2.bm_combined2} ;;
  }

  # join: test_x_list {
  #   relationship: one_to_one
  #   sql_on: 1 = 1 ;;
  # }

  # join: test_x_list_string_agg {
  #   relationship: one_to_one
  #   sql_on: 1 = 1 ;;
  # }

  # join: test_x_list_string_agg_dimension {
  #   relationship: one_to_one
  #   sql_on: 1 = 1 ;;
  # }
}

explore: fact_patient_test {
  hidden: yes

  join: patient_esl_test {
    relationship: one_to_one
    sql_on:
          ${fact_patient_test.patient_dw_id} = ${patient_esl_test.patient_dw_id}
      AND ${fact_patient_test.coid} = ${patient_esl_test.coid}
    ;;
  }

  join: denials_eom {
    relationship: one_to_many
    sql_on:
          ${fact_patient_test.patient_dw_id} = ${denials_eom.patient_dw_id}
      AND ${fact_patient_test.coid} = ${denials_eom.coid}
    ;;
  }

  join: facility_dim {
    relationship: many_to_one
    sql_on: ${fact_patient_test.coid} = ${facility_dim.facility_id} ;;
  }

  # join: most_recent_pay {
  #   relationship: many_to_one
  #   sql_on: ${fact_patient_test.patient_dw_id} = ${most_recent_pay.patient_dw_id} ;;
  # }
}

explore: patient_esl_test { hidden: yes }
explore: denials_eom { hidden: yes }
explore: facility_dim { hidden: yes }
explore: most_recent_pay { hidden: yes }
