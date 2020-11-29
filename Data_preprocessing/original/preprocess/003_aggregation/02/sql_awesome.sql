SELECT
  hotel_id,
  people_num,

  -- SUM함수에 total_price를 지정하여 매출 합계 금액을 산출
  SUM(total_price) AS price_sum

FROM work.reserve_tb

-- 집약 단위를 hotel_id와 people_num의 조합으로 지정
GROUP BY hotel_id, people_num
