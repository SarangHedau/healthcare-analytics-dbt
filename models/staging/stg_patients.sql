
with source as (

    select * from {{ ref('patients') }}

),

cleaned as (

    select
        trim(patient_id) as patient_id,
        try_cast(birth_date as date) as birth_date,
        upper(trim(gender)) as gender,
        try_cast(registration_date as date) as registration_date,
        lower(trim(status)) as patient_status,
        trim(cast(postal_code as varchar)) as postal_code,
        trim(insurance_type) as insurance_type

    from source

)

select * from cleaned
