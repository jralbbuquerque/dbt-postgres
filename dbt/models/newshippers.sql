select
    sh.company_name,
    se.shipper_email
from {{ source('sources', 'shippers') }} sh
left join {{ ref('shippers_email') }} se on sh.shipper_id = se.shipper_id