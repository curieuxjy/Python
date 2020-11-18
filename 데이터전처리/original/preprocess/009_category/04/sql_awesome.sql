SELECT
  *,

  -- sex와 연령을 10살 단위로 구분한 카테고리값을 문자열로 하여, 사이에 '_'를 더해서 결합
  sex || '_' || CAST(FLOOR(age / 10) * 10 AS TEXT) AS sex_and_age

FROM work.customer_tb
