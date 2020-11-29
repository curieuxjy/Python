WITH rsv_cnt_table AS(
  SELECT
    -- Round 함수로 버림하여 total_price를 1000 단위의 값으로 변환
    ROUND(total_price, -3) AS total_price_round,

    -- COUNT 함수로 금액별 예약수 계산
    COUNT(*) AS rsv_cnt

  FROM work.reserve_tb

  -- AS로, 1000 단위로 집약한 열의 이름을 total_price_round로 지정
  GROUP BY total_price_round
)
SELECT
  total_price_round
FROM rsv_cnt_table

-- 괄호 안의 쿼리로 최빈값을 얻고, WHERE 구문으로 최빈값과 일치하는 것을 추출
WHERE rsv_cnt = (SELECT max(rsv_cnt) FROM rsv_cnt_table)
