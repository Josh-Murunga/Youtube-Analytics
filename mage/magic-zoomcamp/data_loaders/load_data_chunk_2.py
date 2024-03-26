import io
import pandas as pd
import requests
if 'data_loader' not in globals():
    from mage_ai.data_preparation.decorators import data_loader
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@data_loader
def load_data_from_api(*args, **kwargs):
    urls = [
        'https://github.com/Josh-Murunga/Youtube-Analytics/releases/download/v1/FR_youtube_trending_data.csv.gz',
        'https://github.com/Josh-Murunga/Youtube-Analytics/releases/download/v1/GB_youtube_trending_data.csv.gz',
        'https://github.com/Josh-Murunga/Youtube-Analytics/releases/download/v1/IN_youtube_trending_data.csv.gz'
    ]
    
    dfs = []

    for url in urls:
        videos_dtypes = {
            'video_id': str,
            'title': str,
            'channelId': str,
            'channelTitle':str,
            'categoryId':pd.Int64Dtype(),
            'tags':str,
            'view_count':pd.Int64Dtype(),
            'likes': pd.Int64Dtype(),
            'dislikes': pd.Int64Dtype(),
            'comment_count':pd.Int64Dtype(),
            'thumbnail_link':str,
            'comments_disabled':bool,
            'ratings_disabled':bool,
            'description':str
        }

        # native date parsing 
        parse_dates = ['publishedAt', 'trending_date']

        chunks = pd.read_csv(url, sep=',', compression='gzip', dtype=videos_dtypes, parse_dates=parse_dates, chunksize=5000)
        
        for chunk in chunks:
            dfs.append(chunk)

    return pd.concat(dfs, ignore_index=True)


@test
def test_output(output, *args) -> None:
    """
    Template code for testing the output of the block.
    """
    assert output is not None, 'The output is undefined'
