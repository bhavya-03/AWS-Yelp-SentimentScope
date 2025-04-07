-- 1. For yelp_business table

create or replace table yelp_businesses (businesses_text variant)

COPY INTO yelp_businesses
FROM 's3://mynewsql/Yelp/yelp_academic_dataset_business.json'
CREDENTIALS = (
    AWS_KEY_ID = '*********************************'
    AWS_SECRET_KEY = '***************************************'
)
FILE_FORMAT = (TYPE = JSON);

create or replace table tbl_yelp_businesses as
select businesses_text: business_id::string as business_id,
businesses_text: name::string as name,
businesses_text: categories::string as categories,
businesses_text: city::string as city,
businesses_text: state::string as state,
businesses_text: review_count::string as review_count,
businesses_text: stars::number as stars
from yelp_businesses limit 100

select * from tbl_yelp_businesses limit 10
