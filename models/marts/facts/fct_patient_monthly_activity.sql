
with encounters as (

    select
        encounter_id,
        patient_id,
        provider_id,
        encounter_date,
        encounter_status,
        encounter_count,
        date_trunc('month', encounter_date)::date as activity_month

    from {{ ref('fct_encounter') }}

),

monthly_activity as (

    select
        patient_id,
        activity_month,
        count(distinct encounter_id) as total_encounters,
        count(distinct provider_id) as distinct_providers,
        min(encounter_date) as first_encounter_date,
        max(encounter_date) as last_encounter_in_month

    from encounters
    group by
        patient_id,
        activity_month

),

patient_last_encounter as (

    select
        patient_id,
        max(encounter_date) as last_encounter_date
    from encounters
    group by patient_id

)

select
    ma.patient_id,
    ma.activity_month,
    ma.total_encounters,
    ma.distinct_providers,
    ma.first_encounter_date,
    ma.last_encounter_in_month,
    ple.last_encounter_date,

    date_diff(
        'day',
        ple.last_encounter_date,
        current_date
    ) as days_since_last_encounter,

    case
        when date_diff(
            'day',
            ple.last_encounter_date,
            current_date
        ) >= 180
        then true
        else false
    end as potential_care_gap_flag

from monthly_activity ma
inner join patient_last_encounter ple
    on ma.patient_id = ple.patient_id
