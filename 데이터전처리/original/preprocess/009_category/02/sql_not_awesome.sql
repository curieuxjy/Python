SELECT
  -- 남성 플래그를 생성
  CASE WHEN sex = 'man' THEN TRUE ELSE FALSE END AS sex_is_man,

  -- 여성 플래그를 생성
	CASE WHEN sex = 'woman' THEN TRUE ELSE FALSE END AS sex_is_woman

FROM work.customer_tb
