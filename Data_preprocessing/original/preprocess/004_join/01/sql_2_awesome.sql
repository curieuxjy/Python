SELECT
  -- 필요한 열 추출
  rsv.reserve_id, rsv.hotel_id, rsv.customer_id,
  rsv.reserve_datetime, rsv.checkin_date, rsv.checkin_time, rsv.checkout_date,
  rsv.people_num, rsv.total_price,
  hotel.base_price, hotel.big_area_name, hotel.small_area_name,
  hotel.hotel_latitude, hotel.hotel_longitude, hotel.is_business

FROM work.reserve_tb rsv
  JOIN work.hotel_tb hotel
  ON rsv.hotel_id = hotel.hotel_id

    -- 호텔 데이블에서 비지니스 호텔 데이터만을 추출
    AND hotel.is_business is True

-- 예약 테이블에서 비지니스 호텔의 데이터만을 추출
AND rsv.people_num = 1
