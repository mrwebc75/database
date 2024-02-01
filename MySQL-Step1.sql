-- 지금부터 empdb 데이터베이스를 사용하겠다.
use empdb; 

#테이블 목록을 조회하시오.
show tables;

#countries 테이블의 구조를 확인하시오.
desc countries;

#countries 테이블의 모든 컬럼을 조회하시오.
select * from countries;

#countries 테이블에서 나라이름만 조회하시오.
select country_name from countries;

#countries 테이블에서 나라이름, 지역아이디를 조회하시오.
select country_name, region_id from countries;

#employees 테이블에서 사번(employee_id), 이름(first_name), 성(last_name), 
#급여(salary), 직종코드(job_id) 정보를 조회하시오.
select employee_id, first_name, last_name, salary, job_id from employees;

#employees 테이블에서 employee_id,first_name,last_name,salary,job_id 정보를 조회하되 
#각 컬럼의 별명(alias)를 각각 "사원 번호, 이름, 성, 급여, 직종코드"로 설정하시오.
select employee_id as 사원번호, first_name as 이름, last_name as 성, salary as 급여, 
job_id as 직종코드 from employees;

select employee_id 사원번호, first_name 이름, last_name 성, salary 급여, 
job_id 직종코드 from employees;

#mysql에서는 쌍따옴표, 홑따옴표 모두 사용 가능하다.
select employee_id '사원번호', first_name '이름', last_name '성', salary "급여", 
job_id "직종코드" from employees;

#employees 테이블에서 각 사원의 연봉을 계산하여 출력하시오. 단, 연봉은 salary*12 로 계산한다.
select first_name, salary, salary*12 as 연봉 from employees;

#employees 테이블에서 각 사원의 last_name, first_name을 합쳐서 출력하시오.
#문자열을 연결하는 concat() 함수 사용
select last_name, first_name from employees;
select concat(last_name," ",first_name) as 성명 from employees;

#mysql에서는 사칙연산만 가능하다. 나머지 % 연산자는 없다. MOD(5,2)
select 3+4, 10-5, 3*3, 5/2, mod(5,2);

# employees 테이블에서 급여가 15000 이상인 사원의 사번, 급여, 이름을 조회하시오.
# @money 변수에 15000을 할당해서 활용하시오.
set @money = 15000; 
select employee_id, salary, first_name from employees
where salary >= @money;


#employees 테이블에서 15000<=급여<=20000 인 사원의 사번, 급여, 이름을 조회하시오.
#&& 연산자, and 키워드, between를 이용하여 3번 작성하시오)

# and는 &&, or는 || 으로 대체 사용 가능하지만 mysql에서는 and, or 권장

select employee_id, salary, first_name from employees
where salary >= @money && salary <= 20000;

select employee_id, salary, first_name from employees
where salary >= @money and salary <= 20000;

select employee_id, salary, first_name from employees
where salary between 15000 and 20000;

# mysql에서는 = 이 좌우값의 동등함을 나타낸다. 자바에서는 ==

#employees 테이블에서 사번이 100, 200, 300번인 사원의 사번, 급여, 이름을 조회하시오.
select employee_id, salary, first_name from employees 
where employee_id=100 || employee_id=200 || employee_id=300;

select employee_id, salary, first_name from employees
where employee_id=100 or employee_id=200 or employee_id=300;

select employee_id, salary, first_name from employees
where employee_id in (100,200,300);

#employees 테이블에서 이름이 'PET'로 시작하는 사원의 이름과 성을 조회하시오
select first_name as 이름, last_name as 성 from employees
where first_name like 'PET%';

#employees 테이블에서 사원 이름과 문자개수를 조회하시오
select first_name, concat(length(first_name),'자') as 문자개수 from employees;

#employees 테이블에서 이름이 'K'로 시작하고 문자갯수가 5개인 사원의 이름과 성을 조회하시오
select first_name as 이름, last_name as 성 from employees
where first_name like 'K____';

select first_name as 이름, last_name as 성 from employees
where first_name like 'K%' and length(first_name)=5;

#employees 테이블에서 성(last_name)이 'ng'로 끝나는 사원의 이름과 성을 조회하시오
select first_name as 이름, last_name as 성 from employees
where last_name like '%ng';

#employees 테이블에서 성(last_name)이 'er'를 포함하는 사원의 이름과 성을 조회하시오
select first_name as 이름, last_name as 성 from employees
where last_name like '%er%';


