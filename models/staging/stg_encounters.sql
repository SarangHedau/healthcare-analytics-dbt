
with source as (

    select * from {{ ref('encounters') }}

),

cleaned as (

    select
        trim(encounter_id) as encounter_id,
        trim(patient_id) as patient_id,
        trim(provider_id) as provider_id,
        try_cast(encounter_date as date) as encounter_date,
        lower(trim(encounter_type)) as encounter_type,
        lower(trim(status)) as encounter_status,
        upper(trim(diagnosis_code)) as diagnosis_code,
        trim(facility_id) as facility_id

    from source

)

select * from cleaned
