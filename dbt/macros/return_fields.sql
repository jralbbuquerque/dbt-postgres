{% macro return_fields() %}

{{  
    return('
        category_name,
        suppliers, 
        product_name,
        product_id
    ')
}}

{% endmacro %}