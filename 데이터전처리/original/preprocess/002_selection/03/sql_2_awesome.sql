SELECT *
FROM work.reserve_tb

-- 난수를 생성하고 0.5이하의 데이터 행만 선택
WHERE RANDOM() <= 0.5
