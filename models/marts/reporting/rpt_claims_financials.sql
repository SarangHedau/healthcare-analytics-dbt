
select
    date_trunc('month', claim_date)::date as report_month,
    payer_name,
    claim_type,

    count(distinct claim_id) as total_claims,
    sum(billed_amount) as total_billed_amount,
    sum(paid_amount) as total_paid_amount,
    sum(outstanding_amount) as total_outstanding_amount,

    round(
        100.0 * sum(paid_amount)
        / nullif(sum(billed_amount), 0),
        2
    ) as payment_rate_pct

from {{ ref('fct_claim') }}

group by
    1, 2, 3
