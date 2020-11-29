SELECT
  hotel_id,

  -- RANK 함수로 예약수 순위를 지정 
  -- COUNT(*)를 RANK의 기준으로 지정(집약 후의 예약수에 따라 순위를 정하는 계산)
  -- DESC로 내림 차순으로 정렬
  RANK() OVER (ORDER BY COUNT(*) DESC) AS rsv_cnt_rank

FROM work.reserve_tb

-- hotel_id를 집약 단위로 지정, 예약수를 계산하기 위한 설정으로 RANK 함수와는 무관
GROUP BY hotel_id
