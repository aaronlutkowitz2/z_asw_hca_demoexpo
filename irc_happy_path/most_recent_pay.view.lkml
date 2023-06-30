view: most_recent_pay {
  sql_table_name: Test_Denials.most_recent_pay ;;

  dimension_group: most_recent_payment {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.MostRecentPayment ;;
  }

  dimension: patient_dw_id {
    primary_key: yes
    type: string
    sql: cast(${TABLE}.Patient_DW_Id as string) ;;
  }
  measure: count {
    type: count
  }
}
