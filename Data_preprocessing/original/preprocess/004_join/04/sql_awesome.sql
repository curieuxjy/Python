SELECT
	cus.customer_id,

	-- 연월 마스터 테이블에서 연을 구함
	mst.year_num,

	-- 연월 마스터에서 달을 구함
	mst.month_num,

	-- 해당 total_price가 존재하면 더하고, 없으면 0을 더한다
	SUM(COALESCE(rsv.total_price, 0)) AS total_price_month

FROM work.customer_tb cus

-- 고객 테이블과 연월 마스터를 상호 결합
CROSS JOIN work.month_mst mst

-- 고객 테이블과 연월 마스터와 예약 테이블을 결합
LEFT JOIN work.reserve_tb rsv
  ON cus.customer_id = rsv.customer_id
    AND mst.month_first_day <= rsv.checkin_date
    AND mst.month_last_day >= rsv.checkin_date

-- 연월 마스터의 기간 지정
WHERE mst.month_first_day >= '2017-01-01'
  AND mst.month_first_day < '2017-04-01'
GROUP BY cus.customer_id, mst.year_num, mst.month_num
