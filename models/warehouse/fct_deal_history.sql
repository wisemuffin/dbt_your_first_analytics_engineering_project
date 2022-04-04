with deal as (
    select *
    from {{ ref('int_deal') }}
)

, deal_stage as (
    select *
    from {{ ref('int_deal_stage') }}
)

, joined as (
    select 
        deal_stage.*,
        deal.company_id
    from deal_stage
    left join deal using (deal_id)
)

, final as (
    select *
    from joined
)


select *
from final

