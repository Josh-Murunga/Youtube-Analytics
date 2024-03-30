{{ config(materialized="table") }}

with
    trends as (select * from {{ ref("fact_youtube_trends") }})
select
    tr.category_id,
    tr.category_name,
    count(tr.video_id) as videos_trends,
    tr.trending_date
from trends as tr
group by tr.category_id, tr.category_name, tr.trending_date
order by tr.trending_date asc