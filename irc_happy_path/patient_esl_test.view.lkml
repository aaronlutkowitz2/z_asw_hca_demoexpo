view: patient_esl_test {
  sql_table_name: Test_Denials.Patient_ESL_Test
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

  dimension: coid {
    type: number
    value_format_name: id
    sql: ${TABLE}.coid ;;
  }

  dimension: esl_level_1_desc {
    type: string
    sql: ${TABLE}.esl_level_1_desc ;;
  }

  dimension: esl_level_2_desc {
    type: string
    sql: ${TABLE}.esl_level_2_desc ;;
  }

  dimension: esl_level_3_desc {
    type: string
    sql: ${TABLE}.esl_level_3_desc ;;
  }

  dimension: esl_level_4_desc {
    type: string
    sql: ${TABLE}.esl_level_4_desc ;;
  }

  dimension: esl_level_4_desc_1 {
    type: string
    sql: ${TABLE}.esl_level_4_desc_1 ;;
  }

  dimension: esl_level_5_code {
    type: string
    sql: ${TABLE}.esl_level_5_code ;;
  }

  dimension: esl_level_5_desc {
    type: string
    sql: ${TABLE}.esl_level_5_desc ;;
  }

  dimension: hcfa_drg {
    type: number
    sql: ${TABLE}.hcfa_drg ;;
  }

  dimension: patient_dw_id {
    type: string
    sql: safe_cast(${TABLE}.patient_dw_id as string) ;;
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
