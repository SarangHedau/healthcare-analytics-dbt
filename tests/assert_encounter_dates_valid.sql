
select *
from {{ ref('int_encounters_clean') }}
where encounter_date > current_date
