with fct_deal as (
    select *
    from {{ ref('fct_deal')}}
)

, dim_company as (
    select *
    from {{ ref('dim_company')}}
)

select fct_deal.*,
    dim_company.company_name
from fct_deal
left join dim_company using (company_id)