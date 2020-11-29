WITH tmp_log AS(
  SELECT
    -- reserve_datetime을 TIMESTAMP형으로 변환
    CAST(
      TO_TIMESTAMP(reserve_datetime, 'YYYY-MM-DD HH24:MI:SS') AS TIMESTAMP
    ) AS reserve_datetime,

    -- checkin_datetime을 TIMESTAMP형으로 변환
    CAST(
      TO_TIMESTAMP(checkin_date || checkin_time, 'YYYY-MM-DDHH24:MI:SS')
      AS TIMESTAMP
    ) AS checkin_datetime

  FROM work.reserve_tb
)
SELECT
  -- 년의 차를 계산(월 이하의 일시 요소는 고려하지 않음)
	DATEDIFF(year, reserve_datetime, checkin_datetime) AS diff_year,

  -- 월의 차이를 구함(일 이하의 일시 요소는 고려하지 않음)
	DATEDIFF(month, reserve_datetime, checkin_datetime) AS diff_month,

  -- 아래의 3가지는 문제에는 없지만 참고 용으로.

  -- 일의 차이를 계산(시간 이하의 일시 요소는 고려하지 않음)
	DATEDIFF(day, reserve_datetime, checkin_datetime) AS diff_day,

  -- 시의 차이를 계산（分이하의 일시 요소는 고려하지 않음）
	DATEDIFF(hour, reserve_datetime, checkin_datetime) AS diff_hour,

  -- 분의 차이를 계산（秒이하의 일시 요소는 고려하지 않음）
	DATEDIFF(minute, reserve_datetime, checkin_datetime) AS diff_minute,

  -- 일 단위로 차이를 계산
	CAST(DATEDIFF(second, reserve_datetime, checkin_datetime) AS FLOAT) /
    (60 * 60 * 24) AS diff_day2,

  -- 시간 단위로 차이를 계산
	CAST(DATEDIFF(second, reserve_datetime, checkin_datetime) AS FLOAT) /
	  (60 * 60) AS diff_hour2,

  -- 분 단위로 차이를 계산
  CAST(DATEDIFF(second, reserve_datetime, checkin_datetime) AS FLOAT) /
    60 AS diff_minute2,

  -- 초 단위로 차이를 계산
	DATEDIFF(second, reserve_datetime, checkin_datetime) AS diff_second
FROM tmp_log