#employees 테이블에서 커미션(commission_pct) 컬럼을 조회하시오.
#조회결과 Null이 있을경우 0으로 취급되기 때문에 맨 먼저 나오게 됨
select commission_pct as c_pct from employees order by c_pct asc;


#employees 테이블에서 이름, 입사일을 조회하시오.
select first_name, hire_date from employees;


#mysql에서 날짜 출력형식 19자리     2003-06-17 00:00:00
#문자열, 날짜시간은 길이와 양식이 정해져 있기 때문에 따옴표('', "")로 묶어야 한다.

#employees 테이블에서 2006년 이후에 입사한 사원의 이름, 입사년도를 조회하시오.
select first_name, concat(year(hire_date),"년") from employees
where hire_date >= '2006-01-01 00:00:00'
order by hire_date asc;

select first_name, concat(year(hire_date),"년") from employees
where year(hire_date) >= 2006;


#employees 테이블에서 2006년에 입사한 사원의 이름, 입사일을 조회하시오.
#(부등호, like, between, year()를 이용하여 4번 작성하시오.)

#부등호 사용
select first_name, hire_date from employees
where hire_date>='2006-01-01 00:00:00' and hire_date<'2007-01-01 00:00:00';

#like
select first_name, hire_date from employees
where hire_date like '2006%';

select first_name, hire_date from employees
where hire_date between '2006-01-01 00:00:00' and '2006-12-31 23:59:59';

select first_name, hire_date from employees
where year(hire_date) = '2006';


#employees 테이블에서 년도에 상관없이  6월에 입사한 사원의 이름, 입사일을 조회하시오.
select first_name, hire_date from employees
where month(hire_date) = '06';

select first_name, hire_date from employees
where hire_date like '%-06-%';

select first_name, hire_date from employees
where hire_date like '_____06%';


# Null 처리 연산자 - is Null, is not Null

#employees 테이블에서 커미션(commission_pcst)을 못받는 사원을 조회하시오.
select first_name '커미션을 못받는 사원', commission_pct from employees
where commission_pct is Null;


#employees 테이블에서 커미션(commission_pcst)을 받는 사원을 조회하시오.
select first_name '커미션을 받는 사원', commission_pct from employees
where commission_pct is not null 
order by commission_pct desc;


#employees 테이블에서 사원별 직종코드(job_id)를 조회하시오.
select job_id as '직종코드' from employees;

#employees 테이블에서 직종종류만 조회하시오.
#단, 직종종류는 중복되지 않아야 한다.
select distinct job_id from employees order by job_id asc;

#employees 테이블에서 "성은 ㅇㅇㅇ이고, 이름은 ㅇㅇㅇ 입니다." 형식으로 조회하시오.
select concat("성은 ",last_name,"이고, 이름은 ",first_name," 입니다.") from employees;

#employees 테이블의 사번, 이름을 사번순서로 오름차순, 내림차순 정렬해 조회하시오.
select employee_id, first_name from employees e order by employee_id asc; 
select employee_id, first_name from employees e order by employee_id desc; 

select employee_id, first_name from employees e order by 1 desc;#정렬시 컬럼의 인덱스는 1부터 카운팅한다. 
select employee_id as '사번', first_name from employees e order by 사번 desc; 

#employees 테이블에서 급여를 많이 받는 사원부터 출력되도록 쿼리를 작성하시오.
#(단, 동일급여일 경우 이름의 알파벳 순으로 출력)
select first_name, salary from employees
order by salary desc, first_name asc;

select first_name, salary from employees
order by 2 desc, 1 asc;


#employees 테이블에서 커미션을 받는 사원중 그 값이 작은 사원부터 이름, 커미션이 출력되도록 조회하시오.
select first_name, commission_pct from employees
where commission_pct is not null 
order by commission_pct asc;


#특정 인덱스부터 원하는 개수만큼 데이터를 추출하는 limit 구문사용법
#select * from employees e limit offset, 가져올개수;

#employees 테이블에서 사번과 이름을 사번(employee_id)의 역순으로 조회후 처음부터 10개의 레코드만을 출력하시오
select employee_id, first_name from employees
order by 1 desc;
limit 0, 10

set @page = 1;
set @offSet = (@page-1)*10;

prepare myQuery
from "select employee_id, first_name from employees order by 1 desc limit ?,10";

execute myQuery using @offset;


