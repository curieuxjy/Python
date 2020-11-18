CREATE TABLE work.hotel_tb
(
  hotel_id        TEXT NOT NULL,
  base_price      INTEGER NOT NULL,
  big_area_name   TEXT NOT NULL,
  small_area_name TEXT NOT NULL,
  hotel_latitude  FLOAT NOT NULL,
  hotel_longitude FLOAT NOT NULL,
  is_business     BOOLEAN NOT NULL,
  PRIMARY KEY(hotel_id)
)
DISTSTYLE KEY
DISTKEY (hotel_id);

COPY work.hotel_tb
FROM 's3://example.hanbit.com/hotel.csv'
CREDENTIALS 'aws_access_key_id=XXXXX;aws_secret_access_key=XXXXX'
REGION AS 'ap-northeast-2'
CSV IGNOREHEADER AS 1;
