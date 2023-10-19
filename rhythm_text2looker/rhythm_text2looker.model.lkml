connection: "z_asw_argolis"

include: "/rhythm_text2looker/*.view.lkml"                # include all views in the views/ folder in this project
# include: "/**/*.view.lkml"                 # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

explore: histories {
  sql_always_where: ${facility_name} is not null ;;
}
