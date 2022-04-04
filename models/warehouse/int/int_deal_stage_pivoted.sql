with deal_stage as (
    select *
    from {{ ref('int_deal_stage') }}
)

, deal_stage_pivoted as (
    select
        deal_id,
        {{ dbt_utils.pivot('deal_stage_name', dbt_utils.get_column_values(ref('int_deal_stage'),'deal_stage_name'), then_value='duration_in_stage_seconds', prefix='seconds_deal_in_', quote_identifiers=false) }}
    from deal_stage
    group by 1
    
)

, final as (
    select 
        *
    from deal_stage_pivoted
)


select *
from final