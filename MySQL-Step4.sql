#empdb 데이터베이스를 사용하시오.
use empdb;

# Winston 사원이 근무중인 부서명을 알고싶다. - Shipping
select * from employees where first_name = 'Winston'; -- department_id=50
select * from departments where department_id = 50; -- Shipping

/*
 	Inner Join
 		1. 조인에 참여하는 모든 테이블에 공통적으로 존재하는 데이터를 이용해서 조회
 		2. 범위를 만족하는 데이터만 조회
*/

#두개의 employees, departments 테이블을 department_id 컬럼으로 join 하여 이름, 부서id, 부서명을 조회하시오.
#방법1
select first_name, d.department_id, department_name  
from employees e inner join departments d on e.department_id = d.department_id
where first_name = 'Winston';


#방법2 - inner 키워드 생략
select first_name, d.department_id, department_name  
from employees e join departments d on e.department_id = d.department_id
where first_name = 'Winston';


#방법3 - join까지 지우고 콤마(,)로 조인에 참여한 테이블을 구분하며, 조인에 대한 조건을 where절에 작성한다.
select first_name, d.department_id, department_name  
from employees e, departments d 
where e.department_id = d.department_id and first_name = 'Winston';


#두개의 employees, departments 테이블을 department_id 컬럼으로 join 하여 급여가 5000 이상인 사원의 정보를 조회하시오.
select first_name, D.department_id, department_name
from employees E join departments D
on E.department_id = D.department_id
where salary>=5000;






