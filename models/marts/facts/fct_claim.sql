
select
    claim_id,
    encounter_id,
    claim_date,
    claim_status,
    payer_name,
    claim_type,
    billed_amount,
    paid_amount,

    billed_amount - paid_amount as outstanding_amount,

    1 as claim_count

from {{ ref('int_claims_clean') }}
