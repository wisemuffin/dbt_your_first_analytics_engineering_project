with deal as (
    select *
    from {{ ref('int_deal') }}
)

, deal_stage as (
    select *
    from {{ ref('int_deal_stage') }}
)

, deal_stage_pivoted as (
    select *
    from {{ ref('int_deal_stage_pivoted') }}
)

, deal_stage_agg as (
    select deal_id, 
        sum(duration_in_stage_seconds) as seconds_deal_open
    from deal_stage
    group by 1
)

, joined as (
    select
        deal.*,
        deal_stage_agg.seconds_deal_open,
        deal_stage_pivoted.seconds_deal_in_appointmentscheduled
    from deal
    left join deal_stage_agg using (deal_id)
    left join deal_stage_pivoted using (deal_id)
)

, final as (
    select 
        *
    from joined
)


select *
from final
-- from deal_stage_pivoted