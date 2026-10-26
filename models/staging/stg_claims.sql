
with source as (

    select * from {{ ref('claims') }}

),

cleaned as (

    select
        trim(claim_id) as claim_id,
        trim(encounter_id) as encounter_id,
        try_cast(claim_date as date) as claim_date,
        try_cast(billed_amount as decimal(12, 2)) as billed_amount,
        try_cast(paid_amount as decimal(12, 2)) as paid_amount,
        lower(trim(claim_status)) as claim_status,
        trim(payer_name) as payer_name,
        lower(trim(claim_type)) as claim_type

    from source

)

select * from cleaned
