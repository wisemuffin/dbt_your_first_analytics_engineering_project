with base as (

    select *
    from {{ source('hubspot', 'deal_company') }}

)
, fields as (

    select
        company_id,
        deal_id,
        _fivetran_synced
        
    from base
    
)

select *
from fields