SELECT
  c_mst.customer_category_no,
  h_mst.hotel_category_no,

	-- 예약 수를 계산
  COUNT(rsv.reserve_id) AS rsv_cnt

FROM work.reserve_tb rsv

-- 고객의 카테고리 마스터와 결합
INNER JOIN work.customer_category_mst c_mst
  ON rsv.customer_id = c_mst.customer_id

-- 호텔의 카테고리 마스터와 결합
INNER JOIN work.hotel_category_mst h_mst
  ON rsv.hotel_id = h_mst.hotel_id

-- 추천 대상 데이터에 해당하는 호텔만으로 축약
WHERE rsv.checkin_date >= '2016-01-01'
  AND rsv.checkin_date < '2017-01-01'

GROUP BY c_mst.customer_category_no,
		     h_mst.hotel_category_no
