CREATE TABLE work.hotel_category_mst AS(
  SELECT
    -- 카테고리의 인덱스 번호 작성
	  ROW_NUMBER() OVER() - 1 AS hotel_category_no,

	  hotel_id
	FROM work.reserve_tb rsv

	-- 추천 대상 데이터에 해당하는 호텔만으로 축약
	WHERE rsv.checkin_date >= '2016-01-01'
	  AND rsv.checkin_date < '2017-01-01'

	GROUP BY hotel_id
)
