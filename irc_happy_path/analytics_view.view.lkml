view: analytics_view {
  # Note: this URL out of date but mostly right
  # URL: https://experiment-demoexpo.dev.looker.com/explore/case_management_denials/fact_patient_test?qid=MEp1a0aHZQUS9a6u7x75Cf&toggle=fil
  derived_table: {
    persist_for: "700 hour"
    explore_source: fact_patient_test {

      column: patient_dw_id {}
      column: coid {}

      column: admission_raw {}
      column: discharge_raw {}
      column: min_origination_dates { field: denials_eom.min_origination_dates }
      column: most_recent_payment_raw { field: most_recent_pay.most_recent_payment_raw }

      column: esl_level_1_desc { field: patient_esl_test.esl_level_1_desc }
      column: esl_level_2_desc { field: patient_esl_test.esl_level_2_desc }
      column: esl_level_3_desc { field: patient_esl_test.esl_level_3_desc }
      column: esl_level_4_desc { field: patient_esl_test.esl_level_4_desc }
      column: esl_level_5_code { field: patient_esl_test.esl_level_5_code }
      column: esl_level_5_desc { field: patient_esl_test.esl_level_5_desc }

      column: group_name { field: facility_dim.group_name }
      column: market_name { field: facility_dim.market_name }
      column: division_name { field: facility_dim.division_name }
      column: facility_name { field: facility_dim.facility_name }
      column: lat { field: facility_dim.lat }
      column: long { field: facility_dim.long }

      column: total_payments {}
      column: total_account_balance_amt {}

    }
  }

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

  ### IDs

  dimension: patient_dw_id {
    group_label: "ID"
  }
  dimension: coid {
    group_label: "ID"
    type: number
  }

  ### Dates

  dimension_group: admission {
    label: "Dt - Admission"
    type: time
    timeframes: [
      raw,
      date,
      month,
      quarter,
      year
    ]
    datatype: date
    sql: ${TABLE}.admission_raw ;;
  }
  dimension_group: discharge {
    label: "Dt - Discharge"
    type: time
    timeframes: [
      raw,
      date,
      month,
      year
    ]
    datatype: date
    sql: ${TABLE}.discharge_raw ;;
  }

  dimension_group: first_denial {
    label: "Dt - 1st Denial"
    type: time
    timeframes: [
      raw,
      date,
      month,
      year
    ]
    datatype: date
    sql: ${TABLE}.min_origination_dates ;;
  }

  dimension_group: most_recent_payment {
    label: "Dt - 1st Denial"
    type: time
    timeframes: [
      raw,
      date,
      month,
      year
    ]
    datatype: date
    sql: ${TABLE}.most_recent_payment_raw ;;
  }

### Hierarchy DRG

  dimension: esl_level_1_desc {
    group_label: "Hierarchy DRG"
    label: "L1 In vs Outpatient"
    drill_fields: [esl_level_2_desc, esl_level_3_desc, division_name, market_name, facility_name]
  }
  dimension: esl_level_2_desc {
    group_label: "Hierarchy DRG"
    label: "L2 Service Line"
    drill_fields: [esl_level_3_desc, esl_level_4_desc, division_name, market_name, facility_name]
  }
  dimension: esl_level_3_desc {
    group_label: "Hierarchy DRG"
    label: "L3 DRG Superfamily"
    drill_fields: [esl_level_4_desc, esl_level_5_desc, division_name, market_name, facility_name]
  }
  dimension: esl_level_4_desc {
    group_label: "Hierarchy DRG"
    label: "L4 DRG Family"
    drill_fields: [esl_level_5_desc, division_name, market_name, facility_name]
  }
  dimension: esl_level_5_code {
    group_label: "Hierarchy DRG"
    label: "xL5 DRG Code"
  }
  dimension: esl_level_5_desc {
    group_label: "Hierarchy DRG"
    label: "L5 DRG Name"
    drill_fields: [division_name, market_name, facility_name]
  }

### Hierarchy Facility

  dimension: enterprise_name {
    group_label: "Hierarchy Facility"
    label: "1 Enterprise"
    type: string
    sql: 'HCA' ;;
    drill_fields: [group_name, division_name]
  }
  dimension: group_name {
    group_label: "Hierarchy Facility"
    label: "2 Group"
    drill_fields: [division_name, market_name, esl_level_3_desc, esl_level_4_desc, esl_level_5_desc]
  }
  dimension: division_name {
    group_label: "Hierarchy Facility"
    label: "3 Division"
    drill_fields: [market_name, facility_name, esl_level_3_desc, esl_level_4_desc, esl_level_5_desc]
    sql: left(${TABLE}.division_name, length(${TABLE}.division_name) - 9) ;;
  }
  dimension: market_name {
    group_label: "Hierarchy Facility"
    label: "4 Market"
    drill_fields: [facility_name, esl_level_3_desc, esl_level_4_desc, esl_level_5_desc]
  }
  dimension: facility_name {
    group_label: "Hierarchy Facility"
    label: "5 Facility Name"
    drill_fields: [facility_name, esl_level_3_desc, esl_level_4_desc, esl_level_5_desc]
  }
  dimension: lat {
    hidden: yes
    type: number
  }
  dimension: long {
    hidden: yes
    type: number
  }
  dimension: location {
    group_label: "Hierarchy Facility"
    type: location
    sql_latitude: ${lat} ;;
    sql_longitude: ${long} ;;
  }

### KPIs (as dimensions)

  dimension: total_account_balance_amt {
    group_label: "KPIs"
    type: number
    value_format_name: usd
  }
  dimension: total_payments {
    group_label: "KPIs"
    type: number
    value_format_name: usd
  }
  dimension: total_owed {
    group_label: "KPIs"
    type: number
    sql: ${total_account_balance_amt} + ${total_payments} ;;
    value_format_name: usd
  }

#######################
### Derived Dimensions
#######################

### Time to Get Paid

  dimension: days_to_get_paid {
    group_label: "Happy Score - Subcomponents"
    type: number
    sql: DATE_DIFF(${most_recent_payment_date}, ${admission_date}, day) ;;
  }

  dimension: days_to_get_paid_buckets {
    group_label: "Happy Score - Subcomponents"
    type: number
    sql:
      case
        when ${days_to_get_paid} is null then 0
        when ${days_to_get_paid} < 0 then 0
        when ${days_to_get_paid} > 300 then 300
        else round(${days_to_get_paid} / 20,0)*20
      end
     ;;
  }

### Denial

  dimension: denial_status {
    group_label: "Happy Score - Subcomponents"
    type: string
    sql:
      case
        when ${first_denial_raw} is null then 'A - Not Denied'
        else 'B - Denied'
      end ;;
  }

  dimension: days_between_denial_and_discharge {
    group_label: "Happy Score - Subcomponents"
    type: number
    sql: DATE_DIFF(${first_denial_date}, ${discharge_date}, day) ;;
  }

  dimension: denial_type {
    group_label: "Happy Score - Subcomponents"
    type: string
    sql:
      case
        when ${denial_status} = 'A - Not Denied' then ${denial_status}
        when ${days_between_denial_and_discharge} < 0 then 'B - Concurrent'
        when ${days_between_denial_and_discharge} < 2 then 'C - <2 After Discharge'
        else 'D - 2+ After Discharge'
      end
    ;;
  }

  dimension: sort {
    group_label: "Happy Score - Subcomponents"
    type: string
    sql: ${denial_status} || '-' || ${denial_type} || '-' || ${percent_paidback_dim_buckets_string} ;;
  }

### Payback

  dimension: percent_paidback_dim_buckets {
    group_label: "Happy Score - Subcomponents"
    type: number
    sql:
      case
        when ${percent_paidback_dim} is null then 0
        when ${percent_paidback_dim} < 0 then 0
        when ${percent_paidback_dim} > 1 then 1
        else round(${percent_paidback_dim} / 2,1) * 2
      end ;;
    value_format_name: percent_0
  }

  dimension: percent_paidback_dim_buckets_string {
    group_label: "Happy Score - Subcomponents"
    type: string
    sql:
      case
        when ${percent_paidback_dim_buckets} = 0 then 'F 0%'
        when ${percent_paidback_dim_buckets} = 0.2 then 'E 20%'
        when ${percent_paidback_dim_buckets} = 0.4 then 'D 40%'
        when ${percent_paidback_dim_buckets} = 0.6 then 'C 60%'
        when ${percent_paidback_dim_buckets} = 0.8 then 'B 80%'
        else 'A 100%'
      end
        ;;
  }

### Happy Score

  dimension: percent_paidback_dim {
    group_label: "Happy Score"
    type: number
    sql: coalesce(${total_payments} / nullif(${total_owed},0),0) ;;
    value_format_name: decimal_1
  }

  dimension: percent_non_denial_dim {
    group_label: "Happy Score"
    type: number
    sql: case when ${first_denial_raw} is null then 1 else 0 end ;;
    value_format_name: decimal_1
  }

  dimension: percent_timely_payment_dim {
    group_label: "Happy Score"
    type: number
    sql:
      case
        when ${days_to_get_paid} is null then 0
        when ${days_to_get_paid} < 0 then 1
        when ${days_to_get_paid} > 300 then 0
        else (300 - ${days_to_get_paid})/300
      end
    ;;
    value_format_name: decimal_1
  }

#######################
### Measures
#######################

  set: drill {
    fields: [
      admission_date
      , market_name
      , facility_name
      , esl_level_3_desc
      , esl_level_4_desc
      , days_to_get_paid
      , happy_score
      , percent_paidback
      , percent_non_denial
      , percent_timely_payback
    ]
  }

  measure: count {
    label: "Count Encounters"
    type: count
    drill_fields: [drill*]
  }

  measure: average_days_to_get_paid {
    type: average
    sql: ${days_to_get_paid} ;;
    value_format_name: decimal_1
    drill_fields: [drill*]
  }

  measure: sum_payments {
    type: sum
    sql: ${total_payments} ;;
    value_format_name: usd_0
    drill_fields: [drill*]
  }

  measure: sum_owed {
    type: sum
    sql: ${total_owed} ;;
    value_format_name: usd_0
    drill_fields: [drill*]
  }

  measure: average_owed {
    type: average
    sql: ${total_owed} ;;
    value_format_name: usd_0
    drill_fields: [drill*]
  }

### Happy Score

  measure: percent_paidback {
    group_label: "Happy Score"
    label: "1 % Paidback"
    type: number
    sql: ${sum_payments} / nullif(${sum_owed},0) ;;
    value_format_name: percent_1
    html:
      {% if value > 0.9 %}
      <span style="color:#009933;">{{ rendered_value }}</span>
      {% elsif value > 0.8 %}
      <span style="color:#99e600;">{{ rendered_value }}</span>
      {% elsif value > 0.7 %}
      <span style="color:#ffcc66;">{{ rendered_value }}</span>
      {% elsif value > 0.6 %}
      <span style="color:#e67300;">{{ rendered_value }}</span>
      {% else %}
      <span style="color:red;">{{ rendered_value }}</span>
      {% endif %}
    ;;
    drill_fields: [drill*]
  }
  measure: percent_non_denial {
    group_label: "Happy Score"
    label: "2 Non Denial"
    type: average
    sql: ${percent_non_denial_dim} ;;
    value_format_name: percent_1
    html:
      {% if value > 0.9 %}
      <span style="color:#009933;">{{ rendered_value }}</span>
      {% elsif value > 0.8 %}
      <span style="color:#99e600;">{{ rendered_value }}</span>
      {% elsif value > 0.7 %}
      <span style="color:#ffcc66;">{{ rendered_value }}</span>
      {% elsif value > 0.6 %}
      <span style="color:#e67300;">{{ rendered_value }}</span>
      {% else %}
      <span style="color:red;">{{ rendered_value }}</span>
      {% endif %}
    ;;
    drill_fields: [drill*]
  }
  measure: percent_timely_payback {
    group_label: "Happy Score"
    label: "3 Timely Payback"
    type: average
    sql: ${percent_timely_payment_dim} ;;
    value_format_name: percent_1
    html:
      {% if value > 0.9 %}
      <span style="color:#009933;">{{ rendered_value }} ({{ average_days_to_get_paid._rendered_value }} Days)</span>
      {% elsif value > 0.8 %}
      <span style="color:#99e600;">{{ rendered_value }} ({{ average_days_to_get_paid._rendered_value }} Days)</span>
      {% elsif value > 0.7 %}
      <span style="color:#ffcc66;">{{ rendered_value }} ({{ average_days_to_get_paid._rendered_value }} Days)</span>
      {% elsif value > 0.6 %}
      <span style="color:#e67300;">{{ rendered_value }} ({{ average_days_to_get_paid._rendered_value }} Days)</span>
      {% else %}
      <span style="color:red;">{{ rendered_value }} ({{ average_days_to_get_paid._rendered_value }} Days)</span>
      {% endif %}
    ;;
    drill_fields: [drill*]
  }
  parameter: weight_paidback {
    group_label: "Happy Score"
    type:  number
    default_value: "4"
  }
  parameter: weight_non_denial {
    group_label: "Happy Score"
    type:  number
    default_value: "3"
  }
  parameter: weight_timely_payback {
    group_label: "Happy Score"
    type:  number
    default_value: "2"
  }
  measure: happy_score {
    group_label: "Happy Score"
    label: "*Happy Score"
    type: number
    value_format_name: percent_1
    sql:
      (
            ${percent_paidback} *     {% parameter weight_paidback %}
        +   ${percent_non_denial} * {% parameter weight_non_denial %}
        +   ${percent_timely_payback} *  {% parameter weight_timely_payback %}
      )
      /
      nullif(
        (
          {% parameter weight_paidback %}
        + {% parameter weight_non_denial %}
        + {% parameter weight_timely_payback %}
        )
      ,0)
    ;;
    html:
      {% if value > 0.9 %}
      <span style="color:#009933;">{{ rendered_value }}</span>
      {% elsif value > 0.8 %}
      <span style="color:#99e600;">{{ rendered_value }}</span>
      {% elsif value > 0.7 %}
      <span style="color:#ffcc66;">{{ rendered_value }}</span>
      {% elsif value > 0.6 %}
      <span style="color:#e67300;">{{ rendered_value }}</span>
      {% else %}
      <span style="color:red;">{{ rendered_value }}</span>
      {% endif %}
    ;;
    drill_fields: [drill*]
  }

######################
### CV Demo
######################

### Doctor ID -- fake addition for cardiovascular use case

  dimension: doctor_id {
    view_label: "Z - Cardiovascular Demo"
    type: string
    sql: 'Doctor ' || right(safe_cast(${coid} as string),1) || '-' || right(${patient_dw_id},2) ;;
    # sql: 'Doctor -' || right(${patient_dw_id},2) ;;
  }

  parameter: count_vs_cost {
    view_label: "Z - Cardiovascular Demo"
    type: unquoted
    default_value: "count"
    allowed_value: {label: "Count" value: "count"}
    allowed_value: {label: "Cost" value: "cost"}
  }

  set: cv_drill {
    fields: [
      admission_date
      , esl_level_3_desc
      , division_name
      , count
      , sum_owed
    ]
  }

  measure: cv_kpi {
    view_label: "Z - Cardiovascular Demo"
    type: number
    sql:
      {% if    count_vs_cost._parameter_value == 'count' %} ${count}
      {% elsif count_vs_cost._parameter_value == 'cost' %} ${sum_owed}
      {% else %} ${count}
      {% endif %}
    ;;
    html:
      <a href="#drillmenu" target="_self">
      {% if count_vs_cost._parameter_value == 'count' %} {{ count._rendered_value }}
      {% elsif count_vs_cost._parameter_value == 'cost' %} {{ sum_owed._rendered_value }}
      {% else %} {{ count._rendered_value }}
      {% endif %}
      </a>
      ;;
    drill_fields: [cv_drill*]
  }

######################
### Benchmarking Demo
######################

## Step 1: Create benchmark values for all dimensions to benchmark on

  parameter: bm_coid { view_label: "Z - BM Demo" type: string default_value: "out" allowed_value: {label: "In" value: "in"} allowed_value: {label: "Out" value: "out"} }
  dimension: bm_coid_value {hidden: yes view_label: "Z - BM Demo" type: string sql: case when {% parameter bm_coid %} = 'out' then 'x' else coalesce(safe_cast(${coid} as string),'unknown_') end ;; }

  parameter: bm_esl_level_1_desc { view_label: "Z - BM Demo" type: string default_value: "out" allowed_value: {label: "In" value: "in"} allowed_value: {label: "Out" value: "out"} }
  dimension: bm_esl_level_1_desc_value {hidden: yes view_label: "Z - BM Demo" type: string sql: case when {% parameter bm_esl_level_1_desc %} = 'out' then 'x' else coalesce(safe_cast(${esl_level_1_desc} as string),'unknown_') end ;; }

  parameter: bm_group_name { view_label: "Z - BM Demo" type: string default_value: "out" allowed_value: {label: "In" value: "in"} allowed_value: {label: "Out" value: "out"} }
  dimension: bm_group_name_value {hidden: yes view_label: "Z - BM Demo" type: string sql: case when {% parameter bm_group_name %} = 'out' then 'x' else coalesce(safe_cast(${group_name} as string),'unknown_') end ;; }

  parameter: bm_doctor_id { view_label: "Z - BM Demo" type: string default_value: "out" allowed_value: {label: "In" value: "in"} allowed_value: {label: "Out" value: "out"} }
  dimension: bm_doctor_id_value {hidden: yes view_label: "Z - BM Demo" type: string sql: case when {% parameter bm_doctor_id %} = 'out' then 'x' else coalesce(safe_cast(${doctor_id} as string),'unknown_') end ;; }

  dimension: bm_combined {
    view_label: "Z - BM Demo"
    type: string
    sql: ${bm_coid_value} || '-' || ${bm_esl_level_1_desc_value} || '-' || ${bm_group_name_value} || '-' || ${bm_doctor_id_value} ;;
  }

## Step 2: Create dimensions for all relevant KPIs

  dimension: denial_rate_dim {
    view_label: "Z - BM Demo"
    hidden: yes
    type: number
    sql: case when ${first_denial_raw} is null then 0 else 1 end ;;
    value_format_name: decimal_1
  }

  dimension: average_owed_dim {
    view_label: "Z - BM Demo"
    type: number
    sql: ${total_owed} ;;
    value_format_name: usd_0
  }

## Step 3: Create actual measures with different value types

  parameter: kpi_selector {
    view_label: "Z - BM Demo"
    type: unquoted
    default_value: "denial_rate"
    allowed_value: {label: "Denial %" value: "denial_rate"}
    allowed_value: {label: "Avg Owed" value: "average_owed"}
  }

  measure: bm_kpi_actual {
    view_label: "Z - BM Demo"
    type: average
    sql:
      {% if    kpi_selector._parameter_value == 'denial_rate' %}  ${denial_rate_dim}
      {% elsif kpi_selector._parameter_value == 'average_owed' %} ${average_owed_dim}
      {% else %}                                                  ${denial_rate_dim}
      {% endif %}
    ;;
    html:
      <a href="#drillmenu" target="_self">
      {% if kpi_selector._parameter_value == 'denial_rate' %}     {{ bm_kpi_actual_percent1._rendered_value }}
      {% elsif kpi_selector._parameter_value == 'average_owed' %} {{ bm_kpi_actual_usd0._rendered_value }}
      {% else %}                                                  {{ bm_kpi_actual_percent1._rendered_value }}
      {% endif %}
      </a>
      ;;
    drill_fields: [cv_drill*]
  }

  measure: bm_kpi_actual_percent1 {
    hidden: yes
    type: number
    sql: ${bm_kpi_actual} ;;
    value_format_name: percent_1
  }

  measure: bm_kpi_actual_usd0 {
    hidden: yes
    type: number
    sql: ${bm_kpi_actual} ;;
    value_format_name: usd_0
  }

## Step 4: Create expected measure with different value types

  dimension: bm_kpi_expected_dim {
    view_label: "Z - BM Demo"
    type: number
    sql: ${benchmark_table.bm_kpi_expected} ;;
  }

  measure: bm_kpi_expected {
    view_label: "Z - BM Demo"
    type: average
    sql: ${bm_kpi_expected_dim} ;;
    html:
      <a href="#drillmenu" target="_self">
      {% if kpi_selector._parameter_value == 'denial_rate' %}     {{ bm_kpi_expected_percent1._rendered_value }}
      {% elsif kpi_selector._parameter_value == 'average_owed' %} {{ bm_kpi_expected_usd0._rendered_value }}
      {% else %}                                                  {{ bm_kpi_expected_percent1._rendered_value }}
      {% endif %}
      </a>
      ;;
    drill_fields: [cv_drill*]
  }

  measure: bm_kpi_expected_percent1 {
    hidden: yes
    type: number
    sql: ${bm_kpi_expected} ;;
    value_format_name: percent_1
  }

  measure: bm_kpi_expected_usd0 {
    hidden: yes
    type: number
    sql: ${bm_kpi_expected} ;;
    value_format_name: usd_0
  }

## Step 5: Calculate abs & percent difference

  measure: bm_kpi_actual_vs_expected_abs {
    view_label: "Z - BM Demo"
    type: number
    sql: ${bm_kpi_actual} - ${bm_kpi_expected} ;;
    html:
    <a href="#drillmenu" target="_self">
      {% if kpi_selector._parameter_value == 'denial_rate' %}     {{ bm_kpi_actual_vs_expected_abs_percent1._rendered_value }} ({{ bm_kpi_actual_percent1._rendered_value }} vs {{ bm_kpi_expected_percent1._rendered_value }})
      {% elsif kpi_selector._parameter_value == 'average_owed' %} {{ bm_kpi_actual_vs_expected_abs_usd0._rendered_value }} ({{ bm_kpi_actual_usd0._rendered_value }} vs {{ bm_kpi_expected_usd0._rendered_value }})
      {% else %}                                                  {{ bm_kpi_actual_vs_expected_abs_percent1._rendered_value }} ({{ bm_kpi_actual_percent1._rendered_value }} vs {{ bm_kpi_expected_percent1._rendered_value }})
      {% endif %}
    </a>
    ;;
    drill_fields: [cv_drill*]
  }

  measure: bm_kpi_actual_vs_expected_abs_percent1 {
    hidden: yes
    type: number
    sql: ${bm_kpi_actual_vs_expected_abs} ;;
    value_format_name: percent_1
  }

  measure: bm_kpi_actual_vs_expected_abs_usd0 {
    hidden: yes
    type: number
    sql: ${bm_kpi_actual_vs_expected_abs} ;;
    value_format_name: usd_0
  }

  measure: bm_kpi_actual_vs_expected_perc {
    view_label: "Z - BM Demo"
    type: number
    sql: ${bm_kpi_actual_vs_expected_abs} / nullif(${bm_kpi_actual},0) ;;
    value_format_name: percent_1
    drill_fields: [cv_drill*]
  }

## Step 6: Calculate size of cohorts

  dimension: x {
    view_label: "Z - BM Demo"
    type: string
    sql: 'x' ;;
  }

  dimension: cohort_size {
    hidden: yes
    type: number
    sql: ${benchmark_table.count} ;;
  }

  measure: cohort_size_05 {
    view_label: "Z - BM Demo"
    type: percentile
    sql: ${cohort_size} ;;
    percentile: 5
  }

  measure: cohort_size_25 {
    view_label: "Z - BM Demo"
    type: percentile
    sql: ${cohort_size} ;;
    percentile: 25
  }

  measure: cohort_size_50 {
    view_label: "Z - BM Demo"
    type: percentile
    sql: ${cohort_size} ;;
    percentile: 50
  }

  measure: cohort_size_75 {
    view_label: "Z - BM Demo"
    type: percentile
    sql: ${cohort_size} ;;
    percentile: 75
  }

  measure: cohort_size_95 {
    view_label: "Z - BM Demo"
    type: percentile
    sql: ${cohort_size} ;;
    percentile: 95
  }

######################
### Benchmarking Demo 2
######################

### How to Benchmark
  parameter: bm_coid2 { view_label: "Z - BM Demo 2" type: string default_value: "out" allowed_value: {label: "In" value: "in"} allowed_value: {label: "Out" value: "out"} }
  dimension: bm_coid_value2 {hidden: yes view_label: "Z - BM Demo 2" type: string sql: case when {% parameter bm_coid2 %} = 'out' then 'x' else coalesce(safe_cast(${coid} as string),'unknown_') end ;; }

  parameter: bm_esl_level_1_desc2 { view_label: "Z - BM Demo 2" type: string default_value: "out" allowed_value: {label: "In" value: "in"} allowed_value: {label: "Out" value: "out"} }
  dimension: bm_esl_level_1_desc_value2 {hidden: yes view_label: "Z - BM Demo 2" type: string sql: case when {% parameter bm_esl_level_1_desc2 %} = 'out' then 'x' else coalesce(safe_cast(${esl_level_1_desc} as string),'unknown_') end ;; }

  parameter: bm_group_name2 { view_label: "Z - BM Demo 2" type: string default_value: "out" allowed_value: {label: "In" value: "in"} allowed_value: {label: "Out" value: "out"} }
  dimension: bm_group_name_value2 {hidden: yes view_label: "Z - BM Demo 2" type: string sql: case when {% parameter bm_group_name2 %} = 'out' then 'x' else coalesce(safe_cast(${group_name} as string),'unknown_') end ;; }

  parameter: bm_doctor_id2 { view_label: "Z - BM Demo 2" type: string default_value: "out" allowed_value: {label: "In" value: "in"} allowed_value: {label: "Out" value: "out"} }
  dimension: bm_doctor_id_value2 {hidden: yes view_label: "Z - BM Demo 2" type: string sql: case when {% parameter bm_doctor_id2 %} = 'out' then 'x' else coalesce(safe_cast(${doctor_id} as string),'unknown_') end ;; }

  dimension: bm_combined2 {
    view_label: "Z - BM Demo 2"
    type: string
    sql: ${bm_coid_value2} || '-' || ${bm_esl_level_1_desc_value2} || '-' || ${bm_group_name_value2} || '-' || ${bm_doctor_id_value2} ;;
  }

### What to Compare

  parameter: compare_selector {
    view_label: "Z - BM Demo 2"
    label: "Values Selector"
    type: unquoted
    default_value: "market"
    allowed_value: {label: "Hospital" value: "facility_name"}
    allowed_value: {label: "Market" value: "market_name"}
    allowed_value: {label: "Division" value: "division_name"}
    allowed_value: {label: "DRG Service Line" value: "esl_level_2_desc"}
    allowed_value: {label: "DRG Super Family" value: "esl_level_3_desc"}
  }

  dimension: compare_values {
    view_label: "Z - BM Demo 2"
    label: "Values Selection"
    type: string
    sql:
      {% if    compare_selector._parameter_value == 'facility_name' %}    ${facility_name}
      {% elsif compare_selector._parameter_value == 'market_name' %}      ${market_name}
      {% elsif compare_selector._parameter_value == 'division_name' %}    ${division_name}
      {% elsif compare_selector._parameter_value == 'esl_level_2_desc' %} ${esl_level_2_desc}
      {% elsif compare_selector._parameter_value == 'esl_level_3_desc' %} ${esl_level_3_desc}
      {% else %}                                                          ${facility_name}
      {% endif %}
    ;;
    drill_fields: [facility_name, market_name, division_name, esl_level_2_desc, esl_level_3_desc, esl_level_4_desc]
  }

### Create filters

  parameter: is_concurrent_denial_param {
    view_label: "Z - BM Demo 2"
    type: unquoted
    default_value: "no"
    allowed_value: {label: "Yes" value: "yes"}
    allowed_value: {label: "No" value: "no"}
  }

  parameter: is_p2p_param {
    view_label: "Z - BM Demo 2"
    type: unquoted
    default_value: "no"
    allowed_value: {label: "Yes" value: "yes"}
    allowed_value: {label: "No" value: "no"}
  }

  parameter: is_pdu_param {
    view_label: "Z - BM Demo 2"
    type: unquoted
    default_value: "no"
    allowed_value: {label: "Yes" value: "yes"}
    allowed_value: {label: "No" value: "no"}
  }

  dimension: is_concurrent_denial {
    hidden: yes
    type: yesno
    sql: ${percent_paidback_dim} < 0.7 or ${percent_paidback_dim} > 1.3 or ${percent_paidback_dim} is null ;;
  }

  dimension: is_concurrent_denial_not {
    hidden: yes
    type: yesno
    sql: ${percent_paidback_dim} BETWEEN 0.7 and 1.3 ;;
  }

  dimension: is_p2p {
    hidden: yes
    type: yesno
    sql: ${days_to_get_paid} > 150 ;;
  }

  dimension: is_p2p_not {
    hidden: yes
    type: yesno
    sql: ${days_to_get_paid} < 150 or ${days_to_get_paid} is null ;;
  }

  dimension: is_pdu {
    hidden: yes
    type: yesno
    sql: ${first_denial_raw} is not null ;;
  }

  dimension: is_pdu_not {
    hidden: yes
    type: yesno
    sql: ${first_denial_raw} is null ;;
  }

  dimension: is_concurrent_denial_with_param {
    hidden: yes
    type: yesno
    sql:
      {% if is_concurrent_denial_param._parameter_value == 'yes' %} ${is_concurrent_denial}
      {% else %} ${is_concurrent_denial_not}
      {% endif %}
    ;;
  }

  dimension: is_p2p_with_param {
    hidden: yes
    type: yesno
    sql:
      {% if is_p2p_param._parameter_value == 'yes' %} ${is_p2p}
      {% else %} ${is_p2p_not}
      {% endif %}
    ;;
  }

  dimension: is_pdu_with_param {
    hidden: yes
    type: yesno
    sql:
      {% if is_pdu_param._parameter_value == 'yes' %} ${is_pdu}
      {% else %} ${is_pdu_not}
      {% endif %}
    ;;
  }

  dimension: is_in_filtered_group {
    view_label: "Z - BM Demo 2"
    type: yesno
    sql: ${is_concurrent_denial_with_param} and ${is_p2p_with_param} and ${is_pdu_with_param} ;;
  }

  parameter: status_param {
    view_label: "Z - BM Demo 2"
    type: unquoted
    default_value: "1s"
    allowed_value: {label: "1 - All Clear" value: "1s"}
    allowed_value: {label: "2 - Conc Denial Only" value: "2s"}
    allowed_value: {label: "3 - Conc Denial & P2P Only" value: "3s"}
    allowed_value: {label: "4 - Conc, P2P, and PDU" value: "4s"}
  }

  dimension: status {
    view_label: "Z - BM Demo 2"
    type: string
    sql:
      case
        when ${is_concurrent_denial_not} then '1 - All Clear'
        when ${is_concurrent_denial} and ${is_p2p_not} then '2 - Conc Denial Only'
        when ${is_concurrent_denial} and ${is_p2p} and ${is_pdu_not} then '3 - Conc Denial & P2P Only'
        else '4 - Conc, P2P, and PDU'
      end
    ;;
  }

  dimension: is_status_with_param {
    view_label: "Z - BM Demo 2"
    hidden: yes
    type: yesno
    sql:
      {% if status_param._parameter_value == '1s' %}    ${status} = '1 - All Clear'
      {% elsif status_param._parameter_value == '2s' %} ${status} = '2 - Conc Denial Only'
      {% elsif status_param._parameter_value == '3s' %} ${status} = '3 - Conc Denial & P2P Only'
      {% elsif status_param._parameter_value == '4s' %} ${status} = '4 - Conc, P2P, and PDU'
      {% else %}                                        ${status} = '1 - All Clear'
      {% endif %}
    ;;
  }

### Create initial KPIs

  measure: count_in_filtered_group {
    view_label: "Z - BM Demo 2"
    group_label: "Initial KPI"
    type: count
    filters: [is_status_with_param: "Yes"]
  }

  measure: sum_owed_in_filtered_group {
    view_label: "Z - BM Demo 2"
    group_label: "Initial KPI"
    type: sum
    sql: ${total_owed} ;;
    filters: [is_status_with_param: "Yes"]
    value_format_name: usd_0
  }

  measure: count_in_filtered_group_percent {
    view_label: "Z - BM Demo 2"
    group_label: "Initial KPI"
    type: number
    sql: ${count_in_filtered_group} / nullif(${count},0) ;;
    value_format_name: percent_1
  }

  measure: sum_owed_in_filtered_group_percent {
    view_label: "Z - BM Demo 2"
    group_label: "Initial KPI"
    type: number
    sql: ${sum_owed_in_filtered_group} / nullif(${sum_owed},0) ;;
    value_format_name: percent_1
  }

  parameter: count_vs_cost_bm2 {
    view_label: "Z - BM Demo 2"
    label: "KPI Selector"
    type: unquoted
    default_value: "count"
    allowed_value: {label: "Count" value: "count"}
    allowed_value: {label: "Cost" value: "cost"}
  }

  measure: bm_kpi_actual2_raw {
    view_label: "Z - BM Demo 2"
    label: "0 - Actual (Raw)"
    type: number
    sql:
      {% if    count_vs_cost_bm2._parameter_value == 'count' %} ${count}
      {% elsif count_vs_cost_bm2._parameter_value == 'cost' %} ${sum_owed}
      {% else %} ${count}
      {% endif %}
    ;;
    value_format_name: decimal_1
    drill_fields: [cv_drill*]
  }

  measure: bm_kpi_actual2 {
    view_label: "Z - BM Demo 2"
    label: "1 - Actual"
    type: number
    sql:
      {% if    count_vs_cost_bm2._parameter_value == 'count' %} ${count_in_filtered_group_percent}
      {% elsif count_vs_cost_bm2._parameter_value == 'cost' %} ${sum_owed_in_filtered_group_percent}
      {% else %} ${count_in_filtered_group_percent}
      {% endif %}
    ;;
    value_format_name: percent_1
    drill_fields: [cv_drill*]
  }

### Expected

  dimension: bm_kpi_expected_dim2 {
    view_label: "Z - BM Demo 2"
    type: number
    sql: ${benchmark_table2.bm_kpi_expected2} ;;
  }

  measure: bm_kpi_expected2 {
    view_label: "Z - BM Demo 2"
    label: "2 - Expected"
    type: average
    sql: ${bm_kpi_expected_dim2} ;;
    value_format_name: percent_1
    drill_fields: [cv_drill*]
  }


## Step 5: Calculate abs & percent difference

  measure: bm_kpi_actual_vs_expected_abs2 {
    view_label: "Z - BM Demo 2"
    label: "3 - Act vs Exp (Abs)"
    type: number
    sql: ${bm_kpi_actual2} - ${bm_kpi_expected2} ;;
    value_format_name: percent_1
    drill_fields: [cv_drill*]
  }

  measure: bm_kpi_actual_vs_expected_perc2 {
    view_label: "Z - BM Demo 2"
    label: "4 - Act vs Exp (%)"
    type: number
    sql: ${bm_kpi_actual_vs_expected_abs2} / nullif(${bm_kpi_actual2},0) ;;
    value_format_name: percent_1
    drill_fields: [cv_drill*]
  }

}

