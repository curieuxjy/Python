SELECT
	-- 결합할 모든 데이터열 얻기 
  base.*,

	-- 대상 건수가 0이면 0, 1건 이상 있으면 합계 금액을 계산
  COALESCE(SUM(combine.total_price), 0) AS price_sum

-- 결합할 예약 테이블 지정
FROM work.reserve_tb base

-- 과거 정보로 결합할 예약 테이블 지정
LEFT JOIN work.reserve_tb combine

	-- 같은 customer_id 로 결합
  ON base.customer_id = combine.customer_id

	-- 과거 데이터만을 결합 대상으로 지정
  AND base.reserve_datetime > combine.reserve_datetime

	-- 과거 90일 이전까지의 데이터만을 결합 대상으로 지정 ("10장 일시형"에서 자세히 설명)
  AND DATEADD(day, -90, base.reserve_datetime) <= combine.reserve_datetime

-- 결합할 예약 테이블의 모든 데이터열로 집약 
GROUP BY base.reserve_id, base.hotel_id, base.customer_id,
  base.reserve_datetime, base.checkin_date, base.checkin_time, base.checkout_date,
  base.people_num, base.total_price
