SELECT
  *,

  -- ROW_NUMBER로 순위를 구함
  -- PARTITION by customer_id로 고객 별 순위를 구하도록 설정
  -- ORDER BY reserve_datetime으로 오래된 예약 시간 순으로 순위를 구함
  ROW_NUMBER()
    OVER (PARTITION BY customer_id ORDER BY reserve_datetime) AS log_no

FROM work.reserve_tb
