SELECT
  -- 집약 단위인 호텔 ID 추출
  hotel_id,

  -- COUNT 함수에 reserve_id를 지정하고 있기 때문에, reserve_id NULL이 아닌 행을 카운트
  COUNT(reserve_id) AS rsv_cnt,

  -- customer_id에 distinct를 설정하여 중복을 제거
  -- 중복을 제거한 customer_id의 수를 센다
  COUNT(distinct customer_id) AS cus_cnt

FROM work.reserve_tb

-- GROUP BY 구문에서 지약할 단우를 hotel_id로 지정
GROUP BY hotel_id
