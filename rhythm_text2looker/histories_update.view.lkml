view: histories {
  sql_table_name: `hca-sandbox-aaron-argolis.rhythm.histories_update` ;;

####################
### Dimensions
####################

### Key Dimensions
  dimension: pk {
    group_label: "*Keys"
    primary_key: yes
    hidden: yes
    type: string
    sql: ${facility_id} || ' | ' || ${metriccode} || ' | ' || ${date_key} ;;
  }

  dimension_group: date {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.date ;;
  }

  dimension: date_key {
    group_label: "*Keys"
    type: date
    sql: ${date_raw} ;;
  }

  dimension: metriccode {
    group_label: "*Keys"
    type: string
    sql: ${TABLE}.metriccode ;;
  }

  dimension: facility_id {
    group_label: "*Keys"
    type: string
    sql: ${TABLE}.facility_id ;;
  }

### Metric Info Dimensions

  dimension: metric_type {
    group_label: "Metric Info"
    type: string
    sql: ${TABLE}.MetricType ;;
  }

  dimension: value {
    group_label: "Metric Info"
    type: number
    sql: ${TABLE}.value ;;
  }

  dimension: description {
    group_label: "Metric Info"
    type: string
    sql: ${TABLE}.Description ;;
  }

  dimension: display_name {
    group_label: "Metric Info"
    type: string
    sql: ${TABLE}.DisplayName ;;
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
    drill_fields: [division_name, market_name]
  }
  dimension: division_name {
    group_label: "Hierarchy Facility"
    label: "3 Division"
    sql: left(${TABLE}.division_name, length(${TABLE}.division_name) - 9) ;;
    drill_fields: [market_name, facility_name]
  }
  dimension: market_name {
    group_label: "Hierarchy Facility"
    label: "4 Market"
    drill_fields: [facility_name]
  }
  dimension: facility_name {
    group_label: "Hierarchy Facility"
    label: "5a Facility Name"
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
    # group_label: "Hierarchy Facility"
    type: location
    sql_latitude: ${lat} ;;
    sql_longitude: ${long} ;;
  }
  dimension: coid {
    # group_label: "Hierarchy Facility"
    label: "5b COID"
    type: number
    # value_format_name: id
    sql: ${TABLE}.coid ;;
  }

## Facility Other
  dimension: address {
    group_label: "Z - Facility Other"
    type: string
    sql: ${TABLE}.address ;;
  }

  dimension: city {
    group_label: "Z - Facility Other"
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: coid_name {
    group_label: "Z - Facility Other"
    type: string
    sql: ${TABLE}.coid_name ;;
  }

  dimension: cons_facility_name {
    group_label: "Z - Facility Other"
    type: string
    sql: ${TABLE}.cons_facility_name ;;
  }

  dimension: county {
    group_label: "Z - Facility Other"
    type: string
    sql: ${TABLE}.county ;;
  }

  dimension: division_code {
    group_label: "Z - Facility Other"
    type: number
    sql: ${TABLE}.division_code ;;
  }

  dimension: group_code {
    group_label: "Z - Facility Other"
    type: number
    sql: ${TABLE}.group_code ;;
  }

  dimension: market_code {
    group_label: "Z - Facility Other"
    type: number
    sql: ${TABLE}.market_code ;;
  }

  dimension: postal_code {
    group_label: "Z - Facility Other"
    type: number
    sql: ${TABLE}.postal_code ;;
  }

  dimension: state {
    group_label: "Z - Facility Other"
    type: string
    sql: ${TABLE}.state ;;
  }

####################
### Measures
####################

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # measure: Total_Census { description: "Current total census" label: "Total Census" type: sum sql: ${value} ;; }

  measure: Total_Census{ description: "Current total census" label: "Total Census" type: sum sql: ${value} ;; filters: [metriccode: "Total_Census"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: Total_Census_Capacity{ description: "Current total census capacity" label: "Total Census Capacity" type: sum sql: ${value} ;; filters: [metriccode: "Total_Census_Capacity"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: Baby_Census{ description: "Census including newborns as percentage of new born capacity" label: "Newborns Census" type: sum sql: ${value} ;; filters: [metriccode: "Baby_Census"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: Baby_Census_Capacity{ description: "Facility's bed capacity including new born capacity" label: "Newborn Census Capacity" type: sum sql: ${value} ;; filters: [metriccode: "Baby_Census_Capacity"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: Census_Under_Observation{ description: "Current observation census" label: "Observation Census" type: sum sql: ${value} ;; filters: [metriccode: "Census_Under_Observation"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: Self_Pay_Census{ description: "Current self pay patients for today" label: "Self Pay Patient Count" type: sum sql: ${value} ;; filters: [metriccode: "Self_Pay_Census"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: Admissions{ description: "Total admissions for today" label: "Total Admissions (Today)" type: sum sql: ${value} ;; filters: [metriccode: "Admissions"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: Admissions_MTD{ description: "Current total admissions for this month" label: "Total Admissions (MTD)" type: sum sql: ${value} ;; filters: [metriccode: "Admissions_MTD"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: Births{ description: "Current total of newborn admits for today" label: "Newborn Admissions (Today)" type: sum sql: ${value} ;; filters: [metriccode: "Births"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: Births_MTD{ description: "Current total of newborn admits for the month" label: "Newborn Admissions (MTD)" type: sum sql: ${value} ;; filters: [metriccode: "Births_MTD"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: Observations{ description: "Current obs admits today" label: "Observation Admissions (Today)" type: sum sql: ${value} ;; filters: [metriccode: "Observations"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: Observations_MTD{ description: "Current total of observation admissions for the month" label: "Observation Admissions (MTD)" type: sum sql: ${value} ;; filters: [metriccode: "Observations_MTD"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: Discharges{ description: "Current total discharges for today" label: "Discharges (Today)" type: sum sql: ${value} ;; filters: [metriccode: "Discharges"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: Discharges_MTD{ description: "Current total discharges for month" label: "Discharges (MTD)" type: sum sql: ${value} ;; filters: [metriccode: "Discharges_MTD"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: Average_Census{ description: "Current averge number of beds in use for the month" label: "Average Census (MTD)" type: sum sql: ${value} ;; filters: [metriccode: "Average_Census"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: ER_Patients{ description: "Total ER visits for today" label: "ER Visits (Today)" type: sum sql: ${value} ;; filters: [metriccode: "ER_Patients"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: ER_Patients_MTD{ description: "Current total of ER visits for the month" label: "ER Visits (MTD)" type: sum sql: ${value} ;; filters: [metriccode: "ER_Patients_MTD"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: ER_Admissions{ description: "Current total ER admits for today" label: "ER Admissions (Today)" type: sum sql: ${value} ;; filters: [metriccode: "ER_Admissions"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: ER_Admissions_MTD{ description: "Current total of ER admits for the month" label: "ER Admissions (MTD)" type: sum sql: ${value} ;; filters: [metriccode: "ER_Admissions_MTD"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: ER_EMS_Arrivals{ description: "Current total of EMS arrivals for today" label: "ER EMS Arrivals (Today)" type: sum sql: ${value} ;; filters: [metriccode: "ER_EMS_Arrivals"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: ER_EMS_Arrivals_MTD{ description: "Current total of EMS arrivals for the month" label: "ER EMS Arrivals (MTD)" type: sum sql: ${value} ;; filters: [metriccode: "ER_EMS_Arrivals_MTD"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: ER_Visits_Left_Before_Triage{ description: "Count of ER visits that left prior triage for today" label: "ER Visits - Left Prior to Triage (Today)" type: sum sql: ${value} ;; filters: [metriccode: "ER_Visits_Left_Before_Triage"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: ER_Visits_Left_Before_Triage_MTD{ description: "Current total of EMS arrivals to the ER that left before reaching triage for the month" label: "ER Visits - Left Prior to Triage (MTD)" type: sum sql: ${value} ;; filters: [metriccode: "ER_Visits_Left_Before_Triage_MTD"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: ER_Visits_Left_Before_Seen{ description: "Count of ER visits that left prior to being seen by a doctor for today" label: "ER Visits - Left Prior to being by MD (Today)" type: sum sql: ${value} ;; filters: [metriccode: "ER_Visits_Left_Before_Seen"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: ER_Visits_Left_Before_Seen_MTD{ description: "Current total of EMS arrivals to the ER that left before being seen by a doctor for the month" label: "ER Visits - Left Prior to being by MD (MTD)" type: sum sql: ${value} ;; filters: [metriccode: "ER_Visits_Left_Before_Seen_MTD"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: ER_Self_Pay_Patients{ description: "Current number of self-pay ER patients" label: "ER Self Pay Patient Count" type: sum sql: ${value} ;; filters: [metriccode: "ER_Self_Pay_Patients"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: IP_OR_Surgeries{ description: "Total inpatient OR surgical cases for today" label: "Inpatient OR Surgical Cases (Today)" type: sum sql: ${value} ;; filters: [metriccode: "IP_OR_Surgeries"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: IP_OR_Surgeries_MTD{ description: "Current total inpatient OR surgical cases for the month" label: "Inpatient OR Surgical Cases (MTD)" type: sum sql: ${value} ;; filters: [metriccode: "IP_OR_Surgeries_MTD"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: Same_Day_Case{ description: "Total same-day cases for today" label: "Same Day Case (Today)" type: sum sql: ${value} ;; filters: [metriccode: "Same_Day_Case"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: Same_Day_Case_MTD{ description: "Current total of same-day cases for the month" label: "Same Day Case (MTD)" type: sum sql: ${value} ;; filters: [metriccode: "Same_Day_Case_MTD"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: OP_Surgeries{ description: "Current outpatient diagnostic cases for today" label: "Outpatient Diagnostics" type: sum sql: ${value} ;; filters: [metriccode: "OP_Surgeries"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: OP_Surgeries_MTD{ description: "Outpatient diagnostic cases for the month" label: "Outpatient Diagnostics - MTD" type: sum sql: ${value} ;; filters: [metriccode: "OP_Surgeries_MTD"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: EDWIN_Score{ description: "EDWIN Score" label: "EDWIN Score" type: sum sql: ${value} ;; filters: [metriccode: "EDWIN_Score"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: COVID_19_Positive{ description: "From NATE: A count of current patients whose lab results have detected COVID-19 and classified as confirmed COVID-19 positive" label: "NATE COVID-19 Positive" type: sum sql: ${value} ;; filters: [metriccode: "COVID_19_Positive"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: COVID_19_PUI{ description: "From NATE: A count of current patients for whom there is a COVID-19 lab order that has not yet been resulted" label: "NATE COVID-19 PUI" type: sum sql: ${value} ;; filters: [metriccode: "COVID_19_PUI"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: Inpatient_Occupancy{ description: "From NATE: A count of inpatient beds that are currently occupied" label: "NATE Inpatient Occupancy" type: sum sql: ${value} ;; filters: [metriccode: "Inpatient_Occupancy"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: ICU_Occupancy{ description: "From NATE: A count of ICU beds that are currently occupied" label: "NATE ICU Occupancy" type: sum sql: ${value} ;; filters: [metriccode: "ICU_Occupancy"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: ED_Occupancy{ description: "From NATE: A count of ED beds that are currently occupied" label: "NATE ED Occupancy" type: sum sql: ${value} ;; filters: [metriccode: "ED_Occupancy"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: Total_Ventilator_Capacity{ description: "From NATE: The total inventory of adult invasive mechanical vents at a facility that are recommended for use for the critically ill in the ICU (this does not include transports, HFOV, Neonatal, etc. - the status as 'ICU Recommended' is determined by the facility in the inventory submission process)" label: "NATE Adult ICU Invasive Vent Inventory" type: sum sql: ${value} ;; filters: [metriccode: "Total_Ventilator_Capacity"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: Gowns_Issued_Past_1_Day{ description: "A count of PPE gowns issued at this location starting at 7am, local facility time." label: "PPE Gowns Issued Count (Today)" type: sum sql: ${value} ;; filters: [metriccode: "Gowns_Issued_Past_1_Day"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: Gowns_Issued_Past_7_Day{ description: "A count of PPE gowns issued at this location over the last 7 days." label: "PPE Gowns Issued Count (Last 7 days)" type: sum sql: ${value} ;; filters: [metriccode: "Gowns_Issued_Past_7_Day"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: L3_Masks_Issued_Past_1_Day{ description: "A count of Level 3 Surgical masks issued at this location starting at 7am, local facility time." label: "Level 3 Surgical Masks Issued Count (Today)" type: sum sql: ${value} ;; filters: [metriccode: "L3_Masks_Issued_Past_1_Day"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: L3_Masks_Issued_Past_7_Day{ description: "A count of Level 3 Surgical masks issued at this location over the last 7 days." label: "Level 3 Surgical Masks Issued Count (Last 7 days)" type: sum sql: ${value} ;; filters: [metriccode: "L3_Masks_Issued_Past_7_Day"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: N95_Issued_Past_1_Day{ description: "A count of N95 masks issued at this location starting at 7am, local facility time." label: "N95 Issued Count (Today)" type: sum sql: ${value} ;; filters: [metriccode: "N95_Issued_Past_1_Day"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: N95_Issued_Past_7_Day{ description: "A count of N95 masks issued at this location over the last 7 days." label: "N95 Issued Count (Last 7 Days)" type: sum sql: ${value} ;; filters: [metriccode: "N95_Issued_Past_7_Day"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: Expected_Surg_Cases{ description: "The number of cases that are in the Symphony database for Gen/Heart/Cysto. Calculated by Total case master cases - Canceled case master cases" label: "Expected Surg. Cases(GEN/HEART/CYSTO) #" type: sum sql: ${value} ;; filters: [metriccode: "Expected_Surg_Cases"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: Expected_Gen_Cases{ description: "The total number of GEN cases - canceled GEN cases" label: "Expected GEN Cases #" type: sum sql: ${value} ;; filters: [metriccode: "Expected_Gen_Cases"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: Expected_Heart_Cases{ description: "The total number of HEART cases - canceled HEART cases" label: "Expected HEART Cases #" type: sum sql: ${value} ;; filters: [metriccode: "Expected_Heart_Cases"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: Expected_Cysto_Cases{ description: "The total number of CYSTO cases - canceled CYSTO cases" label: "Expected CYSTO Cases #" type: sum sql: ${value} ;; filters: [metriccode: "Expected_Cysto_Cases"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: Expected_Endo_Cases{ description: "The total number of ENDO cases - canceled ENDO cases" label: "Expected ENDO Cases #" type: sum sql: ${value} ;; filters: [metriccode: "Expected_Endo_Cases"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: Expected_L_D_Cases{ description: "The total number of L&D cases - canceled L&D cases" label: "Expected L & D Cases #" type: sum sql: ${value} ;; filters: [metriccode: "Expected_L_D_Cases"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: Expected_Cath_Cases{ description: "The total number of CATH cases - canceled CATH cases" label: "Expected CATH Cases #" type: sum sql: ${value} ;; filters: [metriccode: "Expected_Cath_Cases"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: Expected_Bedside_Proceedures{ description: "The total number of BEDSIDE cases - canceled BEDSIDE cases" label: "Expected BEDSIDE Procedures #" type: sum sql: ${value} ;; filters: [metriccode: "Expected_Bedside_Proceedures"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: Expected_IR_Procedures{ description: "The total number of IR cases - canceled IR cases" label: "Expected IR Procedures #" type: sum sql: ${value} ;; filters: [metriccode: "Expected_IR_Procedures"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: Expected_Pain_Cases{ description: "The total number of PAIN cases - canceled PAIN cases" label: "Expected PAIN Cases #" type: sum sql: ${value} ;; filters: [metriccode: "Expected_Pain_Cases"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: Expected_Pat_Appointments{ description: "The total number of PAT cases - canceled PAT cases" label: "Expected PAT Appointments #" type: sum sql: ${value} ;; filters: [metriccode: "Expected_Pat_Appointments"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: Expected_Unmapped_Procedures{ description: "The total number of UNMAPPED cases - canceled UNMAPPED cases" label: "Expected UNMAPPED Procedures #" type: sum sql: ${value} ;; filters: [metriccode: "Expected_Unmapped_Procedures"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: Adult_Invasive_Vent_Census{ description: "From NATE: The count of patient currently on a ventilator (exculding pediatric and neonatal patients)" label: "NATE Adult Invasive Vent Census" type: sum sql: ${value} ;; filters: [metriccode: "Adult_Invasive_Vent_Census"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: Missed_Meal{ description: "Missed Meal indicates employees that worked at least an 8 hour shift and did not take a meal break during the first 8 hours of the shift. This count is the number of exceptions for this moment in time." label: "Missed Meal" type: sum sql: ${value} ;; filters: [metriccode: "Missed_Meal"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: No_Meal{ description: "No Meal indicates employees that worked at least an 8 hour shift and did not take a meal break at all during that shift. This count is the number of exceptions for this moment in time." label: "No Meal" type: sum sql: ${value} ;; filters: [metriccode: "No_Meal"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: Incremental_Time{ description: "Incremental Time identifies employees who worked longer than they were scheduled for the their shift. This count is the number of exceptions for this moment in time." label: "Incremental Time" type: sum sql: ${value} ;; filters: [metriccode: "Incremental_Time"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: CCU_On_TC{ description: "All CCU is on tranfer closure for the COID" label: "CCU ON Transfer Closure" type: sum sql: ${value} ;; filters: [metriccode: "CCU_On_TC"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: ICU_On_TC{ description: "All ICU is on tranfer closure for the COID" label: "ICU ON Transfer Closure" type: sum sql: ${value} ;; filters: [metriccode: "ICU_On_TC"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: PCU_On_TC{ description: "All PCU is on tranfer closure for the COID" label: "PCU ON Transfer Closure" type: sum sql: ${value} ;; filters: [metriccode: "PCU_On_TC"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: LD_On_TC{ description: "All L&D is on tranfer closure for the COID" label: "L&D ON Transfer Closure" type: sum sql: ${value} ;; filters: [metriccode: "L&D_On_TC"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: Med_Surg_On_TC{ description: "All MED SURG is on tranfer closure for the COID" label: "MED SURG ON Transfer Closure" type: sum sql: ${value} ;; filters: [metriccode: "Med_Surg_On_TC"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: NEURO_ICU_On_TC{ description: "All NEURO ICU is on tranfer closure for the COID" label: "NEURO ICU ON Transfer Closure" type: sum sql: ${value} ;; filters: [metriccode: "NEURO_ICU_On_TC"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: NICU_On_TC{ description: "All NICU is on tranfer closure for the COID" label: "NICU ON Transfer Closure" type: sum sql: ${value} ;; filters: [metriccode: "NICU_On_TC"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: PEDS_On_TC{ description: "All PEDS is on tranfer closure for the COID" label: "PEDS ON Transfer Closure" type: sum sql: ${value} ;; filters: [metriccode: "PEDS_On_TC"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: PICU_On_TC{ description: "All PICU is on tranfer closure for the COID" label: "PICU ON Transfer Closure" type: sum sql: ${value} ;; filters: [metriccode: "PICU_On_TC"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: Telemetry_On_TC{ description: "All TELEMETRY is on tranfer closure for the COID" label: "TELEMETRY ON Transfer Closure" type: sum sql: ${value} ;; filters: [metriccode: "Telemetry_On_TC"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: CDU_On_TC{ description: "All CDU is on tranfer closure for the COID" label: "CDU ON Transfer Closure" type: sum sql: ${value} ;; filters: [metriccode: "CDU_On_TC"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: ER_On_TC{ description: "All ER is on tranfer closure for the COID" label: "ER ON Transfer Closure" type: sum sql: ${value} ;; filters: [metriccode: "ER_On_TC"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: STEMI_On_TC{ description: "All STEMI is on tranfer closure for the COID" label: "STEMI ON Transfer Closure" type: sum sql: ${value} ;; filters: [metriccode: "STEMI_On_TC"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: Stroke_On_TC{ description: "All STROKE is on tranfer closure for the COID" label: "STROKE ON Transfer Closure" type: sum sql: ${value} ;; filters: [metriccode: "Stroke_On_TC"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: Trauma_On_TC{ description: "All TRAUMA is on tranfer closure for the COID" label: "TRAUMA ON Transfer Closure" type: sum sql: ${value} ;; filters: [metriccode: "Trauma_On_TC"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: Units_On_TC{ description: "Sum of all unit types on transfer closure for the Division COID" label: "UNITS ON Transfer Closure" type: sum sql: ${value} ;; filters: [metriccode: "Units_On_TC"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: ICU_COVID_19_Positive{ description: "From NATE: A count of current ICU patients whose lab results have detected COVID-19 and classified as confirmed COVID-19 positive" label: "NATE COVID ICU Census" type: sum sql: ${value} ;; filters: [metriccode: "ICU_COVID_19_Positive"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: ST_Capacity{ description: "Resurgence Capacity" label: "Capacity" type: sum sql: ${value} ;; filters: [metriccode: "ST_Capacity"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: Completed_IN_Patient_Cases{ description: "The number of completed IN cases that are in the Symphony database." label: "Completed IN Patient Cases" type: sum sql: ${value} ;; filters: [metriccode: "Completed_IN_Patient_Cases"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: Completed_SDC_Patient_Cases{ description: "The number of completed SDC cases that are in the Symphony database." label: "Completed SDC Patient Cases" type: sum sql: ${value} ;; filters: [metriccode: "Completed_SDC_Patient_Cases"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: BC_ICU_Occupancy{ description: "A count of ICU beds that are currently occupied." label: "ICU Occupancy" type: sum sql: ${value} ;; filters: [metriccode: "BC_ICU_Occupancy"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: Nate_ER_Holds{ description: "Count of ER holds" label: "ER Holds" type: sum sql: ${value} ;; filters: [metriccode: "Nate_ER_Holds"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: Total_Census_Percent{ description: "Current percentage of beds used" label: "Census %" type: average sql: ${value} ;; filters: [metriccode: "Total_Census_Percent"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: Baby_Census_Percent{ description: "Census including newborns as percentage of new born capacity" label: "Newborn Census %" type: average sql: ${value} ;; filters: [metriccode: "Baby_Census_Percent"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: Census_Under_Observation_Percent{ description: "Current percentage of obs beds used" label: "Observation Census %" type: average sql: ${value} ;; filters: [metriccode: "Census_Under_Observation_Percent"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: Self_Pay_Census_Percent{ description: "Current self pay patients as percentage of capacity" label: "Self Pay Patient %" type: average sql: ${value} ;; filters: [metriccode: "Self_Pay_Census_Percent"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: ER_Self_Pay_Patients_Percent{ description: "Percentage of current self-pay ER patients since last midnight" label: "ER Self Pay Patient %" type: average sql: ${value} ;; filters: [metriccode: "ER_Self_Pay_Patients_Percent"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: Rounding_Rate{ description: "Current total of observation admissions for the month" label: "Orbit Rounding Compliance %" type: average sql: ${value} ;; filters: [metriccode: "Rounding_Rate"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: Inpatient_Occupancy_pct{ description: "From NATE: Percent of inpatient beds that are currently occupied" label: "NATE Inpatient Occupancy Percent" type: average sql: ${value} ;; filters: [metriccode: "Inpatient_Occupancy_pct"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: ICU_Occupancy_pct{ description: "From NATE: Percent of ICU beds that are currently occupied" label: "NATE ICU Occupancy Percent" type: average sql: ${value} ;; filters: [metriccode: "ICU_Occupancy_pct"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: ED_Occupancy_pct{ description: "From NATE: Percent of ED beds that are currently occupied" label: "NATE ED Occupancy Percent" type: average sql: ${value} ;; filters: [metriccode: "ED_Occupancy_pct"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: Ventilator_Capacity_In_Use{ description: "From NATE: ‘Current Adult Vent Patient Census’ / ‘Adult Invasive Vent Inventory – ICU Recommended’" label: "NATE Adult ICU Invasive Vent Util. %" type: average sql: ${value} ;; filters: [metriccode: "Ventilator_Capacity_In_Use"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: Completed_Surg_Cases_PCT{ description: "The percent of cases in Case Master that have a Procedure Ended value for Gen/Heart/Cysto" label: "Completed Surg. Cases(GEN/HEART/CYSTO) %" type: average sql: ${value} ;; filters: [metriccode: "Completed_Surg_Cases_PCT"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: Completed_Gen_Surgical_Cases_PCT{ description: "The percent of Completed GEN cases (Completed/Expected) that are in the Symphony database" label: "Completed GEN Surgical Cases %" type: average sql: ${value} ;; filters: [metriccode: "Completed_Gen_Surgical_Cases_PCT"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: Completed_Heart_Surgical_Cases_PCT{ description: "The percent of Completed HEART cases (Completed/Expected) that are in the Symphony database " label: "Completed HEART Surgical Cases %" type: average sql: ${value} ;; filters: [metriccode: "Completed_Heart_Surgical_Cases_PCT"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: Completed_Cysto_Surgical_Cases_PCT{ description: "The percent of Completed CYSTO (Completed/Expected) cases that are in the Symphony database" label: "Completed CYSTO Surgical Cases %" type: average sql: ${value} ;; filters: [metriccode: "Completed_Cysto_Surgical_Cases_PCT"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: Completed_Endo_Cases_PCT{ description: "The percent of Completed ENDO cases (Completed/Expected) that are in the Symphony database " label: "Completed ENDO Cases %" type: average sql: ${value} ;; filters: [metriccode: "Completed_Endo_Cases_PCT"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: BC_ICU_Occupancy_pct{ description: "Percent of ICU beds that are currently occupied." label: "ICU Occupancy %" type: average sql: ${value} ;; filters: [metriccode: "BC_ICU_Occupancy_pct"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: ER_Wait_Minutes{ description: "Current average of ER wait time for today" label: "ER Average Wait Time in Minutes (Today)" type: average sql: ${value} ;; filters: [metriccode: "ER_Wait_Minutes"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: ER_LOS_Minutes{ description: "Current average ER length of stay for today" label: "ER Average Length of Stay in Minutes (Today)" type: average sql: ${value} ;; filters: [metriccode: "ER_LOS_Minutes"] value_format_name: decimal_2 drill_fields: [detail*]}

  measure: ER_Wait_Minutes_4Hour_Avg{ description: "Current average of ER wait time for last 4 hours" label: "ER Average Wait Time in Minutes (4hr| rolling average)" type: average sql: ${value} ;; filters: [metriccode: "ER_Wait_Minutes_4Hour_Avg"] value_format_name: decimal_2 drill_fields: [detail*]}

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
  group_name,
  facility_name,
  market_name,
  cons_facility_name,
  division_name,
  display_name,
  coid_name
  ]
  }

}
