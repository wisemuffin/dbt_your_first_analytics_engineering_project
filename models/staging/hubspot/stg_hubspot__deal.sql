with base as (

    select *
    from {{ source('hubspot','deal') }}
    where not coalesce(is_deleted, false)

)

, fields as (
    select  
        deal_id,
        cast(deal_pipeline_id as {{ dbt_utils.type_string() }}) as deal_pipeline_id,
        cast(deal_pipeline_stage_id as {{ dbt_utils.type_string() }}) as deal_pipeline_stage_id,
        owner_id,
        property_dealname as deal_name,
        property_amount as amount,
        property_closedate as closed_at,
        property_createdate as created_at
    from base
)

select *
from fields