with base as (

    select *
    from {{ source('hubspot', 'deal_stage') }}

)

, fields as (
    
    select 
        date_entered,
        deal_id,
        source,
        source_id,
        value as deal_stage_name,
        _fivetran_active,
        _fivetran_end,
        _fivetran_start
    from base
)

select * 
from fields