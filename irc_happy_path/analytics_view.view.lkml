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
      #column: most_recent_payment_raw { field: most_recent_pay.most_recent_payment_raw }

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
  parameter: bm_coid2 { view_label: "Z - BM Demo2" type: string default_value: "out" allowed_value: {label: "In" value: "in"} allowed_value: {label: "Out" value: "out"} }
  dimension: bm_coid_value2 {hidden: yes view_label: "Z - BM Demo2" type: string sql: case when {% parameter bm_coid2 %} = 'out' then 'x' else coalesce(safe_cast(${coid} as string),'unknown_') end ;; }

  parameter: bm_esl_level_1_desc2 { view_label: "Z - BM Demo2" type: string default_value: "out" allowed_value: {label: "In" value: "in"} allowed_value: {label: "Out" value: "out"} }
  dimension: bm_esl_level_1_desc_value2 {hidden: yes view_label: "Z - BM Demo2" type: string sql: case when {% parameter bm_esl_level_1_desc2 %} = 'out' then 'x' else coalesce(safe_cast(${esl_level_1_desc} as string),'unknown_') end ;; }

  parameter: bm_group_name2 { view_label: "Z - BM Demo2" type: string default_value: "out" allowed_value: {label: "In" value: "in"} allowed_value: {label: "Out" value: "out"} }
  dimension: bm_group_name_value2 {hidden: yes view_label: "Z - BM Demo2" type: string sql: case when {% parameter bm_group_name2 %} = 'out' then 'x' else coalesce(safe_cast(${group_name} as string),'unknown_') end ;; }

  parameter: bm_doctor_id2 { view_label: "Z - BM Demo2" type: string default_value: "out" allowed_value: {label: "In" value: "in"} allowed_value: {label: "Out" value: "out"} }
  dimension: bm_doctor_id_value2 {hidden: yes view_label: "Z - BM Demo2" type: string sql: case when {% parameter bm_doctor_id2 %} = 'out' then 'x' else coalesce(safe_cast(${doctor_id} as string),'unknown_') end ;; }

  dimension: bm_combined2 {
    view_label: "Z - BM Demo2"
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
    sql: ${first_denial_raw} is null ;;
  }

  dimension: is_p2p {
    hidden: yes
    type: yesno
    sql: ${percent_paidback_dim} BETWEEN 0.9 and 1.1 ;;
  }

  dimension: is_pdu {
    hidden: yes
    type: yesno
    sql: ${days_between_denial_and_discharge} > 60 ;;
  }

  dimension: is_concurrent_denial_with_param {
    hidden: yes
    type: yesno
    sql:
      {% if is_concurrent_denial_param._parameter_value == 'yes' %} ${is_concurrent_denial}
      {% else %} 1 = 0
      {% endif %}
    ;;
  }

  dimension: is_p2p_with_param {
    hidden: yes
    type: yesno
    sql:
      {% if is_p2p_param._parameter_value == 'yes' %} ${is_p2p}
      {% else %} 1 = 0
      {% endif %}
    ;;
  }

  dimension: is_pdu_with_param {
    hidden: yes
    type: yesno
    sql:
      {% if is_pdu_param._parameter_value == 'yes' %} ${is_pdu}
      {% else %} 1 = 0
      {% endif %}
    ;;
  }

  dimension: is_in_filtered_group {
    view_label: "Z - BM Demo 2"
    type: yesno
    sql: ${is_concurrent_denial_with_param} and ${is_p2p_with_param} and ${is_pdu_with_param} ;;
  }

### Create initial KPIs

  measure: count_in_filtered_group {
    view_label: "Z - BM Demo 2"
    group_label: "Initial KPI"
    type: count
    filters: [is_in_filtered_group: "Yes"]
  }

  measure: sum_owed_in_filtered_group {
    view_label: "Z - BM Demo 2"
    group_label: "Initial KPI"
    type: sum
    sql: ${total_owed} ;;
    filters: [is_in_filtered_group: "Yes"]
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

  measure: bm_kpi_actual2 {
    view_label: "Z - BM Demo 2"
    label: "KPI Selection"
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
