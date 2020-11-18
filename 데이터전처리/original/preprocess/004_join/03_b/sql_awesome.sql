SELECT
  *,
  CASE WHEN

    -- COUNT 함수로 합계를 계산한 건수를 세서 3건인지 확인
		-- BETWEEN 구문으로 2건 전부터 
  	COUNT(total_price) OVER
		(PARTITION BY customer_id ORDER BY reserve_datetime ROWS
		 BETWEEN 2 PRECEDING AND CURRENT ROW) = 3

  THEN

    -- 자신을 포함한 3건의 합계 금액을 계산
  	SUM(total_price) OVER
		(PARTITION BY customer_id ORDER BY reserve_datetime ROWS
		 BETWEEN 2  PRECEDING AND CURRENT ROW)

  ELSE NULL END AS price_sum

FROM work.reserve_tb
