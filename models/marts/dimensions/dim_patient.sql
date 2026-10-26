
select
    patient_id,
    birth_date,
    gender,
    registration_date,
    patient_status,
    postal_code,
    insurance_type,

    date_diff('year', birth_date, current_date)
      - case
          when strftime(current_date, '%m-%d')
               < strftime(birth_date, '%m-%d')
          then 1
          else 0
        end as current_age,

    case
        when birth_date is null then 'Unknown'
        when date_diff('year', birth_date, current_date) < 18
            then 'Under 18'
        when date_diff('year', birth_date, current_date) < 35
            then '18-34'
        when date_diff('year', birth_date, current_date) < 50
            then '35-49'
        when date_diff('year', birth_date, current_date) < 65
            then '50-64'
        else '65+'
    end as age_group

from {{ ref('int_patients_clean') }}
