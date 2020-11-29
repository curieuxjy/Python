SELECT
  -- reserve_id를 선택 （AS를 사용하여 이름을 rsv_time으로 변경）
  reserve_id AS rsv_time,

  -- hotel_id,customer_id,reserve_datetime을 선택
  hotel_id, customer_id, reserve_datetime,

  -- checkin_date, checkin_time, checkout_date를 선택
  checkin_date, checkin_time, checkout_date

FROM work.reserve_tb