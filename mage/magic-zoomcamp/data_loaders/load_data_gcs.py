import pyarrow as pa
import pyarrow.parquet as pq
from pyarrow.fs import GcsFileSystem

@data_loader
def load_data(*args, **kwargs):
    config_path = path.join(get_repo_path(), 'io_config.yaml')
    config_profile = 'default'

    bucket_name = 'youtube-analytics-datalake'
    blob_prefix = 'youtube_trends/*.parquet'
    root_path = f"{bucket_name}/{blob_prefix}"    
    pa_table = pq.read_table(
        source=root_path,
        filesystem=GcsFileSystem(),        
    )

    return pa_table.to_pandas()