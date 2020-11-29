SELECT *
FROM work.reserve_tb

-- 인덱스를 적용하기 위해 checkin_date로도 조건을 지정
WHERE checkin_date BETWEEN '2016-10-10' AND '2016-10-13'
  AND checkout_date BETWEEN '2016-10-13' AND '2016-10-14'
