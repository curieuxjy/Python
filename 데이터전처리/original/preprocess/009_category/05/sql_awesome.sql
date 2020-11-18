-- 제품 종류별 제조수와 불량수를 계산
WITH type_mst AS(
	SELECT
		type,

    -- 제조수
		COUNT(*) AS record_cnt,

    -- 불량수
		SUM(CASE WHEN fault_flg THEN 1 ELSE 0 END) AS fault_cnt

	FROM work.production_tb
	GROUP BY type
)
SELECT
  base.*,

  -- 자신의 레코드를 제외한 제품 종류별 평균 불량률 
  CAST(t_mst.fault_cnt - (CASE WHEN fault_flg THEN 1 ELSE 0 END) AS FLOAT) /
    (t_mst.record_cnt - 1) AS type_fault_rate

FROM work.production_tb base
INNER JOIN type_mst t_mst
  ON base.type = t_mst.type