view: benchmark_table {
  derived_table: {
    explore_source: analytics_view {
      bind_all_filters: yes
      column: bm_combined {}
      column: bm_kpi_actual {}
      column: count {}
    }
  }
  dimension: bm_combined {
    primary_key: yes
    type: string
    hidden: yes
  }
  dimension: bm_kpi_expected {
    hidden: yes
    type: number
    sql: ${TABLE}.bm_kpi_actual ;;
  }
  dimension: count {
    hidden: yes
    type: number
  }
}

view: benchmark_table2 {
  derived_table: {
    explore_source: analytics_view {
      bind_all_filters: yes
      column: bm_combined2 {}
      column: bm_kpi_actual2 {}
      column: count {}
    }
  }
  dimension: bm_combined2 {
    primary_key: yes
    type: string
    hidden: yes
  }
  dimension: bm_kpi_expected2 {
    hidden: yes
    type: number
    sql: ${TABLE}.bm_kpi_actual2 ;;
  }
  dimension: count {
    hidden: yes
    type: number
  }
}

view: newui_kpi_list {

  derived_table: {
    datagroup_trigger: once_daily
    sql:
    SELECT 'KPI 1' AS anomaly_name,1 AS datapoint,0.4143508771 AS threshold_over UNION ALL
    SELECT 'KPI 2',2,0.4097222824 UNION ALL
    SELECT 'KPI 3',3,0.3691764848 UNION ALL
    SELECT 'KPI 4',4,0.1964271376 UNION ALL
    SELECT 'KPI 5',4,0.1964271376 UNION ALL
    SELECT 'KPI 6',4,0.1964271376 UNION ALL
    SELECT 'KPI 7',4,0.1964271376 UNION ALL
    SELECT 'KPI 8',4,0.1964271376
  ;;
  }

}

