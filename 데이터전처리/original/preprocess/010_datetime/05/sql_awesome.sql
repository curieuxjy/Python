WITH tmp_log AS(
  SELECT
    -- reserve_datetime을 TIMESTAMP형으로 변환하고 월을 얻음
    DATE_PART(
      month,
      CAST(
        TO_TIMESTAMP(reserve_datetime, 'YYYY-MM-DD HH24:MI:SS') AS TIMESTAMP
      )
    ) AS reserve_month

  FROM work.reserve_tb
)
SELECT
  CASE
    -- 월이 3이상 5이하일 땐 spring을 반환한다
    WHEN 3 <= reserve_month and reserve_month <= 5 THEN 'spring'

    -- 월이 6이상 8이하일 땐 summer를 반환한다
    WHEN 6 <= reserve_month and reserve_month <= 8 THEN 'summer'

    -- 월이 9이상 11 이하일 땐 autumn을 반환한다
    WHEN 9 <= reserve_month and reserve_month <= 11 THEN 'autumn'

    -- 위에 해당하지 않는 경우(월이 1,2,12인 경우)엔 winter를 반환한다
    ELSE 'winter' END

  AS reserve_season
FROM tmp_log
