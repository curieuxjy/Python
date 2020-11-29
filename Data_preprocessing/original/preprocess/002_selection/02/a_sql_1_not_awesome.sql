SELECT *
FROM work.reserve_tb

-- WHERE 구문으로 추출할 데이터의 조건을 지정
-- checkin_date가 2016-10-12 이후의 데이터로 한정
WHERE checkin_date >= '2016-10-12'

  -- 여러 조건을 지정할 때는 WHERE 구문 이후에 AND 구문을 추가
  -- checkin_date가 2016-10-13 이전의 데이터로 한정
  AND checkin_date <= '2016-10-13'