view: newui_anomaly {
  dimension: anomaly_name {
    type: string
  }
  dimension: datapoint {
    type: number
  }
  dimension: threshold_over {
    type: number
  }
  parameter: over_threshold {
    type: number
    default_value: "25"
  }
  dimension: is_over_threshold {
    type: yesno
    sql: ${threshold_over} * 100 > {% parameter ${over_threshold} %}  ;;
  }
  measure: count_over_threshold {
    type: count
    filters: [is_over_threshold: "yes"]
  }
  measure: count {
    type: count
  }
  measure: percent_over_threshold {
    type: number
    sql: ${count_over_threshold} / nullif(${count},0) ;;
    value_format_name: percent_1
  }
  measure: threshold_value {
    type: average
    sql: ${datapoint} * 100 * rand() ;;
  }

  derived_table: {
    datagroup_trigger: once_daily
    sql:
SELECT 'Anamoly 1' AS anomaly_name,1 AS datapoint,0.4143508771 AS threshold_over UNION ALL
SELECT 'Anamoly 1',2,0.4097222824 UNION ALL
SELECT 'Anamoly 1',3,0.3691764848 UNION ALL
SELECT 'Anamoly 1',4,0.1964271376 UNION ALL
SELECT 'Anamoly 1',5,0.3022145061 UNION ALL
SELECT 'Anamoly 1',6,0.07376454185 UNION ALL
SELECT 'Anamoly 1',7,0.324297329 UNION ALL
SELECT 'Anamoly 1',8,0.1846505073 UNION ALL
SELECT 'Anamoly 1',9,0.354744215 UNION ALL
SELECT 'Anamoly 2',1,0.348164285 UNION ALL
SELECT 'Anamoly 2',2,0.1560391589 UNION ALL
SELECT 'Anamoly 2',3,0.1401565774 UNION ALL
SELECT 'Anamoly 2',4,0.1674346844 UNION ALL
SELECT 'Anamoly 2',5,0.3165840461 UNION ALL
SELECT 'Anamoly 2',6,0.08143650064 UNION ALL
SELECT 'Anamoly 2',7,0.2600543725 UNION ALL
SELECT 'Anamoly 2',8,0.3333047026 UNION ALL
SELECT 'Anamoly 2',9,0.3087028734 UNION ALL
SELECT 'Anamoly 3',1,0.06822077733 UNION ALL
SELECT 'Anamoly 3',2,0.1297041271 UNION ALL
SELECT 'Anamoly 3',3,0.1889199004 UNION ALL
SELECT 'Anamoly 3',4,0.2813022736 UNION ALL
SELECT 'Anamoly 3',5,0.2663980594 UNION ALL
SELECT 'Anamoly 3',6,0.0815074301 UNION ALL
SELECT 'Anamoly 3',7,0.357010984 UNION ALL
SELECT 'Anamoly 3',8,0.008453644544 UNION ALL
SELECT 'Anamoly 3',9,0.0673450375 UNION ALL
SELECT 'Anamoly 4',1,0.2205109588 UNION ALL
SELECT 'Anamoly 4',2,0.09137042108 UNION ALL
SELECT 'Anamoly 4',3,0.1952565519 UNION ALL
SELECT 'Anamoly 4',4,0.2770252847 UNION ALL
SELECT 'Anamoly 4',5,0.2894209005 UNION ALL
SELECT 'Anamoly 4',6,0.02288241553 UNION ALL
SELECT 'Anamoly 4',7,0.2856230942 UNION ALL
SELECT 'Anamoly 4',8,0.003312837422 UNION ALL
SELECT 'Anamoly 4',9,0.02341604156 UNION ALL
SELECT 'Anamoly 5',1,0.09629355013 UNION ALL
SELECT 'Anamoly 5',2,0.2729277831 UNION ALL
SELECT 'Anamoly 5',3,0.06097046906 UNION ALL
SELECT 'Anamoly 5',4,0.08553731221 UNION ALL
SELECT 'Anamoly 5',5,0.290103016 UNION ALL
SELECT 'Anamoly 5',6,0.3596049868 UNION ALL
SELECT 'Anamoly 5',7,0.2656976672 UNION ALL
SELECT 'Anamoly 5',8,0.0212987961 UNION ALL
SELECT 'Anamoly 5',9,0.01723064991 UNION ALL
SELECT 'Anamoly 6',1,0.227006964 UNION ALL
SELECT 'Anamoly 6',2,0.1606214298 UNION ALL
SELECT 'Anamoly 6',3,0.0149811936 UNION ALL
SELECT 'Anamoly 6',4,0.2566489317 UNION ALL
SELECT 'Anamoly 6',5,0.1575976541 UNION ALL
SELECT 'Anamoly 6',6,0.07381480787 UNION ALL
SELECT 'Anamoly 6',7,0.1098811988 UNION ALL
SELECT 'Anamoly 6',8,0.2721160406 UNION ALL
SELECT 'Anamoly 6',9,0.2258294349 UNION ALL
SELECT 'Anamoly 7',1,0.3391776086 UNION ALL
SELECT 'Anamoly 7',2,0.3869193733 UNION ALL
SELECT 'Anamoly 7',3,0.3354327281 UNION ALL
SELECT 'Anamoly 7',4,0.08375080616 UNION ALL
SELECT 'Anamoly 7',5,0.2147089737 UNION ALL
SELECT 'Anamoly 7',6,0.127656707 UNION ALL
SELECT 'Anamoly 7',7,0.2067207284 UNION ALL
SELECT 'Anamoly 7',8,0.0761817897 UNION ALL
SELECT 'Anamoly 7',9,0.3323336645 UNION ALL
SELECT 'Anamoly 8',1,0.377627291 UNION ALL
SELECT 'Anamoly 8',2,0.427159918 UNION ALL
SELECT 'Anamoly 8',3,0.4714067775 UNION ALL
SELECT 'Anamoly 8',4,0.04641232914 UNION ALL
SELECT 'Anamoly 8',5,0.5033180568 UNION ALL
SELECT 'Anamoly 8',6,0.2748983386 UNION ALL
SELECT 'Anamoly 8',7,0.1939822982 UNION ALL
SELECT 'Anamoly 8',8,0.5004242905 UNION ALL
SELECT 'Anamoly 8',9,0.2904605557 UNION ALL
SELECT 'Anamoly 9',1,0.5037734436 UNION ALL
SELECT 'Anamoly 9',2,0.6247034706 UNION ALL
SELECT 'Anamoly 9',3,0.5654630609 UNION ALL
SELECT 'Anamoly 9',4,0.1029330791 UNION ALL
SELECT 'Anamoly 9',5,0.244818278 UNION ALL
SELECT 'Anamoly 9',6,0.4679731205 UNION ALL
SELECT 'Anamoly 9',7,0.5639424622 UNION ALL
SELECT 'Anamoly 9',8,0.4781387975 UNION ALL
SELECT 'Anamoly 9',9,0.4212911128

    ;;
  }


}

