with deal as (
    select *
    from {{ ref('int_deal') }}
)

, deal_stage as (
    select *
    from {{ ref('int_deal_stage') }}
)

, deal_stage_agg as (
    select deal_id, 
        sum(duration_in_stage_seconds) as age_deal_seconds
    from deal_stage
    group by 1
)

, deal_stage_grouped as (
    select
        deal_id,
        deal_stage_name,
        sum(duration_in_stage_seconds) as duration_in_stage_seconds
    from deal_stage
    group by 1,2
)

, deal_stage_pivoted as (
    select
        deal_id,
        {{ dbt_utils.pivot('deal_stage_name', 'duration_in_stage_seconds', prefix='seconds_in_') }}
    from deal_stage_grouped
)

, joined as (
    select
        deal.*,
        deal_stage_agg.age_deal_seconds,
        deal_stage_pivoted.*
    from deal
    left join deal_stage_agg using (deal_id)
    left join deal_stage_pivoted using (deal_id)
)

, final as (
    select *
    from joined
)

select *
from final