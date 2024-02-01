#empdb 데이터베이스를 사용하시오.
use empdb;

#현재 사용가능한 테이블 목록을 출력하시오.
show tables;

#employees 테이블의 연봉이 5000 이상인 사원들의 데이터를 복사하여 새로운 테이블 emp_copy를 생성하시오
#단, 컬럼명은 first_name=>name, employee_id=>id, salary, department_id=>dept_id, hire_date 로 변경하시오.
create table emp_copy (select * from employees); 
create table emp_copy (select * from employees where salary>=5000); 

create table emp_copy (select 
first_name name, employee_id id, salary, department_id dept_id, hire_date 
from employees where salary>=5000); 

#emp_copy 테이블의 구조를 확인하시오.
desc emp_copy;

#만약 emp_copy 테이블이 존재한다면 삭제하시오.
drop table emp_copy;
drop table if exists emp_copy;

#emp_copy 테이블의 데이터 개수를 출력하시오.
select count(*) from emp_copy; -- 58개


select * from emp_copy 

/*
	Step2에서 학습할 문법구문
	
	insert into 테이블명 (컬럼명1, 컬럼명2, ...) values (값1, 값2, ...);
	
	update 테이블명 set 컬럼명1=값1, 컬럼명2=값2 where 조건식;
	
	delete from 테이블명 where 조건식;
*/

#emp_copy 테이블에 다음의 데이터를 insert문으로 삽입하시오.
#'홍길동' 100 5000 10 '2023-03-28 00:00:00'
insert into emp_copy (name, id, salary, dept_id, hire_date) 
values ('홍길동', 100, 5000, 10, '2023-03-28 00:00:00');

#emp_copy 테이블에 다음의 데이터를 컬럼리스트를 생략한 insert문으로 삽입하시오.
#'박사원' 300 5000 10 '2023-03-28 00:00:00'
insert into emp_copy values ('박사원', 300, 5000, 10, '2023-03-28 00:00:00');

#아래의 데이터를 emp_copy 테이블에 삽입하시오.
-- '김부장',303,20000,50,'2023-03-28 00:00:00'
-- '김차장',304,19000,50,'2023-03-28 00:00:00'
-- '김이사',305,30000,50,'2023-03-28 00:00:00'
-- '김신입',306,10000,50,'2023-03-28 00:00:00'

insert into emp_copy (name, id, salary, dept_id, hire_date) values
('김부장',303,20000,50,'2023-03-28 00:00:00'),
('김차장',304,19000,50,'2023-03-28 00:00:00'),
('김이사',305,30000,50,'2023-03-28 00:00:00'),
('김신입',306,10000,50,'2023-03-28 00:00:00');

select * from emp_copy where year(hire_date)=2023;

# 2023-03-28 00:00:00 에 입사한 50번 부서 사원들을 삭제하시오.
delete from emp_copy where hire_date = '2023-03-28 00:00:00' and dept_id=50;


#아래의 데이터를 사용하여 insert시 잘못된 컬럼은 초기화된 값이 들어가고,
#나머지 컬럼은 그대로 데이터를 삽입하게 하는 ignore 키워드 
insert ignore into emp_copy values
('박부장',307,20000,70,'2024'),
('최부장',308,20000,70,now());

select * from emp_copy where dept_id=70;

# product 테이블 생성 구문을 작성하시오.
# 컬럼 : (code 정수 null허용X/주키설정/자동증가, name 가변문자열50, price 10자리중 소수점2자리 실수)
create table product(

	#auto_increment 설정시 1부터 순차적으로 값이 자동 할당됨
	code int not null primary key auto_increment,
	name varchar(50),
	price decimal(10,2)
	
) default character set utf8;

show tables;
desc product;


#product 테이블에 컬럼리스트를 명시하여 세개의 상품데이터를 삽입후 조회하시오.
#세개의 상품 (두드림컴퓨터/100000, 캠프모니터/100000, 자바마우스/10000) 

insert into product (name, price) values
('두드림컴퓨터', 100000),
('캠프모니터', 100000),
('자바마우스', 10000);

#product 테이블에 컬럼리스트를 생략하여 세개의 상품데이터를 삽입후 조회하시오.
#세개의 상품 (두드림컴퓨터2/100000, 캠프모니터2/100000, 자바마우스2/10000)

#컬럼명을 생략할 경우 해당위치에 null 또는 default로 값을 넣어주면 auto_increment의 경우 자동으로 증가값이 삽입된다.
insert into product values
(null,'두드림컴퓨터2',100000),
(default,'캠프모니터2', 100000),
(default,'자바마우스2', 10000);

select * from product;

select * from emp_copy where name='홍길동';

desc emp_copy;
#emp_copy 테이블에서 이름이 홍길동인 사원의 사번(id)을 310으로 변경하시오.
update emp_copy set id=310 where name='홍길동';

#emp_copy 테이블에서 이름이 홍길동인 사원의 급여를 1000원 올려주고, 100번 부서(dept_id)로 이동하시오.
update emp_copy set salary=salary+1000 ,dept_id=100 where name='홍길동'; 


#emp_copy 테이블에서 id가 310인 사원의 데이터를 영구 삭제하시오.
delete from emp_copy where id=310;


# 오토컷밋 값이 1이면 insert,update,delete 작업의 결과를 즉각적으로 DB에 반영하겠다는 의미
select @@autocommit;

# 오토컷밋 값이 0이면 자동으로 반영되지 않고 잠시대기 후 사용자가 commit하면 반영, rollback하면 작업취소됨
set autocommit = false;
set autocommit = true;

#emp_copy 테이블에서 id가 307인 사원의 데이터를 트랜잭선 처리후 삭제했다가 다시 복구하시오.
start transaction;
delete from emp_copy where id=307;
rollback;

#emp_copy 테이블에서 id가 307인 사원의 데이터를 트랜잭선 처리후 삭제한다음 영구히 반영하시오.
start transaction;
delete from emp_copy where id=307;
commit;

select * from emp_copy where id=307;













