{{ config(materialized='view') }}

with youtubedata as 
(
  select * from {{ source('staging','youtube_trends_partitioned_clustered') }}
  where video_id is not null
)

select
    {{ dbt.safe_cast("video_id", api.Column.translate_type("string")) }} as video_id,
    {{ dbt.safe_cast("title", api.Column.translate_type("string")) }} as title,
    {{ dbt.safe_cast("publishedAt", api.Column.translate_type("date")) }} as published_at,
    {{ dbt.safe_cast("channelId", api.Column.translate_type("string")) }} as channel_id,
    {{ dbt.safe_cast("channelTitle", api.Column.translate_type("string")) }} as channel_title,
    {{ dbt.safe_cast("categoryId", api.Column.translate_type("integer")) }} as category_id,
    {{ dbt.safe_cast("view_count", api.Column.translate_type("integer")) }} as view_count,
    {{ dbt.safe_cast("likes", api.Column.translate_type("integer")) }} as likes,
    {{ dbt.safe_cast("dislikes", api.Column.translate_type("integer")) }} as dislikes,
    {{ dbt.safe_cast("comment_count", api.Column.translate_type("integer")) }} as comment_count,
    {{ dbt.safe_cast("comments_disabled", api.Column.translate_type("string")) }} as comments_disabled,
    {{ dbt.safe_cast("ratings_disabled", api.Column.translate_type("string")) }} as ratings_disabled,
    {{ dbt.safe_cast("trending_date", api.Column.translate_type("date")) }} as trending_date,
from
    youtubedata