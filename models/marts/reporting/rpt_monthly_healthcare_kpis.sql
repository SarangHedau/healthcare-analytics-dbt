
with monthly_encounters as (

    select
        date_trunc('month', encounter_date)::date as report_month,
        count(distinct encounter_id) as total_encounters,
        count(distinct patient_id) as active_patients,
        count(distinct provider_id) as active_providers

    from {{ ref('fct_encounter') }}
    group by 1

),

monthly_with_previous as (

    select
        *,
        lag(total_encounters) over (
            order by report_month
        ) as previous_month_encounters

    from monthly_encounters

)

select
    report_month,
    total_encounters,
    active_patients,
    active_providers,
    previous_month_encounters,

    total_encounters - previous_month_encounters
        as encounter_change,

    round(
        100.0 * (total_encounters - previous_month_encounters)
        / nullif(previous_month_encounters, 0),
        2
    ) as encounter_growth_pct

from monthly_with_previous
