
select
    provider_id,
    provider_name,
    specialty,
    department,
    employment_status,
    hire_date,

    case
        when hire_date is null then null
        else date_diff('year', hire_date, current_date)
    end as years_employed

from {{ ref('int_providers_clean') }}
