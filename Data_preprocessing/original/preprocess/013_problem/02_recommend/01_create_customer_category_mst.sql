CREATE TABLE work.customer_category_mst AS(
  SELECT
    -- 카테고리의 인덱스 번호 작성(0이 시작이 되도록 1을 뺀다)
    ROW_NUMBER() OVER() - 1 AS customer_category_no,

    customer_id
  FROM work.reserve_tb rsv

  -- 추천 대상의 데이터에 해당하는 고객만으로 축약
  WHERE rsv.checkin_date >= '2016-01-01'
    AND rsv.checkin_date < '2017-01-01'

  GROUP BY customer_id
)