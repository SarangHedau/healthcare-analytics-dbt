
with source as (

    select *
    from {{ ref('stg_claims') }}

),

deduplicated as (

    select *
    from source
    where claim_id is not null
    qualify row_number() over (
        partition by claim_id
        order by claim_date desc nulls last
    ) = 1

)

select cl.*
from deduplicated cl
inner join {{ ref('int_encounters_clean') }} e
    on cl.encounter_id = e.encounter_id
where cl.claim_date <= current_date
  and cl.billed_amount >= 0
  and cl.paid_amount >= 0
  and cl.paid_amount <= cl.billed_amount
