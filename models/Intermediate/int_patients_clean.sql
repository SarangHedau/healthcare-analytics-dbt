
with source as (

    select *
    from {{ ref('stg_patients') }}

),

deduplicated as (

    select *
    from source
    where patient_id is not null
    qualify row_number() over (
        partition by patient_id
        order by registration_date desc nulls last
    ) = 1

),

validated as (

    select *
    from deduplicated
    where birth_date <= current_date
      and (
          registration_date is null
          or registration_date <= current_date
      )

)

select * from validated
