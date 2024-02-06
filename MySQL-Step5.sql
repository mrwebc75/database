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











