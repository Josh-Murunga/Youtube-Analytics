{{ config(materialized='table') }}

select categoryid, title from {{ ref('category_lookup') }}