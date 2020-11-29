-- 예약 테이블과 호텔 테이블을 모두 결합
WITH rsv_and_hotel_tb AS(
	SELECT
		-- 필요한 열 추출
	  rsv.reserve_id, rsv.hotel_id, rsv.customer_id,
	  rsv.reserve_datetime, rsv.checkin_date, rsv.checkin_time,
		rsv.checkout_date, rsv.people_num, rsv.total_price,
	  hotel.base_price, hotel.big_area_name, hotel.small_area_name,
	  hotel.hotel_latitude, hotel.hotel_longitude, hotel.is_business

	-- 결합 대상인 reserve_tb를 선택하여 테이블의 이름을 rsv로 설정
	FROM work.reserve_tb rsv

	-- 결합할 hotel_tb를 선택하여 테이블 이름을 hotel로 설정
	INNER JOIN work.hotel_tb hotel
		-- hotel_id가 같은 레코드를 결합하도록 조건을 지정
	  ON rsv.hotel_id = hotel.hotel_id
)
-- 결합된 테이블에서 조건에 부합하는 데이터 추출
SELECT * FROM rsv_and_hotel_tb

-- is_business가 True인 데이터를 추출
WHERE is_business is True

	-- people_num가 1인 데이터 추출1
  AND people_num = 1
