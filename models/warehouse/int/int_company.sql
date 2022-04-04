with company as (
    select *
    from {{ ref('stg_hubspot__company')}}
)

, final as (
    select *
    from company
)

select *
from final