# view: test_x_list {
#   derived_table: {
#     persist_for: "24 hours"
#     sql:
#                 SELECT 1 as column_order, 'COID' as column_label, 'coid' as column_value
#       UNION ALL SELECT 2, 'L1 DRG', 'esl_level_1_desc'
#       UNION ALL SELECT 3, 'L2 DRG', 'esl_level_2_desc'
#       UNION ALL SELECT 4, 'L3 DRG', 'esl_level_3_desc'
#       UNION ALL SELECT 5, 'L4 DRG', 'esl_level_4_desc'
#       UNION ALL SELECT 6, 'L5 DRG', 'esl_level_5_desc'
#       UNION ALL SELECT 7, 'Group', 'group_name'
#       UNION ALL SELECT 8, 'Division', 'division_name'
#       UNION ALL SELECT 9, 'Market', 'market_name'
#       UNION ALL SELECT 10, 'Facility', 'facility_name'
#       UNION ALL SELECT 11, 'Doctor', 'doctor_id'
#     ;;
#   }

#   dimension: column_order {
#     view_label: "Z"
#     group_label: "Z"
#   }

#   dimension: column_label {
#     view_label: "Z"
#     group_label: "Z"
#   }

#   dimension: column_value {
#     view_label: "Z"
#     group_label: "Z"
#   }

