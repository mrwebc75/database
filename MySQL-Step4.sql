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


/*
	1. 기준테이블 left outer join 조인테이블
		1) left의 의미는 왼쪽테이블을 기준 테이블로 지정한다는 의미이다.
		2) 조인된 테이블에 데이터가 없어도 기준테이블의 데이터는 모두 출력된다.
		3) 조인된 테이블에 데이터가 없으면 null을 표시한다.
		4) outer 키워드를 생략하고 left join 으로 사용할 수 있다.	

	2. 조인테이블 right outer join 기준테이블
		1) right의 의미는 오른쪽 테이블을 기준 테이블로 지정한다는 의미이다.
		2) 조인된 테이블에 데이터가 없어도 기준테이블의 데이터는 모두 출력된다.
		3) 조인된 테이블에 데이터가 없으면 null을 표시한다.
		4) outer 키워드를 생략하고 right join 으로 사용할 수 있다.
*/


select count(*), count(employee_id) from employees;

# employees 테이블에 존재하는 107개의 모든 레코드에 대하여 departments 테이블과 left outer join하여 
# 사원이름, 부서이름, 부서코드를 조회하시오.
select E.first_name, D.department_name, D.department_id 
from employees E
inner join departments D on E.department_id = D.department_id;

select count(*) from departments;
# employees 테이블에 대하여 27개의 레코드를 가지고 있는 departments 테이블과 rigth outer join하여 
# 사원이름, 부서이름, 부서코드를 조회하시오.

select E.first_name, D.department_name, D.department_id 
from employees E 
right outer join departments D on E.department_id = D.department_id;

# 부서이름, 부서장이름을 조회하되 부서장이 없는 부서도 조회하시오.
select D.department_name '부서이름', ifnull(E.first_name,'부서장없음') '부서장명'
from departments D
left outer join employees E on D.manager_id = E.employee_id; 


select * from departments;
select * from employees;

# 사원명, 상사명을 조회하시오
select e1.first_name, e2.first_name
from employees e1
inner join employees e2 on e1.manager_id = e2.employee_id;


#사원의 입장에서 사원명, 사원급여, 상사명, 상사급여를 조회하되 사원의 급여가 상사보다 많은 경우에만 출력하시오.
select e1.first_name, e1.salary, e2.first_name, e2.salary
from employees e1
inner join employees e2 on e1.manager_id = e2.employee_id
where e1.salary > e2.salary;


#employees에서 사장을 포함하여 사원명, 사원급여, 상사명, 상사급여를 조회하시오.
#단, 사장은 상사가 없고, 급여도 없는 사람이다.
select e1.first_name, e1.salary, ifnull(e2.first_name,'사장'), ifnull(e2.salary, '보안')
from employees e1
left outer join employees e2 on e1.manager_id = e2.employee_id

# london 도시에 근무하는 사원명 부서명 도시명 조회하시오.
select first_name, department_name, city  from employees e
inner join departments d on e.department_id = d.department_id 
inner join locations L on L.location_id = d.location_id 
where L.city = 'London';


desc departments ;
desc locations ;






