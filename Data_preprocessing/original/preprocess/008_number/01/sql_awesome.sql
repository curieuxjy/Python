SELECT
  -- 정수형으로 변환
  -- 40000/3로 기술하면, 정수형으로 계산 되어, 소수점은 계산 되지 않는다.
  CAST((40000.0 / 3) AS INT2) AS v_int2,
  CAST((40000.0 / 3) AS INT4) AS v_int4,
  CAST((40000.0 / 3) AS INT8) AS v_int8,

  -- 부동 소수점으로 변환
  CAST((40000.0 / 3) AS FLOAT4) AS v_float4,
  CAST((40000.0 / 3) AS FLOAT8) AS v_float8

-- 테이블 데이터는 필요 없지만, 계산을 위해 지정
FROM work.reserve_tb
LIMIT 1
