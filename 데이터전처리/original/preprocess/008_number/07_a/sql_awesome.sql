SELECT *
FROM work.production_missn_tb

-- thickness가 null인 레코드 제거
WHERE thickness is not NULL
