-- Creating external table referring to gcs path
CREATE OR REPLACE EXTERNAL TABLE `data-engineeing.youtube_analytics.external_youtube_trends`
OPTIONS (
  format = 'PARQUET',
  uris = ['gs://youtube-analytics-datalake/youtube_trends/*.parquet']
);

-- Count number of records
SELECT count(*) FROM `data-engineeing.youtube_analytics.external_youtube_trends`

-- View data
SELECT * FROM `data-engineeing.youtube_analytics.external_youtube_trends` LIMIT 50;

-- Partition data by trending date and cluster by category
CREATE OR REPLACE TABLE `data-engineeing.youtube_analytics.youtube_trends_partitioned_clustered`
PARTITION BY DATE(trending_date) 
CLUSTER BY categoryId
AS
SELECT * FROM `data-engineeing.youtube_analytics.external_youtube_trends`;

-- View partitioned data
SELECT * FROM `data-engineeing.youtube_analytics.youtube_trends_partitioned_clustered`

