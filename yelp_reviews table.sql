-- 2. For yelp_reviews table

create or replace table yelp_reviews (review_text variant)

COPY INTO yelp_reviews
FROM 's3://mynewsql/Yelp/'
CREDENTIALS = (
    AWS_KEY_ID = '****************************************'
    AWS_SECRET_KEY = '**********************************************'
)
FILE_FORMAT = (TYPE = JSON);

select * from yelp_reviews limit  10

create or replace table tbl_yelp_reviews as
select review_text:business_id :: string as business_id, 
review_text:date :: date as review_date,
review_text:user_id :: string as user_id,
review_text:stars :: number as review_stars,
review_text:text :: string as review_text,
analyze_sentiment(review_text) as sentiments
from yelp_reviews

--Checking the number of records in the tbl_yelp_reviews
select count(*) from tbl_yelp_reviews limit 100

--For looking at the data
select * from tbl_yelp_reviews limit 10
