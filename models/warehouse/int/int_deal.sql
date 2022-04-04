with deal as (
    select *
    from {{ref('stg_hubspot__deal')}}
)

, deal_company as (
    select *
    from {{ref('stg_hubspot__deal_company')}}
)

, joined as (
    select
        deal.*,
        deal_company.company_id
    from deal
    left join deal_company using (deal_id)
)

, final as (
    select *
    from joined
)

select *
from final