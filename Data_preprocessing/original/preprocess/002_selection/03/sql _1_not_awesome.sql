SELECT *
FROM work.reserve_tb

-- 데이터 행 별로 난수를 생성하고, 난수가 작은 순서로 데이터를 정렬
ORDER BY RANDOM()

-- 샘플링할 건수를 LIMIT구문으로 지정
-- 미리 세어둔 데이터수를 입력하고 추출할 비율을 곱하고 ROUND로 반올림
LIMIT ROUND(120000 * 0.5)
