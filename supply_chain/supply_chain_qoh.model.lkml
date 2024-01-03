connection: "z_asw_argolis"

include: "/supply_chain/*.view.lkml"                # include all views in the views/ folder in this project
# include: "/**/*.view.lkml"                 # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

explore: qoh {

  join: qoh_vs_actual {
    view_label: "Qoh"
    relationship: one_to_one
    sql_on:
          ${qoh.coid_fac_item_id} = ${qoh_vs_actual.coid_fac_item_id}
      AND ${qoh.reporting_raw} = ${qoh_vs_actual.month_raw}
    ;;
  }

  join: item_filter {
    relationship: many_to_one
    sql_on: ${qoh.facility_item_num} = ${item_filter.facility_item_num} ;;
  }
}
