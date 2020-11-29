WITH target_customer_month_log AS(
  -- 데이터 구조를 알기 쉽도록 2단계의 With를 이용
  -- 고객 테이블과 월 마스터 테이블을 전결합 하여 예측 단위의 기본이 되는 데이터를 구축
  WITH customer_month_log AS(
    SELECT
      cus.customer_id,
      cus.age,
      cus.sex,
      mst.year_num,
      mst.month_num,
      TO_DATE(mst.month_first_day, 'YYYY-MM-DD') AS month_first_day,
      TO_DATE(mst.month_last_day, 'YYYY-MM-DD') AS month_last_day
    FROM work.customer_tb cus
    CROSS JOIN work.month_mst mst

    -- 기간은 2016-04-01 부터 2017-04-01까지의 1년이 아니라 시작 시점을 과거 3개월 부터로 연장하고있다
    -- 이유는 마지막 단계에서 최대 3개월 이전의 예약 플래그를 설명 변수로 추가하기 때문
    WHERE mst.month_first_day >= '2016-01-01'
      AND mst.month_first_day < '2017-04-01'
  )
  -- 예약 테이블을 결합하여 예약 플래그를 부여
  -- 뒷 단계에서 설명 변수를 만들기 위해 예약 테이블과 다시 결합하는 처리가 있어,
  -- 처리를 묶을 수도 있지만, 이번에는 알아보기 쉽도록 분할하여 진행
  , tmp_rsvflg_log AS(
    SELECT
      base.customer_id,
      base.sex,
      base.age,
      base.year_num,
      base.month_num,
      base.month_first_day,

      -- 예약 플래그를 작성
      CASE WHEN COUNT(target_rsv.reserve_id) > 0 THEN 1 ELSE 0 END
        AS rsv_flg

    FROM customer_month_log base

    -- 대상 월의 기간에 해당하는 예약 테이블을 결합
    LEFT JOIN work.reserve_tb target_rsv
      ON base.customer_id = target_rsv.customer_id
      AND TO_DATE(target_rsv.reserve_datetime, 'YYYY-MM-DD HH24:MI:SS')
          BETWEEN base.month_first_day AND base.month_last_day

    GROUP BY base.customer_id,
             base.sex,
             base.age,
             base.year_num,
             base.month_num,
             base.month_first_day
  )
  -- LAG 함수로 1~3개월 이전의 예약 플래그를 부여
  , rsvflg_log AS(
    SELECT
      *,

      -- 1개월 전의 예약 플래그
      LAG(rsv_flg, 1) OVER(PARTITION BY customer_id
                           ORDER BY month_first_day)
        AS before_rsv_flg_m1,

      -- 2개월 전의 예약 플래그
      LAG(rsv_flg, 2) OVER(PARTITION BY customer_id
                           ORDER BY month_first_day)
        AS before_rsv_flg_m2,

      -- 3개월 전의 예약 플래그
      LAG(rsv_flg, 3) OVER(PARTITION BY customer_id
                           ORDER BY month_first_day)
        AS before_rsv_flg_m3

    FROM tmp_rsvflg_log
  )
  -- 고객 별로 특정 월의 데이터를 샘플링하기 위해서 난수로 순위를 부여
  , rsvflg_target_log AS(
    SELECT
      *,

      -- 난수로 순위를 계산
      ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY RANDOM())
        AS random_rank

    FROM rsvflg_log

    -- 2016년도 (2016-04-01 ~ 2017-03-31）데이터로 필터링
    WHERE month_first_day >= '2016-04-01'
      AND month_first_day < '2017-04-01'
  )
  -- 난수에 의한 순위를 이용하여 랜덤 샘플링
  SELECT * FROM rsvflg_target_log where random_rank = 1
)
-- 과거 1년(365일)의 예약 레코드와 결합하여 설명 변수를 만들기 위한 데이터를 준비
, rsvflg_and_history_rsv_log AS(
  SELECT
    base.*,
    before_rsv.reserve_id AS before_reserve_id,

    -- 예약일로 변환
    TO_DATE(before_rsv.reserve_datetime, 'YYYY-MM-DD HH24:MI:SS')
      AS before_reserve_date,
    before_rsv.total_price AS before_total_price,

    -- 숙박인원이 1명인 플래그를 계산
    CASE WHEN before_rsv.people_num = 1 THEN 1 ELSE 0 END
      AS before_people_num_1,

    -- 숙박인원이 2명 이상인 플래그를 계산
    CASE WHEN before_rsv.people_num >= 2 THEN 1 ELSE 0 END
      AS before_people_num_over2,

    -- 과거에 숙박한 달과 같은 달인지(년도는 달라도 상관 없음) 여부를 계산
    CASE
      WHEN base.month_num =
        CAST(DATE_PART(MONTH, TO_DATE(before_rsv.reserve_datetime,
                                      'YYYY-MM-DD HH24:MI:SS')) AS INT)
        THEN 1 ELSE 0 END AS before_rsv_target_month

  FROM target_customer_month_log base

  -- 같은 고객의 과거 1년(365일간)의 예약 테이블을 결합
  LEFT JOIN work.reserve_tb before_rsv
    ON base.customer_id = before_rsv.customer_id
    AND TO_DATE(before_rsv.checkin_date, 'YYYY-MM-DD')
        BETWEEN DATEADD(DAY, -365,
                        TO_DATE(base.month_first_day, 'YYYY-MM-DD'))
            AND DATEADD(DAY, -1,
                        TO_DATE(base.month_first_day, 'YYYY-MM-DD'))
)
-- 결합한 과거 1년간의 예약 레코드를 집약하여, 설명 변수로 변환
--（앞 단계의 SQL과 묶는것도 가능）
SELECT
  customer_id,
  rsv_flg,
  sex,
  age,
  month_num,
  before_rsv_flg_m1,
  before_rsv_flg_m2,
  before_rsv_flg_m3,

  -- 과거 1년간의 예약 금액 합계를 계산(예약이 없으면 0원으로 보완)
  COALESCE(SUM(before_total_price), 0) AS before_total_price,

  -- 과거 1년간의 예약 횟수
  COUNT(before_reserve_id) AS before_rsv_cnt,

  -- 과거 1년간의 숙박인원이 1명인 예약 횟수
  SUM(before_people_num_1) AS before_rsv_cnt_People_num_1,

  -- 과거 1년간의 숙박인원이 2명 이상인 예약 횟수
  SUM(before_people_num_over2) AS before_rsv_cnt_People_num_over2,

  -- 최근 예약 일이 몇일 전인지를 계산
  -- （최근 예약이 없으면 1년전(365일전) + 1일 전인 366일로 보완）
  COALESCE(DATEDIFF(day, MAX(before_reserve_date), month_first_day), 0)
    AS last_rsv_day_diff,

  -- 과거 1년간 같은 달에 예약한 횟수를 계산
  SUM(before_rsv_target_month) AS before_rsv_cnt_target_month

FROM rsvflg_and_history_rsv_log
GROUP BY
  customer_id,
  sex,
  age,
  month_num,
  before_rsv_flg_m1,
  before_rsv_flg_m2,
  before_rsv_flg_m3,
  month_first_day,
  rsv_flg,
  month_first_day

  
