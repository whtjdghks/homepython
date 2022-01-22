/*
SQL 고급
*/

-- CREATE TABLE AS SELECT
-- city 테이블과 똑같은  city2 테이블 생성
use world;
create table city2 as select * from city;

select * from city2;

-- CREATE DATABASE
-- createdatabase 문은 새로운 데이터 베이스를 생성
-- use 문으로 새 데이터 베이스 사용

show databases;

use sunghwan;

select * from test;

-- UI 가 아닌 손으로 짜기

create table test2 (
	id int not null primary key,
    col1 int null,
    col2 float null,
    col3 varchar(45) null
);


select * from test2;

-- ALTER TABLE 
-- 테이블에 컬럼 추가

alter table test2 
add col4 int null;  -- test2 테이블에 col4를 추가 

select * from test2;

desc test2;

-- 테이블 수정
alter table test2
modify col4 varchar(20) null;
-- 연습
alter table test
modify col2 float;

desc test2; -- 수정된 테이블 확인 가능

-- 컬럼 삭제
-- DROP
alter table test2
drop col4;

desc test2; -- col4가 삭제된걸 확인 가능

/*
인덱스(INDEX)
테이블에서 데이터를 빠르게 찾기 위해 사용
*/

CREATE INDEX col1idx
on test (col1);
-- 인덱스 정보 확인
show index from test;

-- 중복 값을 허용하지 않는 인덱스 생성
create unique index col2idx
on test (col2);

show index from test;

-- fulltext index
-- 일반적인 인덱스와는 달리 매우 빠르게 테이블의 모든 텍스트 컬럼을 검색한다alter
alter table test
add fulltext col3idx(col3);

show index from test;

-- INDEX(인덱스)삭제
alter table test
drop index col3idx;

show index from test;
-- 다른 방법
drop index col2idx on test;

show index from test; -- 삭제된 col2idx를 확인할 수 있다.

/*
VIEW

-뷰는 데이터 베이스에 존재하는 일종의 가상 테이블
-실제 테이블 처럼 행과 열을 가지고 있지만 , 실제로 데이터를 저장하지 않는다
-mysql에서 뷰는 다른 테이블이나 다른 뷰에 저장되어 있는 데이터를 보여주는 역할만 수행
-뷰를 사용하면 여러 테이블이나 뷰를 하나의 테이블 처럼 볼 수 있다.

장/단점

장 
- 특정 사용자에게 테이블 전체가 아닌 필요한 컬럼만 보여줄 수 있다
- 복잡한 쿼리를 단순화 해서 사용
- 쿼리 재사용 가능

단
- 한 번 정의된 뷰는 변경할 수 없음
- 삽입,삭제,갱신 작업에 많은 제한 사항을 가짐
- 자신만의 인덱스를 가질 수 없다
*/
-- view 생성
create view testview as
select col1,col2 from test;

select * from testview; -- 수정전

-- view 수정
alter view testview as
select col1,col2,col3 from test;

select * from testview; -- 수정후

-- view 삭제 
drop view testview;
-- 연습 문제--
/*
city , country , countrylanguage 테이블 join하고,한국에 대한 정보만 뷰 생성
*/

use world;

alter view allview as
select city.Name , country.surfacearea,city.population,countrylanguage.language
from city
join country on city.countrycode = country.code
join countrylanguage on city.countrycode = countrylanguage.countrycode
where city.countrycode = 'kor';

select * from allview;
-- 위에 처럼 원하는 데이터를 확인할 수 있다.

/*
INSERT
-테이블 이름 다음에 나오는 열 생략 가능
-생략할 경우 VALUE 다음에 나오는 값들의 순서 및 개수가 테이블이
정의된 열 순서 및 갯수와 동일해야한다
*/

use sunghwan;


-- 테이블 안의 값 추가
insert into test
value(1,123,1.1,'Test');
-- 연습
insert into test
value(4,678,4.4,'TEST');

insert into test
value(5,987,5.5,'test');

select * from test;

/*
INSERT INTO SELECT
test테이블에 있는 내용을 test2 테이블에 삽입
*/
insert into test2 select * from test; -- 일종의 테이블 복사같은 느낌이다

select * from test2; -- test의 정보가 test2에 복사 된것을 확인가능

/*
UPDATE
기존에 입력되어 있는 값 변경하는 구문
WHERE 절 생략 가능하나 테이블의 전체 행의 내용 변경
*/
UPDATE test
set col1 = 1 , col2 = 1.0 , col3 ='test'
where id = 1;

select * from test;

/*
DELETE - 데이터복구 가능함!!
행 단위로 데이터 삭제하는 구문이다

DELETE FROM 테이블이름 WHERE 조건;

-데이터는 지워지지만 테이블 용량은 줄어들지 않는다
-원하는 데이터만 지울수 있다.
-삭제 후 잘못 삭제한 것을 되돌릴수 있다.
*/

DELETE FROM test
where id = 5; -- where을 넣어줘야 전체가 날아가는 일을 막을수있다!

select * from test;

/*
TRUNCATE - 데이터 복구 불가능함!! 주의!!
- 용량이 줄어들고 , 인덱스 등도 모두 삭제
- 테이블은 삭제하지 않고 , 데이터만 삭제
- 한꺼번에 다 지워야한다
- 삭제 후 절대 되돌릴 수 없다.
*/

TRUNCATE TABLE test;

select * from test;
/*
DROP TABLE
- 테이블 전체를 삭제, 공간 , 객체를 삭제한다
- 삭제 후 절대 되돌릴 수 없다.
*/
DROP TABLE test;


/*
DROP DATABASE
- DROP DATABASE 문은 해당 데이터 베이스를 삭제한다!
*/

DROP DATABASE sunghwan;