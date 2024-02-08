use empdb;

#이름이 kelly 인 사원을 모든 정보를 조회하시오.
select * from employees where first_name = 'kelly';

#kelly와 같은 부서에 근무하는 부서원들의 이름, 부서코드를 조회하시오. 단, kelly는 제외하시오.
select  first_name, department_id from employees e 
where department_id = (select department_id from employees where first_name = 'kelly') and first_name != 'kelly';


select * from employees where first_name = 'peter';
#peter와 같은 부서에 근무하는 부서원들의 이름, 부서코드를 조회하시오. 단, peter는 여러명이다.
select first_name, department_id from employees
where department_id in (select department_id from employees where first_name='peter');


#kelly와 같은 부서이면서 직종코드가 같은 사원을 조회하시오. 단, kelly는 제외하시오.
#여러개의 컬럼을 비교할 때는 두개 이상의 컬럼을 같이 비교하는 PairWise 서브쿼리 구문으로 해결
select first_name '이름', department_id '부서코드', job_id '직종코드' from employees
where (department_id, job_id) = (select department_id, job_id from employees where first_name = 'kelly')
and first_name != 'kelly';


#kelly보다 급여가 더 높은 사원을 조회하시오.
select first_name, salary from employees
where salary > (select salary from employees where first_name='kelly')
order by 2;

/* select 문 내부에 들어가는 서브쿼리는 반드시 괄호를 기재한다.
 * 
 * 서브쿼리와 같이 사용하는 연산자
 * 	단일행 서브쿼리 : =, >, <
 *  다중행 서브쿼리 : in, =any, >=any, >any, =all, >=all, >all
 * 
 * 	any - 여러개 중 하나
 *  all - 모두
 * 
 * 
 */

#세사람의 peter중 아무나 보다 급여가 더 높은 사원을 조회하시오.
-- 세사람의 peter 급여중 최소값 보다 크면 OK 2500
select first_name, salary from employees
where salary >any (select salary from employees where first_name='peter')
order by salary desc;


#세사람의 peter 모두 보다 급여가 더 높은 사원을 조회하시오.
-- 세사람의 peter 급여중 최대값 보다 크면 OK  10000
select first_name, salary from employees
where salary >all (select salary from employees where first_name='peter')
order by salary asc;


#employees 테이블에서 사원의 급여와 평균급여를 함께 비교할 수 있도록 조회하시오.
-- 이때 서브쿼리는 결과로 반드시 한개의 행만 가져와야 한다.
select salary '사원급여', round((select avg(salary) from employees),0) '평균급여' from employees;


#kelly보다 급여를 더 많이 받는 사원의 이름, 급여 그리고 kelly급여를 함께 조회하시오.
-- 주의사항 : 결과행이 다중행일 경우 불가능함. 예를들어 peter는 여러명이기 때문에 불가능
select first_name, salary, (select salary  from employees e where first_name = 'kelly') '켈리급여' 
from employees
where salary > (select salary  from employees e where first_name = 'kelly');

#inline-view
#from 절 내부의 subquery를 사용하는 방법으로 
#employees 테이블에서 최대급여, 최소급여, 급여총액, 급여평균, null을 제외한 급여개수를 조회하시오.
-- 주의사항 : 모든 파생 테이블에는 고유한 별칭이 있어야 한다.
select max, min, sum, avg, cnt 
from (select max(salary) 'max', min(salary) 'min', sum(salary) 'sum', 
avg(salary) 'avg', count(salary) 'cnt' from employees) as salaryInfo;


#emp_copy 테이블에서 이름이 홍길동인 사원의 입사일을 jack의 입사일로 변경하시오.
#mysql에서 update, delete 구문의 경우 서브쿼리의 결과를 하나의 테이블로 취급하므로, 조회결과를 별칭을 사용해서 적용해야 한다.
update emp_copy 
set hire_date = (select * from (select hire_date from emp_copy where name = 'jack') as duly)
where name = '홍길동';


#emp_copy 테이블에서 '박사원'과 같은 부서원의 급여를 1000원 인상시키시오.
update emp_copy 
set salary = salary + 1000
where dept_id = (select * from (select dept_id from emp_copy where name = '박사원') as x);







