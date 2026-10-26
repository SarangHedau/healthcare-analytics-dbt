
with source as (

    select * from {{ ref('providers') }}

),

cleaned as (

    select
        trim(provider_id) as provider_id,
        trim(provider_name) as provider_name,
        trim(specialty) as specialty,
        trim(department) as department,
        lower(trim(employment_status)) as employment_status,
        try_cast(hire_date as date) as hire_date

    from source

)

select * from cleaned
