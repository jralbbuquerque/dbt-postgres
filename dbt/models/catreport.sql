{{
    config(
        materialized = 'incremental',
        unique_key   = 'category_id',
        pre_hook     = ["
            DELETE FROM {{target.schema}}.catreport trg
            WHERE NOT EXISTS (
                SELECT 1 FROM {{ source('sources', 'categories') }} src 
                WHERE src.category_id = trg.category_id
            )
        "]
    )
}}

select * from {{ source('sources', 'categories') }}