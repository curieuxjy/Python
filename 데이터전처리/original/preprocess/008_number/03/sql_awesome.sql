SELECT
	*,

  -- 10 단위의 값으로 변경
	FLOOR(age / 10) * 10 AS age_rank

FROM work.customer_tb
