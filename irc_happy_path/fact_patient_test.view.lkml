view: fact_patient_test {
  sql_table_name: Test_Denials.Fact_Patient_Test
    ;;

  dimension: pk {
    primary_key: yes
    type: string
    sql: ${patient_dw_id} || '-' || ${coid} ;;
  }

  measure: count_pk {
    type: count_distinct
    sql: ${pk} ;;
  }

#######################
### Original Dimensions
#######################

  dimension_group: admission {
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
    sql: ${TABLE}.admission_date ;;
  }

  dimension: coid {
    type: number
    value_format_name: id
    sql: ${TABLE}.coid ;;
  }

  dimension_group: discharge {
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
    sql: ${TABLE}.discharge_date ;;
  }

  dimension: drg_desc_hcfa {
    type: string
    sql: ${TABLE}.drg_desc_hcfa ;;
  }

  dimension: drg_hcfa_icd10_code {
    type: number
    sql: ${TABLE}.drg_hcfa_icd10_code ;;
  }

  dimension: drg_payment_weight_amt {
    type: number
    sql: ${TABLE}.drg_payment_weight_amt ;;
  }

  dimension_group: last_charity_write_off {
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
    sql: ${TABLE}.last_charity_write_off_date ;;
  }

  dimension_group: last_patient_payment {
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
    sql: ${TABLE}.last_patient_payment_date ;;
  }

  dimension_group: last_write_off {
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
    sql: ${TABLE}.last_write_off_date ;;
  }

  dimension: patient_dw_id {
    type: string
    sql: safe_cast(${TABLE}.patient_dw_id as string);;
  }

  dimension: patient_type_code_pos1 {
    type: string
    sql: ${TABLE}.patient_type_code_pos1 ;;
  }

  dimension: total_account_balance_amt {
    type: number
    sql: ${TABLE}.total_account_balance_amt ;;
  }

  dimension: total_adjustment_amt {
    type: number
    sql: ${TABLE}.total_adjustment_amt ;;
  }

  dimension: total_anc_charges {
    type: number
    sql: ${TABLE}.total_anc_charges ;;
  }

  dimension: total_billed_charges {
    type: number
    sql: ${TABLE}.total_billed_charges ;;
  }

  dimension: total_charity_write_off_amt {
    type: number
    sql: ${TABLE}.total_charity_write_off_amt ;;
  }

  dimension: total_contract_allow_amt {
    type: number
    sql: ${TABLE}.total_contract_allow_amt ;;
  }

  dimension: total_patient_liability_amt {
    type: number
    sql: ${TABLE}.total_patient_liability_amt ;;
  }

  dimension: total_patient_payment_amt {
    type: number
    sql: ${TABLE}.total_patient_payment_amt ;;
  }

  dimension: total_payments {
    type: number
    sql: ${TABLE}.total_payments ;;
  }

  dimension: total_rb_charges {
    type: number
    sql: ${TABLE}.total_rb_charges ;;
  }

  dimension: total_uninsured_discount_amt {
    type: number
    sql: ${TABLE}.total_uninsured_discount_amt ;;
  }

  dimension: total_write_off_bad_debt_amt {
    type: number
    sql: ${TABLE}.total_write_off_bad_debt_amt ;;
  }

  dimension: total_write_off_other_adj_amt {
    type: number
    sql: ${TABLE}.total_write_off_other_adj_amt ;;
  }

  dimension: total_write_off_other_amt {
    type: number
    sql: ${TABLE}.total_write_off_other_amt ;;
  }

#######################
### Derived Dimensions
#######################

#######################
### Measures
#######################

  measure: count {
    type: count
    drill_fields: []
  }
}
