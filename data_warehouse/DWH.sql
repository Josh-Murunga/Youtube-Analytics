-- Creating external table referring to gcs path
CREATE OR REPLACE EXTERNAL TABLE `ny_taxi.external_green_tripdata`
OPTIONS (
  format = 'PARQUET',
  uris = ['gs://datawarehouse-de/ny-taxi-data/green_tripdata_2022-*.parquet']
);

-- Count number of records
SELECT count(*) FROM `data-engineeing.ny_taxi.external_green_tripdata`;



