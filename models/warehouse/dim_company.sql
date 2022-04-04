with company as (
    select *
    from {{ ref('int_company')}}
)

, final as (
    select *
    from company
)

select *
from final