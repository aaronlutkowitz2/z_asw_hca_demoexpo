view: denials_eom {
  sql_table_name: Test_Denials.Denials_EOM
    ;;

  dimension: pk {
    primary_key: yes
    type: string
    sql: ${patient_dw_id} || '-' || ${coid} || '-' || ${pe_raw} ;;
  }

  measure: count_pk {
    type: count_distinct
    sql: ${pk} ;;
  }

#######################
### Original Dimensions
#######################


  dimension: account_balance_amt {
    type: number
    sql: ${TABLE}.Account_Balance_Amt ;;
  }

  dimension: appeal_closing_date {
    type: string
    sql: ${TABLE}.Appeal_Closing_Date ;;
  }

  dimension: appeal_deadline_date {
    type: string
    sql: ${TABLE}.Appeal_Deadline_Date ;;
  }

  dimension: appeal_level_num {
    type: number
    sql: ${TABLE}.Appeal_Level_Num ;;
  }

  dimension_group: appeal_level_origination {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.Appeal_Level_Origination_Date ;;
  }

  dimension_group: appeal_origination {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.Appeal_Origination_Date ;;
  }

  dimension: attending_physician_name {
    type: string
    sql: ${TABLE}.Attending_Physician_Name ;;
  }

  dimension: beginning_appeal_amt {
    type: number
    sql: ${TABLE}.Beginning_Appeal_Amt ;;
  }

  dimension: beginning_balance_amt {
    type: number
    sql: ${TABLE}.Beginning_Balance_Amt ;;
  }

  dimension: beginning_balance_count {
    type: number
    sql: ${TABLE}.Beginning_Balance_Count ;;
  }

  dimension: cc_cash_adjustment_amt {
    type: string
    sql: ${TABLE}.CC_Cash_Adjustment_Amt ;;
  }

  dimension: cc_contractual_allow_adj_amt {
    type: string
    sql: ${TABLE}.CC_Contractual_Allow_Adj_Amt ;;
  }

  dimension: cc_denial_cat_code {
    type: string
    sql: ${TABLE}.CC_Denial_Cat_Code ;;
  }

  dimension: cc_disposition_code {
    type: string
    sql: ${TABLE}.CC_Disposition_Code ;;
  }

  dimension: cc_root_cause_id {
    type: string
    sql: ${TABLE}.CC_Root_Cause_ID ;;
  }

  dimension: coid {
    type: number
    value_format_name: id
    sql: ${TABLE}.Coid ;;
  }

  dimension: corrections_account_amt {
    type: number
    sql: ${TABLE}.Corrections_Account_Amt ;;
  }

  dimension: denial_status_code {
    type: string
    sql: ${TABLE}.Denial_Status_Code ;;
  }

  dimension: denied_charges {
    type: string
    sql: ${TABLE}.Denied_Charges ;;
  }

  dimension: ending_balance_amt {
    type: number
    sql: ${TABLE}.Ending_Balance_Amt ;;
  }

  dimension: iplan_id {
    type: number
    sql: ${TABLE}.IPlan_ID ;;
  }

  dimension: last_update_date {
    type: string
    sql: ${TABLE}.Last_Update_Date ;;
  }

  dimension: new_denial_account_amt {
    type: number
    sql: ${TABLE}.New_Denial_Account_Amt ;;
  }

  dimension: new_denial_account_count {
    type: number
    sql: ${TABLE}.New_Denial_Account_Count ;;
  }

  dimension: not_true_denial_amt {
    type: number
    sql: ${TABLE}.Not_True_Denial_Amt ;;
  }

  dimension: overturned_account_amt {
    type: number
    sql: ${TABLE}.Overturned_Account_Amt ;;
  }

  dimension: pa_vendor_code {
    type: string
    sql: ${TABLE}.PA_Vendor_Code ;;
  }

  dimension: patient_dw_id {
    type: string
    sql: safe_cast(${TABLE}.Patient_DW_ID as string) ;;
  }

  dimension_group: pe {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.PE_Date ;;
  }

  dimension: resolved_accounts_count {
    type: number
    sql: ${TABLE}.Resolved_Accounts_Count ;;
  }

  dimension: service_code {
    type: string
    sql: ${TABLE}.Service_Code ;;
  }

  dimension: string_field_36 {
    type: string
    sql: ${TABLE}.string_field_36 ;;
  }

  dimension: total_charge_amt {
    type: number
    sql: ${TABLE}.Total_Charge_Amt ;;
  }

  dimension: trans_next_party_amt {
    type: number
    sql: ${TABLE}.Trans_Next_Party_Amt ;;
  }

  dimension: unworked_conversion_amt {
    type: string
    sql: ${TABLE}.Unworked_Conversion_Amt ;;
  }

  dimension: unworked_new_accounts_count {
    type: string
    sql: ${TABLE}.Unworked_New_Accounts_Count ;;
  }

  dimension: write_off_denial_account_amt {
    type: number
    sql: ${TABLE}.Write_Off_Denial_Account_Amt ;;
  }

#######################
### Derived Dimensions
#######################

#######################
### Measures
#######################

  measure: count {
    type: count
    drill_fields: [attending_physician_name]
  }

  measure: min_origination_dates {
    type: date
    sql: min(${appeal_origination_date}) ;;
  }
}
