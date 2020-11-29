SELECT
  hotel_id,

  -- VARIANCE 함수에 total_price를 지정하여 분산값 산출
  -- COALESCE 함수로 분산값이 NULL일 때 0으로 변환
  COALESCE(VARIANCE(total_price), 0) AS price_var,

  -- 데이터 수가 2건 이상이면 STDDEV 함수에 total_price를 지정하여 표준편차 값을 산출
  COALESCE(STDDEV(total_price), 0) AS price_std

FROM work.reserve_tb
GROUP BY hotel_id