  -- 3. Sentiment Analysis
USE database SQL

  -- Create and insert statements
Create table reviews (review varchar(200));
insert into reviews values ('I love this product! It works Perfectly.');
insert into reviews values('This product is okay, but could be better.');
insert into reviews values('I hate this product. It stopped working after a week.');
insert into reviews values('This product is okay. Not that grreat.');
insert into reviews values('This product is not that good. But I can use.');

select review, analyze_sentiment(review) from reviews 
CREATE or replace function analyze_sentiment(text STRING)
returns string
language python
runtime_version = '3.8'
packages = ('textblob')
handler = 'sentiment_analyzer'
as $$
from textblob import TextBlob
def sentiment_analyzer(text):
    analysis = TextBlob(text)
    if analysis.sentiment.polarity > 0:
        return 'Positive'
    elif analysis.sentiment.polarity == 0:
        return 'Neutral'
    else:
        return 'Negative'
$$;
