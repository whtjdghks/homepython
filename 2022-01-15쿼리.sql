
SELECT *
FROM city
where CountryCode = 'KOR'
AND Population > 1000000;


select * 
from city
where Population between 7000000 and 8000000;
-- 사이 값을 불러온다

select *
from city
where Name in('Seoul','New York','Tokyo');

select *
from city
where CountryCode in('KOR','USA','JPN');
 
-- 주석 문자열 시작 찾기 LIKE

select *
from city
where NAME LIke 'Tel %';
-- 문자열 검색시 기억안날때 유용해보인다

select *
from city
where CountryCode LIke 'KO_';
-- 서브 쿼리
select *
from city
where CountryCode = ( select CountryCode
					   from city
						where Name = 'Seoul');

-- ANY == some 서브쿼리의 여러개의 결과중 한가지만 만족해도 가능
-- SOME 은 ANY 와 동일한 의미로 사용
-- ANY 구문은 IN 과 동일한 의미
select *
from city
where Population >  ANY ( select Population
							from city
                             where District = 'New York');
-- 하나라도 만족하면 실행
-- select Population
-- from city
-- where District = 'New York'

select *
from city
where Population >  some ( select Population
							from city
                             where District = 'New York');
-- 서브쿼리 any 랑 some은 동일하다

-- ALL 은 서브쿼리의 여러개의 결과를 모두 만족 시켜야한다
select *
from city
where Population > all ( select Population
						 from city
                         where District = 'New York'  ) ;
                         
-- ORDER BY
-- 결과가 출력되는 순서를 조절하는 구문
-- 인구수 내림 차순 디폴트 값이 오름차순 

-- desc 내림차순 디센딩
select *
from city
order by Population desc;

-- asc 어센딩 오름차순 생략가능
select *
from city
order by Population asc;

-- ORDER BY  혼용
select *
from city
order by CountryCode asc , Population desc;

-- 인구수로 내림차순하여 한국에 있는 도시보기 
-- 국가 면적 크기(SurfaceArea)로 내림차순 하여 나라보기

select *
from city
where CountryCode = 'KOR'
order by Population desc;

DESC Country; -- country 테이블 확인


select *
from country
order by SurfaceArea DESC; -- 국가 면적 기준 내림차순

-- DISTINCT  중복된 것은 1개씩만 보여주면서 출력 | 테이블 크기가 클수록 효율적이다

select distinct CountryCode
from city;

/*
LIMIT
출력 갯수 제한
상위의 N개만 출력하는 LIMIT N 구문
서버의 처리량을 많이 사용해 서버의 전반적인 성능을 나쁘게 하는 악성 쿼리문 개선할 때 사용
*/

select * 
from city
order by Population desc
limit 10; -- 갯수제한

/* 
GROUP BY
그룹으로 묶어주는 역할
집계함수를 함계사용한다
AVG():평균
MIN():최소값
MAX():최대값
COUNT():행의갯수
COUNT(DISTINCT):중복 제외된 행의 개수
STDEV():표준편차
VARIANCE():분산
- 효율적인 데이터 그룹화 Grouping
-읽기좋게 하기 위해 별칭 Alias 사용
*/

select CountryCode , avg(Population) as '평균'
from city
group by CountryCode;

/*
도시는 몇개인가?
도시들의 평균 인구수는?
*/
-- 도시의 갯수

select count(*)
from city;

-- 도시들의 평균 인구수

select avg(Population)
from city;

/*
HAVING
where과 비슷한 개념으로 조건제한
집계함수에 대해서 조건 제한하는편리한개념이다
HAVING 절은 반드시 GROUP BY 절 다음에 나와야한다
*/

select CountryCode, MAX(Population)
from city
group by CountryCode
having max(Population)>8000000;
-- group by로 묶였을때 조건을 준다

/*
ROLLUP
총합 또는 중간 합계가 필요한 경우에 사용한다
GROUP BY 절과 함께 WITH ROLLUP 문 사용
각각의 모든 집계결과를 보여준다?
*/

select CountryCode as '국가코드', Name as '국가명',sum(Population) as '집계'
from city
group by CountryCode , Name with rollup;
-- 결과값을 합쳤을때의 결과값을 보여준게 sum

/*
JOIN
데이터베이스 내의 테이블에서 가져온 
레코드를 조합하여 하나의 테이블이나 집합으로 표현
*/

select *
from city
join country on city.CountryCode = country.Code;
-- city의 countrycode와 country의 code가 같은것 끼리 조인


/*
city , country , countrylanguage 3개 합치기
*/

