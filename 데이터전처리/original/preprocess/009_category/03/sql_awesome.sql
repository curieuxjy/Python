WITH customer_tb_with_age_rank AS(
  SELECT
    *,

    -- 연령을 10살 단위로 구분하여 카테고리화
    CAST(FLOOR(age / 10) * 10 AS TEXT) AS age_rank

  FROM work.customer_tb
)
SELECT
  customer_id, age, sex, home_latitude, home_longitude,

  -- 카테고리를 집약
  CASE WHEN age_rank = '60' OR age_rank = '70' OR age_rank = '80'
    THEN '60세 이상' ELSE age_rank END AS age_rank

FROM customer_tb_with_age_rank
