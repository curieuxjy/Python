SELECT
  ROUND(total_price, -3) AS total_price_round
FROM work.reserve_tb
GROUP BY total_price_round

-- COUNT 함수로 계산한 금액별 예약 수를 큰 순서대로 정렬(DESC 는 내림차순)
ORDER BY COUNT(*) DESC

-- LIMIT 구문으로 첫 번째 결과 값만 얻음
LIMIT 1