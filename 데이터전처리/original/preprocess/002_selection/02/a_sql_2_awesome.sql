SELECT *
FROM work.reserve_tb

-- checkin_date가 2016-10-12에서 2016-10-13까지의 데이터로 한정
WHERE checkin_date BETWEEN '2016-10-12' AND '2016-10-13'
