WITH tmp_log AS(
  SELECT
    -- reserve_datetime을 TIMESTAMP형으로 변환
    CAST(
      TO_TIMESTAMP(reserve_datetime, 'YYYY-MM-DD HH24:MI:SS') AS TIMESTAMP
    ) AS reserve_datetime,

    -- reserve_date를 DATE형으로 변환
    TO_DATE(reserve_datetime, 'YYYY-MM-DD HH24:MI:SS') AS reserve_date

  FROM work.reserve_tb
)
SELECT
  -- reserve_datetime에 1일 더한다
  reserve_datetime + interval '1 day' AS reserve_datetime_1d,

  -- reserve_date에 1일 더한다
  reserve_date + interval '1 day' AS reserve_date_1d,

  -- reserve_datetime에 1시간 더한다
  reserve_datetime + interval '1 hour' AS reserve_datetime_1h,

  -- reserve_datetime에 1분 더한다
  reserve_datetime + interval '1 minute' AS reserve_datetime_1m,

  -- reserve_datetime에 1초 더한다
  reserve_datetime + interval '1 second' AS reserve_datetime_1s

FROM tmp_log