#   filter: testx {
#     view_label: "Z"
#     group_label: "Z"
#     suggest_dimension: test_x_list.column_label
#     type: string
#   }

#   dimension: is_testx_dimension {
#     view_label: "Z"
#     group_label: "Z"
#     type: yesno
#     sql: {% condition testx %} ${test_x_list.column_label} {% endcondition %}
#       ;;
#   }

#   dimension: testx_dimension_pre {
#     view_label: "Z"
#     group_label: "Z"
#     type: string
#     sql:
#         case when ${is_testx_dimension} then ${test_x_list.column_value} else '' end
#       ;;
#   }
# }

# view: test_x_list_string_agg {
#   derived_table: {
#     explore_source: test_x_list {
#       bind_filters: {
#         from_field: test_x_list.testx
#         to_field: test_x_list.testx
#       }
#       column: testx_dimension_pre {}
#       filters: {
#         field: test_x_list.is_testx_dimension
#         value: "Yes"
#       }
#     }
#   }
#   dimension: testx_dimension_pre {
#     view_label: "Y"
#     group_label: "Y"
#   }
#   measure: testx_dimension_string_agg {
#     view_label: "Y"
#     group_label: "Y"
#     type: string
#     # sql: replace(string_agg(${testx_dimension_pre}),',',' || \'|\' || ') ;;
#     sql: replace(string_agg(distinct ${testx_dimension_pre}),',',' || \'|\' || ') ;;
#   }
# }