select *
from city
join country on city.CountryCode = Country.Code
join Countrylanguage on city.CountryCode = countrylanguage.CountryCode;

/*
LENGTH()
전달받은 문자열의 길이를 반환
*/
select length('123456789');

/*
CONCAT()
전달받은 문자열을 모두 결합하여 하나의 문자열로 반환
전달받은 문자열중 하나라도 NULL이 존재하면 NULL을 반환
*/

select concat('my','sql op','en source');

/*
LOCATE()
문자열 내에서 찾는 문자열이 처음으로 나타나는 위치를 찾아서 해당 위치를 반환
찾는 문자열이 문자열 내에 존재하지 않으면 0 을반환
mysql에서 문자열의 시작 인덱스를 1부터 계산
*/

select locate('abc','avavavavavcavavabc');

/*
left(),right()
left() : 문자열의 왼쪽부터 지정한 개수만큼의 문자를 반환
right() : 문자열의 오른쪽부터 지정한 개수만큼의 문자를 반환
*/

select 
left('my  mangmetn sytem',5),
right('my  mangmetn sytem',5);

/*
lower() : 문자열의 문자를 모두 소문자로 변경
upper() : 문자열의 문자를 모두 대문자로 변경
*/

select 
LOWER('my  mangmetn sytem'),
UPPER('my  mangmetn sytem');

/*
REPLACE()
문자열에서 특정 문자열을 대체 문자열로 교체
*/

select replace('mssql','ms','my');

/*
TRIM()
문자열을 자를때
공백 제거 및 특수 기호 제거용
*/

select trim('             mysql        '),
trim(LEADING '#' FROM '###MYSQL##'), -- 앞에 #이 있으면 없앨것
trim(TRAILING '#' FROM '###MYSQL##'); -- 뒤에 #이 있으면 없앨것

/*
FORMAT()
숫자 타입의 데이터를 세 자리마다 쉼표(,)를 사용하는 
'#,###,###.##' 형식으로 변환
반환 되는 데이터 형식은 문자열 타입이다
두번째 인수는 반올림할 소수 부분의 자릿수
쉼표 추가용
*/

select format(1263612132123.1231321321,3);
-- 소수점도 n 자릿수로 변환

/*
FLOOR() : 내림
CEIL() : 올림 
ROUND() : 반올림
*/

select floor(10.95),ceil(10.95),round(10.95);

/*
수학관련
SQRT():양의 제곱근 
POW():첫 번째 인수로는 밑수를 전달하고 ex) n의n제곱
두번째 인수로는 지수를 전달하여 거듭제곱 계산
EXP():인수로 지수를 전달받아 ,e의 거듭제곱을 계산
LOG(): 자연로그 값을 계산
*/

select sqrt(4),pow(2,3),exp(3),log(3);

/*
SIN():사인값 반환
COS():코사인값 반환
TAN():탄젠트값 반환
*/

select sin(pi()/2),cos(pi()),tan(pi()/4);

/*
ABS(),RAND()
ABS(X): 절대값을 반환
RAND():0.0보다 크거나 같고 1.0보다 작은 하나의 실수를 무작위로 생성
*/

select abs(-3),rand(),round(rand()*100,0);


/*
NOW() 현재날짜와 시간을 반환
CURDATE() 현재 날짜 반환
CURTIME() 현재 시각을 반환
*/
select NOW(),CURTIME(),CURDATE();

/*
DATE() 전달 받은 값에 해당하는 나라 정보 반환
MONTH() 월에 해당하는 값을 반환하며 0 부터 12 사이의 값을 가짐
DAY() 일에 해당하는 값을 반환 //
HOUR() 시간에 해당하는 값을 반환 //
MINUTE() 분에 해당하는 값을 반환 //
SECOND() 초에 해당하는 값을 반환 //
*/
select now() as '현재',
date(now()) as '년월일',
month(now()) as '현재 월',
hour(now())as '현재 시간',
minute(now()) as '현재 분',
second(now()) as '현재 초';

/*
MONTHNAME() 월에 해당하는 이름을 반환
DAYNAME() 요일에 해당하는 이름을 반환
*/

select now(),
monthname(now()),
dayname(now()) ;

/*
DAYOFWEEK() 일자가 해당 주에서 몇번째 날인지 반환 1부터 7사이의 값을 반환 (일요일 =1, 토요일 =7)
DAYOFMONTH() 일자가 해당 월에서 몇번째 날인지를 반환 , 0부터 31 사이의 값을 반환
DAYOFYEAR() 일자가  해당연도에서 몇번째 날인지를 반환, 1부터 366사이의 값을 반환
*/

select dayofweek(now()),dayofmonth(now()),dayofyear(now())