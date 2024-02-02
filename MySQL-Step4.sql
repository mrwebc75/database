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

#두개의 employees, departments 테이블을 manager_id 컬럼으로 join 하여 
#부서이름(D), 부서코드(D,E), 부서장사번(D,E), 부서장이름(E) 정보를 조회하시오.
select D.department_name '부서이름', E.department_id '부서코드', E.manager_id '부서장사번', E.first_name '부서장이름' 
from employees E inner join departments D
on E.manager_id = D.manager_id;


#두개의 departments, locations 테이블을 location_id 컬럼으로 join 하여 
#부서이름, departments의도시코드, locations의도시코드, 도시이름 정보를 조회하시오.
select D.department_name '부서이름', D.location_id, L.city 
from departments D inner join locations L
on D.location_id = L.location_id;


#emp_copy 테이블에서 id가 300, 303, 308인 사원에 대한 정보를 조회하시오.
select * from emp_copy where id=300 or id=303 or id=308;
select * from emp_copy where id in (300,303,308);

#두개의 employees, departments 테이블을 department_id 컬럼으로 join 하여 
#사원이름, 부서이름, 부서코드를 조회하되 부서코드가 50, 80, 100인 부서만 해당하는 정보를 조회하여 부서명으로 정렬하시오.
select E.first_name '사원이름', D.department_name '부서이름', D.department_id '부서코드' 
from employees E inner join departments D
on E.department_id = D.department_id
where D.department_id in (50, 80, 100)
order by 2 asc;

#두개의 employees, departments 테이블을 department_id 컬럼으로 join 하여 
#평균급여가 1만이상인 부서의 부서이름, 부서코드, 부서이름별_평균급여를 조회하여 평균급여가 큰 순으로 정렬하시오.
#단, 평균급여가 10000 이상이어야 한다.
select D.department_name '부서이름', D.department_id '부서코드', truncate(avg(salary),0) '부서이름별_평균급여'
from employees E inner join departments D
on E.department_id = D.department_id
group by D.department_id 
having avg(salary)>=10000
order by 3 desc;

show tables;

desc employees;
desc departments;
desc locations;
desc countries;

#사원이름, 부서이름, 도시이름, 나라이름을 조회하시오.
select E.first_name, D.department_name, L.city, C.country_name
from employees E 
inner join departments D on E.department_id = D.department_id 
inner join locations L on L.location_id = D.location_id 
inner join countries C on C.country_id = L.country_id;







