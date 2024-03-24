with 
calc_employees as (
    select
        to_char(now(), 'yyyy')::int - to_char(birth_date, 'yyyy')::int age,
        to_char(now(), 'yyyy')::int - to_char(hire_date, 'yyyy')::int lengthofservice,
        concat(first_name, ' ', last_name) name, 
        *
from {{ source('sources', 'employees') }}
)

select * from calc_employees