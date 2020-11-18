WITH tmp_log AS(
	SELECT
		CAST(
      TO_TIMESTAMP(reserve_datetime, 'YYYY-MM-DD HH24:MI:SS') AS TIMESTAMP
    ) AS reserve_datetime_timestamp,
	FROM work.reserve_tb
)
SELECT
	-- DATE형은 DATE_PART함수를 이용 가능
	-- TIMESTAMPTZ형은 DATE_PART함수를 이용할 수 없음
	-- 년도를 얻음
	DATE_PART(year, reserve_datetime_timestamp)
	  AS reserve_datetime_year,

  -- 월을 얻음
	DATE_PART(month, reserve_datetime_timestamp)
	  AS reserve_datetime_month,

  -- 일을 얻음
	DATE_PART(day, reserve_datetime_timestamp)
	  AS reserve_datetime_day,

  -- 요일(0은 일요일, 1은 월요일)을 얻음
	DATE_PART(dow, reserve_datetime_timestamp)
	  AS reserve_datetime_day,

  -- 시각 정보의 시를 얻음
	DATE_PART(hour, reserve_datetime_timestamp)
	  AS reserve_datetime_hour,

  -- 시각 정보의 분을 얻음
	DATE_PART(minute, reserve_datetime_timestamp)
	  AS reserve_datetime_minute,

  -- 시각 정보의 초를 얻음
	DATE_PART(second, reserve_datetime_timestamp)
	  AS reserve_datetime_second,

  -- 지정한 포맷의 문자열로 변환
	TO_CHAR(reserve_datetime_timestamp, 'YYYY-MM-DD HH24:MI:SS')
	  AS reserve_datetime_char

FROM tmp_log
