CREATE TABLE work.holiday_mst
(
  target_day             TEXT NOT NULL,
  holidayday_flg         BOOLEAN NOT NULL,
  nextday_is_holiday_flg BOOLEAN NOT NULL
)
DISTSTYLE KEY
DISTKEY (target_day);

COPY work.holiday_mst
FROM 's3://example.hanbit.com/holiday_mst.csv'
CREDENTIALS 'aws_access_key_id=XXXXX;aws_secret_access_key=XXXXX'
REGION AS 'ap-northeast-2'
CSV IGNOREHEADER AS 1;
