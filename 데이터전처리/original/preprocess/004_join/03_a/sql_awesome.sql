SELECT
	*,

	-- LAG 함수를 이용하여 2건 전의 total_price를 before_price로 구함
	-- LAG 함수로 참조할 그룹을 customer_id로 지정
	-- LAG 함수로 참조할 그룹의 데이터를 reserve_datetime이 오래된 순서로 정렬
  LAG(total_price, 2) OVER
	(PARTITION BY customer_id ORDER BY reserve_datetime) AS before_price

FROM work.reserve_tb