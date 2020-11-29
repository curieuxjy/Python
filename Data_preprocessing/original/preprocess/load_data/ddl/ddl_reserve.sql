-- 작성할 테이블의 이름을 work.reserve_tb로 설정
CREATE TABLE work.reserve_tb
(
  -- reserve_id 열을 설정(데이터열은 문자열, null 값을 허용하지 않음)
  reserve_id TEXT NOT NULL,

  -- hotel_id 열을 설정(데이터 형은 문자열, null을 허용하지 않음)
  hotel_id TEXT NOT NULL,

  -- customer_id 열을 설정(데이터 형은 문자열, null을 허용하지 않음) 
  customer_id TEXT NOT NULL,

  -- reserve_datetime 열을 설정(데이터 형은 타임 스템프, null을 허용하지 않음) 
  reserve_datetime TIMESTAMP NOT NULL,

  -- checkin_date 열을 설정 (데이터 형은 날짜, null을 허용하지 않음)
  checkin_date DATE NOT NULL,

  -- checkin_time 열을 설정 (데이터 형은 문자열, null을 허용하지 않음)
  checkin_time TEXT NOT NULL,

  -- checkout_date 열을 설정 (데이터 형은 날짜, null을 허용하지 않음)
  checkout_date DATE NOT NULL,

  -- people_num 열을 설정(데이터 형은 정수, null을 허용하지 않음)
  people_num INTEGER NOT NULL,

  -- total_price 열을 설정 (데이터 형은 정수, null을 허용하지 않음)
  total_price INTEGER NOT NULL,

  -- reserve_id를 키값(테이블에서 유일한 값이 되는 열)으로 설정
  PRIMARY KEY(reserve_id),

  -- hotel_id를 외부 키(다른 테이블과 같은 내용을 표시하는 열)로 설정
  -- 대사은 호탤 마스터의 호텔 ID
  -- 대상 Key를 가지는 테이블은 작성 완료 돠어있어야함
  -- 대상 Key는 PRIMARY KEY로 설정되어 있어야함
  FOREIGN KEY(hotel_id) REFERENCES work.hotel_tb(hotel_id),

  -- customer_id를 외부 키(다른 테이블과 같은 내용을 표시하는 열)로 설절 
  -- 対象は、顧客マスタの顧客ID
  FOREIGN KEY(customer_id) REFERENCES work.customer_tb(customer_id)
)
-- 데이터 분석 방식을 KEY(지정한 열의 값에 따라 분산)로 설정
DISTSTYLE KEY

-- 분산 KEY를 checkin_date로 설정
DISTKEY (checkin_date);

-- 데이터를 로드할 테이블을 work.reserve_tbに로 지정
COPY work.reserve_tb

-- S3에 있는 reserve.csv파일을 로드할 csv파일로 지정
FROM 's3://example.hanbit.com/reserve.csv'

-- S3에 접속하기 위한 AWS의 인증 정보 설정
CREDENTIALS 'aws_access_key_id=XXXXX;aws_secret_access_key=XXXXX'

-- 사용할 리젼(클라우드 서비스 지역)을 설정
REGION AS 'ap-northeast-2'

-- CSV파일의 첫번째 행에들어있는 열이름을 로드 하맂 않도록 설정
CSV IGNOREHEADER AS 1

-- DATE형읋 변환할 포맷을 지정
DATEFORMAT 'YYYY-MM-DD'

-- TIMESTAMP형을 변환할 포맷을 지정
TIMEFORMAT 'YYYY-MM-DD HH:MI:SS';
