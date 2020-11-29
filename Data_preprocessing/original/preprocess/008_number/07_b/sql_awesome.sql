SELECT
  type,
  length,

  -- thickness의 결손값을 1로 보완
  COALESCE(thickness, 1) AS thickness,
  fault_flg
FROM work.production_missn_tb
