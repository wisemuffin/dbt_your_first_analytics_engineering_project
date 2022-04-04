with deal_stage as (

    select *
    from {{ ref('stg_hubspot__deal_stage') }}

), final as (

    select
        deal_stage.deal_id || '-' || row_number() over(partition by deal_stage.deal_id order by deal_stage.date_entered asc) as deal_stage_id,
        deal_stage.deal_stage_name, 
        deal_stage._fivetran_start as date_stage_entered,
        deal_stage._fivetran_end as date_stage_exited,
        deal_stage._fivetran_active as is_stage_active,
        {{dbt_utils.datediff(date_stage_exited, date_stage_exited, 'day')}} as duration_in_stage

    from deal_stage

)

select * 
from final