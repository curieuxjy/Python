-- WITH 구문으로 임시 테이블 reserve_tb_random을 생성
WITH reserve_tb_random AS(
  SELECT
    *,

    -- customer_id에 유일한 값이 되도록 난수 생성
    -- 생성된 난수를 할당하고 customer_id 별로 분류된 첫 번째 값을 random_num으로 가져온다.
    FIRST_VALUE(RANDOM()) OVER (PARTITION BY customer_id) AS random_num

  FROM work.reserve_tb
)
-- *으로 모든 열을 추출하고 있다. random_num을 제외 하려면 열을 지정해야 한다.
SELECT *
FROM reserve_tb_random

-- 50% 샘플링 customer_id에 설정된 난수가 0.5이하일 때만 추출
WHERE random_num <= 0.5
