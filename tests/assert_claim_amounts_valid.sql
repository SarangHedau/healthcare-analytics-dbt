
select *
from {{ ref('int_claims_clean') }}
where billed_amount < 0
   or paid_amount < 0
   or paid_amount > billed_amount
