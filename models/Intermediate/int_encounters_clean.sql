
with source as (

    select *
    from {{ ref('stg_encounters') }}

),

deduplicated as (

    select *
    from source
    where encounter_id is not null
    qualify row_number() over (
        partition by encounter_id
        order by encounter_date desc nulls last
    ) = 1

)

select e.*
from deduplicated e
inner join {{ ref('int_patients_clean') }} p
    on e.patient_id = p.patient_id
inner join {{ ref('int_providers_clean') }} pr
    on e.provider_id = pr.provider_id
where e.encounter_date <= current_date
