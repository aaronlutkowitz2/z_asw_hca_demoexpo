view: facility_dim {
  sql_table_name: rx_benchmarking.googleobdata_3_facility_dim
    ;;

  dimension: pk {
    primary_key: yes
    type: string
    sql: ${facility_id} ;;
  }

  measure: count_pk {
    type: count_distinct
    sql: ${pk} ;;
  }

#######################
### Original Dimensions
#######################

  dimension: address {
    type: string
    sql: ${TABLE}.address ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: coid_name {
    type: string
    sql: ${TABLE}.coid_name ;;
  }

  dimension: cons_facility_name {
    type: string
    sql: ${TABLE}.cons_facility_name ;;
  }

  dimension: county {
    type: string
    sql: ${TABLE}.county ;;
  }

  dimension: division_code {
    type: number
    sql: ${TABLE}.division_code ;;
  }

  dimension: division_name {
    type: string
    sql: ${TABLE}.division_name ;;
  }

  dimension: facility_full {
    type: string
    sql: ${TABLE}.facility_full ;;
  }

  dimension: facility_id {
    type: number
    sql: ${TABLE}.facility_id ;;
  }

  dimension: facility_name {
    type: string
    sql: ${TABLE}.facility_name ;;
  }

  dimension: group_code {
    type: number
    sql: ${TABLE}.group_code ;;
  }

  dimension: group_name {
    type: string
    sql: ${TABLE}.group_name ;;
  }

  dimension: lat {
    type: number
    sql: ${TABLE}.lat ;;
  }

  dimension: long {
    type: number
    sql: ${TABLE}.long ;;
  }

  dimension: market_code {
    type: number
    sql: ${TABLE}.market_code ;;
  }

  dimension: market_name {
    type: string
    sql: ${TABLE}.market_name ;;
  }

  dimension: postal_code {
    type: number
    sql: ${TABLE}.postal_code ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

#######################
### Derived Dimensions
#######################

#######################
### Measures
#######################

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      group_name,
      facility_name,
      market_name,
      cons_facility_name,
      division_name,
      coid_name
    ]
  }
}
