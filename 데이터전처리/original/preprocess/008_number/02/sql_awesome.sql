SELECT
	*,

  -- total_price를 1000으로 나누고 1을 더한 결과를 대수화
  LOG(total_price / 1000 + 1) AS total_price_log

FROM work.reserve_tb
