view: accuracy_filter {
  derived_table: {
    explore_source: qoh {
      # column: coid_fac_dept_par_id {}
      column: facility_item_num {}
      column: total_req_min_used {}
      filters: {
        field: qoh.req_type
        value: "avg"
      }
      filters: {
        field: qoh.total_req_min_used
        value: "[-2000,2000]"
      }
      # filters: {
      #   field: qoh.perc_req_used_to_used
      #   value: "[-0.5,0.5]"
      # }
    }
  }
  dimension: total_req_min_used {
    hidden: yes
    type: number
  }
  dimension: col_val {
    hidden: yes
    type: number
    # sql: ${TABLE}.coid_fac_dept_par_id ;;
    sql: ${TABLE}.facility_item_num ;;
  }

  dimension: is_item_not_null {
    view_label: "*PDT Filter"
    label: "Is Item Close to Even?"
    type: yesno
    sql: ${col_val} is not null ;;
  }
}
