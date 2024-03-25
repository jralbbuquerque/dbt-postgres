select 
    distinct *
from {{ target.schema }}_meta.dbt_audit_log