#현재 시간을 보여주는 함수 now()
select now() from dual;
select now(); #MySQL에 내장된 가상의 dual 테이블을 자동 사용함(생략가능)
select sysdate() from dual; 
select current_timestamp() from dual;


#employees 테이블에서 매월 전체사원 급여의 합을 조회하시오 - sum()
select sum(salary) from employees where salary is not null;


#employees 테이블에서 전체사원의 수를 조회하시오. - count()
select count(salary) from employees;#107명 - not null인 값만 카운팅
select count(*) from employees; -- null값도 카운팅

#employees 테이블에서 매월 전체사원 급여의 평균을 조회하시오 - avg()
select sum(salary)/count(salary) as '평균급여' from employees;
select avg(salary) from employees;

#employees 테이블에서 최대 급여를 조회하시오
select max(salary) from employees;

#employees 테이블에서 급여가 10000 미만인 사원중 최대 급여을 조회하시오
select max(salary) from employees where salary < 10000;

#employees 테이블에서 최소 급여을 조회하시오
select min(salary) from employees;


#employees 테이블에서 최대급여, 최소급여, 급여총액, 급여평균, 전체사원수를 한꺼번에 조회하시오.
select max(salary), min(salary), sum(salary), avg(salary), count(salary) from employees;

#min(), max()는 모든 타입에 사용가능하다. 문자열도....
#sum(), avg() 사용시 오라클은 에러가 발생하지만 mysql은 0으로 유연하게 처리한다.
select max(first_name), min(first_name), sum(first_name) from employees;


#employees 테이블에서 가장 최근에 입사한 사원과 최초 입사한 사원의 입사일을 조회하시오.
select date(max(hire_date)) as '가장 최근 입사일', date(min(hire_date)) as '최초 입사일' from employees;


#employees 테이블에서 아직 부서(department_id)를 배정받지 못한 사원의 모든 정보를 조회하시오.
select * from employees where department_id is null;


#employees 테이블에서 50번 부서의 급여총합을 조회하시오.
select sum(salary) from employees where department_id = 50;

#group by를 사용하여 50번 부서의 급여총합을 조회하시오.
select department_id as dept_id, sum(salary) from employees group by dept_id having dept_id=50;

#employees 테이블에서 부서별로 급여의 총합을 내림차순으로 조회하시오.
select department_id as dept_id, sum(salary) 
from employees
where department_id is not null
group by dept_id
order by 2 desc;

select department_id as dept_id, sum(salary) 
from employees
group by dept_id
having dept_id is not null
order by 2 desc;


#employees 테이블에서 부서별, 직종코드별로 급여의 총합을 내림차순으로 조회하시오.
#단, 부서별 총합이 50000 이상이어야 한다.
select department_id as '부서별', job_id as '직종코드', sum(salary) as '부서별총합' from employees
where department_id is not null
group by department_id, job_id
having sum(salary)>=50000
order by 3 desc;

 


/*
	SQL(Structured Query Language) 실행순서
		1. from 테이블에서 모든 데이터를 가져온다.
		2. where 실행 (개수가 줄어든다.)
		3. group by
		4. having - 그룹 또는 그룹함수에 대한 조건
		5. select 컬럼명, 함수실행
		6. order by 정렬
		7. limit - 리턴할 개수
		
	
	그룹함수 사용시 주의할 점
		1. 그룹함수는 select 절에서 일반컬럼과 함께 사용할 수 없다.
		2. 왜냐하면 조회결과 레코드의 개수가 다르기 때문이다.
		3. 단, group by에서 사용한 컬럼은 가능하다.
	
	
	
	MySQL에서 제공하는 유용한 함수
	
	현재 시간을 보여주는 함수 
		now(), sysdate(), current_timestamp()
	
	통계함수
		sum(), avg() - 숫자타입만 사용가능 int, decimal(10,2), double
		
		min(), max() - 모든 타입에 적용가능
		
		count(컬럼)	- 주어진 컬럼에서 not null인 값의 개수
					  만약 null 값도 같이 개수를 세고 싶다면 count(*) 사용
	
	문자열
		concat(str1, str2) 	- 문자열 연결
		length(str1) 		- 문자열 길이

	날짜관련
		year(날짜데이터)		- 년도추출
		month(날짜데이터)		- 월추출
		day(날짜데이터)			- 일추출
		
		date(날짜데이터)		- 년월일
*/







