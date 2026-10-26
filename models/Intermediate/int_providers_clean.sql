
select *
from {{ ref('stg_providers') }}
where provider_id is not null
qualify row_number() over (
    partition by provider_id
    order by hire_date desc nulls last
) = 1
