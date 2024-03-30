{{ config(materialized="table") }}

with
    youtube_data as (select * from {{ ref("stg_youtube_trends_partitioned_clustered") }}),
    channel_category as (select * from {{ ref("category_lookup") }})
select
    yt.video_id,
    yt.title as video_title,
    yt.published_at,
    yt.trending_date,
    yt.channel_id,
    yt.channel_title,
    yt.category_id,
    cat.title as category_name,
    yt.view_count,
    yt.likes,
    yt.dislikes,
    yt.comment_count,
    yt.comments_disabled,
    yt.ratings_disabled
from youtube_data as yt
inner join channel_category as cat on cat.categoryid = yt.category_id