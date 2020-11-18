CREATE TABLE work.production_missn_tb
(
  type TEXT NOT NULL,
  length FLOAT NOT NULL,
  thickness FLOAT,
  fault_flg BOOLEAN NOT NULL
);

COPY work.production_missn_tb
FROM 's3://example.hanbit.com/production_missing_num_4_redshift.csv'
CREDENTIALS 'aws_access_key_id=XXXXX;aws_secret_access_key=XXXXX'
REGION AS 'ap-northeast-2'
CSV IGNOREHEADER AS 1;
