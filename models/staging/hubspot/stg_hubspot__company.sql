with base as (

    select *
    from {{ source('hubspot', 'company') }}
    where not coalesce(is_deleted, false) 

)
, fields as (

    select
        id as company_id,
        _fivetran_synced,
        property_name as company_name,
        property_createdate as created_at,
        property_industry as industry,
        property_address as street_address,
        property_city as city,
        property_state as state,
        property_country as country,
        property_annualrevenue as company_annual_revenue
        
    from base

)

select *
from fields