SELECT
	base.*,

  -- 휴일 플래그를 부여
  mst.holidayday_flg,

  -- 휴일 전날 플래그를 부여
  mst.nextday_is_holiday_flg

FROM work.reserve_tb base

-- 휴일 마스터와 결합
INNER JOIN work.holiday_mst mst
  ON base.checkin_date = mst.target_day
