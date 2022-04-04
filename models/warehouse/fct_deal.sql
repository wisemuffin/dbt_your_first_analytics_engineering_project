with deal as (
    select *
    from {{ ref('int_deal') }}
)

, deal_stage as (
    select *
    from {{ ref('int_deal_stage') }}
)

, joined as (
    
)