# view: test_x_list_string_agg_dimension {
#   derived_table: {
#     explore_source: test_x_list {
#       bind_filters: {
#         from_field: test_x_list.testx
#         to_field: test_x_list.testx
#       }
#       column: testx_dimension_string_agg { field: test_x_list_string_agg.testx_dimension_string_agg }
#       filters: {
#         field: test_x_list.is_testx_dimension
#         value: "Yes"
#       }
#     }
#   }
#   dimension: testx_dimension_string_agg {
#     view_label: "X"
#     group_label: "X"
#     type: string
#   }
# }


# # dimension: testx_dimension {
# #   view_label: "Z"
# #   group_label: "Z"
# #   type: string
# #   sql:
# #         case when ${is_testx_dimension} and ${test_x_list.column_value} = 'coid' then ${test_x_list.column_value} || ' || \'|\' || ' else '\'x\' || \'|\' || ' end
# #       || case when ${is_testx_dimension} and ${test_x_list.column_value} = 'esl_level_1_desc' then ${test_x_list.column_value} || ' || \'|\' || ' else '\'x\' || \'|\' || ' end
# #       || case when ${is_testx_dimension} and ${test_x_list.column_value} = 'esl_level_2_desc' then ${test_x_list.column_value} || ' || \'|\' || ' else '\'x\' || \'|\' || ' end
# #       || case when ${is_testx_dimension} and ${test_x_list.column_value} = 'esl_level_3_desc' then ${test_x_list.column_value} || ' || \'|\' || ' else '\'x\' || \'|\' || ' end
# #       || case when ${is_testx_dimension} and ${test_x_list.column_value} = 'esl_level_4_desc' then ${test_x_list.column_value} || ' || \'|\' || ' else '\'x\' || \'|\' || ' end
# #       || case when ${is_testx_dimension} and ${test_x_list.column_value} = 'esl_level_5_desc' then ${test_x_list.column_value} || ' || \'|\' || ' else '\'x\' || \'|\' || ' end
# #       || case when ${is_testx_dimension} and ${test_x_list.column_value} = 'group_name' then ${test_x_list.column_value} || ' || \'|\' || ' else '\'x\' || \'|\' || ' end
# #       || case when ${is_testx_dimension} and ${test_x_list.column_value} = 'division_name' then ${test_x_list.column_value} || ' || \'|\' || ' else '\'x\' || \'|\' || ' end
# #       || case when ${is_testx_dimension} and ${test_x_list.column_value} = 'market_name' then ${test_x_list.column_value} || ' || \'|\' || ' else '\'x\' || \'|\' || ' end
# #       || case when ${is_testx_dimension} and ${test_x_list.column_value} = 'facility_name' then ${test_x_list.column_value} || ' || \'|\' || ' else '\'x\' || \'|\' || ' end
# #       || case when ${is_testx_dimension} and ${test_x_list.column_value} = 'doctor_id' then ${test_x_list.column_value} else '\'x\'' end
# #       ;;
# # }


