SELECT
  hotel_id,

  -- total_price의 최대값 산출
  MAX(total_price) AS price_max,

  -- total_price의 최소값 산출
  MIN(total_price) AS price_min,

  -- total_price의 평균값 산출
  AVG(total_price) AS price_avg,

  -- total_price의 중앙값 산출
  MEDIAN(total_price) AS price_med,

  -- PERCENTILE_CONT 함수에 0.2를 지정하여 20% 백분위를 산출
  -- ORDER BY 구문에 total_price를 지정하여 백분위 값의 대상 열과 데이터의 정렬 방식을 지정
  PERCENTILE_CONT(0.2) WITHIN GROUP(ORDER BY total_price) AS price_20per

FROM work.reserve_tb
GROUP BY hotel_id
