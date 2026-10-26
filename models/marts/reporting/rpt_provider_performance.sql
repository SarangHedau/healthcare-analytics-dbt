
select
    p.provider_id,
    p.provider_name,
    p.specialty,
    p.department,

    count(distinct e.encounter_id) as total_encounters,
    count(distinct e.patient_id) as unique_patients,
    min(e.encounter_date) as first_encounter_date,
    max(e.encounter_date) as last_encounter_date

from {{ ref('dim_provider') }} p

left join {{ ref('fct_encounter') }} e
    on p.provider_id = e.provider_id

group by
    p.provider_id,
    p.provider_name,
    p.specialty,
    p.department
