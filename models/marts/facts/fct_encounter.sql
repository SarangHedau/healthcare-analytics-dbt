
select
    encounter_id,
    patient_id,
    provider_id,
    encounter_date,
    encounter_type,
    encounter_status,
    diagnosis_code,
    facility_id,

    1 as encounter_count

from {{ ref('int_encounters_clean') }}
