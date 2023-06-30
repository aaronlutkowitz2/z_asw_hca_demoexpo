# The name of this view in Looker is "Most Recent Pay"
view: most_recent_pay {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `hca-sandbox-aaron-argolis.Test_Denials.most_recent_pay` ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: most_recent_payment {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.MostRecentPayment ;;
  }
    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Patient Dw ID" in Explore.

  dimension: patient_dw_id {
    type: number
    sql: ${TABLE}.Patient_DW_Id ;;
  }
  measure: count {
    type: count
  }
}
