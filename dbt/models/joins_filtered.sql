select  
    {{ return_fields() }}
from 
    {{ ref('joins') }}
where
    category_name = '{{ var("category") }}'