# # If necessary, uncomment the line below to include explore_source.
# # include: "case_management_denials.model.lkml"

# # view: add_a_unique_name_1677267747 {
# #   derived_table: {
# #     explore_source: test_x_list {
# #       column: testx_dimension_string_agg { field: test_x_list_string_agg.testx_dimension_string_agg }
# #       column: is_testx_dimension {}
# #       column: testx_dimension_pre {}
# #       column: column_value {}
# #       filters: {
# #         field: test_x_list.testx
# #         value: "COID,Group,L3 DRG"
# #       }
# #       filters: {
# #         field: test_x_list.column_value
# #         value: "\"facility_name\""
# #       }
# #     }
# #   }
# #   dimension: testx_dimension_string_agg {
# #     label: "Y Testx Dimension String Agg"
# #     description: ""
# #     type: number
# #   }
# #   dimension: is_testx_dimension {
# #     label: "Z Is Testx Dimension (Yes / No)"
# #     description: ""
# #     type: yesno
# #   }
# #   dimension: testx_dimension_pre {
# #     label: "Z Testx Dimension Pre"
# #     description: ""
# #   }
# #   dimension: column_value {
# #     label: "Z Column Value"
# #     description: ""
# #   }
# # }



# # If necessary, uncomment the line below to include explore_source.
# # include: "case_management_denials.model.lkml"

# # view: add_a_unique_name_1677267861 {
# #   derived_table: {
# #     explore_source: test_x_list {
# #       column: testx_dimension_string_agg { field: test_x_list_string_agg.testx_dimension_string_agg }
# #       column: testx_dimension_pre {}
# #       column: column_value {}
# #       column: is_testx_dimension {}
# #       filters: {
# #         field: test_x_list.testx
# #         value: "COID,Group,L3 DRG"
# #       }
# #       filters: {
# #         field: test_x_list.is_testx_dimension
# #         value: "Yes"
# #       }
# #     }
# #   }
# #   dimension: testx_dimension_string_agg {
# #     label: "Y Testx Dimension String Agg"
# #     description: ""
# #     type: number
# #   }
# #   dimension: testx_dimension_pre {
# #     label: "Z Testx Dimension Pre"
# #     description: ""
# #   }
# #   dimension: column_value {
# #     label: "Z Column Value"
# #     description: ""
# #   }
# #   dimension: is_testx_dimension {
# #     label: "Z Is Testx Dimension (Yes / No)"
# #     description: ""
# #     type: yesno
# #   }
# # }
