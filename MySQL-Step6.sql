use empdb;

-- 목업데이터 생성
insert into member (select * from member);
select * from member;

/* member 테이블 생성
	아이디 varchar(20)
	이름 varchar(10) 
	암호 int
	폰번호 char(13)
	이메일 varchar(30)
	가입일 datetime
    
위의 스키마를 가진 테이블을 설계하시오. */

drop table if exists member; -- 테이블삭제

create table member (
	memberid varchar(20) comment '아이디',
	name varchar(10) comment '이름',
	pw int comment '암호',
	phone char(13) comment '전화번호',
	email varchar(30) comment '이메일',
	regtime datetime comment '등록일'
) comment '회원명단' default character set utf8;


#생성한 member 테이블의 구조를 확인하시오.
desc member;
describe member;

/* member 테이블에 아래의 데이터를 삽입후 조회하시오.
	'ID1','홍길동',1111,'010-1234-5678','HONG@nate.com','2023-03-29 14:06:10'
	'ID2','박길동',2222,'010-5678-1234','park@nate.com',현재날짜시각
	'ID3','우재남',3333,'010-8888-1234','wook@naver.com',현재날짜
*/
insert into member values 
('ID1','홍길동',1111,'010-1234-5678','HONG@nate.com','2023-03-29 14:06:10'),
('ID2','박길동',2222,'010-5678-1234','park@nate.com',now()),
('ID3','우재남',3333,'010-8888-1234','wook@naver.com',now());

select * from member;

#현재의 자동커밋설정 상태를 확인하시오.
select @@autocommit;

#폰번호 끝자리가 1234인 회원의 이름, 암호, 폰번호를 조회하시오. 
#이때 암호는 앞의 두자리만 표기후 나머지는 별표처리 하시오
select name, 
insert(pw, 3, char_length(pw)-2 , repeat('*',char_length(pw)-2))
phone from member where phone like '%1234'; 

/*
	테이블 수정
	
	1. 만약 기존 테이블의 컬럼을 수정해야 한다면 ...
		방법1) 'drop table 테이블명' 명령어로 새로 만든다.
			   단점은 데이터 저장된 상태라면 같이 삭제되며, 복구 안됨
			   
		방법2) alter table 테이블명 [명령키워드] 컬럼명 변경사항

	2. 컬럼의 타입수정시 데이터가 들어있는 경우 더 짧은 길이로는 수정이 불가능함 - truncate 에러발생
	
	3. modify 명령어는 타입수정시 사용
	4. change 명령어는 컬럼명과 타입을 동시에 수정할 때 사용(타입만 수정할때도 사용가능)
	5. drop : 데이터가 들어 있더라도 같이 삭제됨
		
		drop database DB명;
		drop table 테이블명;
		alter table 테이블명 drop 컬럼명;

*/


#member 테이블에서 varchar(10)인 address 컬럼을 추가하시오.
alter table member add address varchar(10) not null;

#member 테이블에 아래의 데이터를 삽입후 조회하시오.
#'ID4','강남길',5555,'010-5555-1234','kang@naver.com',현재날짜
insert into member (memberid, name, pw, phone, address, email, regtime) values 
('ID4','강남길',5555,'010-5555-1234', '경기도 용인시', 'kang@naver.com',now());

#member 테이블에서 address 컬럼의 타입을 varchar(50)으로 변경하시오.
alter table member modify address varchar(50);

#member 테이블에 아래의 데이터를 삽입후 조회하시오.
#'ID5','홍길동',1234,'010-4655-1255','hong@naver.com',현재날짜, '서울시 강남구 역삼동'
insert into member (memberid, name, pw, phone, address, email, regtime) values 
('ID5','홍길동',1234,'010-4655-1255', '서울시 강남구 역삼동','hong@naver.com', now());



#member 테이블에서 address 컬럼의 이름과 타입의 길이를 addr varchar(100)으로 변경하시오.
alter table member change address addr varchar(100);
alter table member modify addr varchar(10); -- 에러발생(들어있는 데이터의 길이보다 짧게 설정되어서...)


#member 테이블에서 addr 컬럼을 삭제후 조회하시오.(만약 이미 데이터가 들어있는 경우 같이 삭제)
alter table member drop addr;


#member 테이블을 완전히 삭제후 테이블 목록을 조회하시오.
drop table member;
drop table if exists member; -- 권장


desc member;








