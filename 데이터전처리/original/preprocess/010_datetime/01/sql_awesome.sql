SELECT
  -- timestamptz로 변환
  TO_TIMESTAMP(reserve_datetime, 'YYYY-MM-DD HH24:MI:SS')
    AS reserve_datetime_timestamptz,

  -- timestamptz로 변환한 후, timestamp로 변환
  CAST(
    TO_TIMESTAMP(reserve_datetime, 'YYYY-MM-DD HH24:MI:SS') AS TIMESTAMP
  ) AS reserve_datetime_timestamp,

  -- 날짜와 시각을 문자열로 결합한 후, TIMESTAMP로 변환
  TO_TIMESTAMP(checkin_date || checkin_time, 'YYYY-MM-DDHH24:MI:SS')
    AS checkin_timestamptz,

  -- 일시 문자열을 날짜형으로 변환(시각 정보는 변환후 제거 된다)
  TO_DATE(reserve_datetime, 'YYYY-MM-DD HH24:MI:SS') AS reserve_date,

  -- 날짜 문자열을 날짜형으로 변환
  TO_DATE(checkin_date, 'YYYY-MM-DD') AS checkin_date

FROM work.reserve_tb
