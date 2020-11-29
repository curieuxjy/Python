-- small_area_name 별로 호텔 수를 계산, 결합 키를 판정하기 위한 테이블
WITH small_area_mst AS(
  SELECT
    small_area_name,

    -- 20건 이상이면 join_area_id에 small_area_name을 지정
    -- 20건 미만이면 join_area_id에 big_area_name을 지정
    -- -1로 자신을 제외
    CASE WHEN COUNT(hotel_id)-1 >= 20
			THEN small_area_name ELSE big_area_name END AS join_area_id

  FROM work.hotel_tb
  GROUP BY big_area_name, small_area_name
)
-- recommend_hotel_mst는 추천 후보를 위한 테이블
, recommend_hotel_mst AS(
  -- join_area_id를 big_area_name으로 한 추천 후보 마스터
  SELECT
    big_area_name AS join_area_id,
    hotel_id AS rec_hotel_id
  FROM work.hotel_tb

  -- union으로 테이블을 연결
  UNION

  -- join_area_id을 small_area_name으로 한 추천 후보 마스터
  SELECT
    small_area_name AS join_area_id,
    hotel_id AS rec_hotel_id
  FROM work.hotel_tb
)
SELECT
  hotels.hotel_id,
  r_hotel_mst.rec_hotel_id

-- 추천 대상의 hotel_tb 읽기
FROM work.hotel_tb hotels

-- 각 호텔의 추천 후보 대상 지역을 판단하기 위해 small_area_mst를 결합
INNER JOIN small_area_mst s_area_mst
  ON hotels.small_area_name = s_area_mst.small_area_name

-- 대상 지역의 추천 후보 결합
INNER JOIN recommend_hotel_mst r_hotel_mst
  ON s_area_mst.join_area_id = r_hotel_mst.join_area_id

  -- 추천 후보에서 자신을 제외
  AND hotels.hotel_id != r_hotel_mst.rec_hotel_id
