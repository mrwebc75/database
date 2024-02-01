#empdb 데이터베이스를 사용하시오.
use empdb;

/*
	MySQL이 제공하는 데이터 형식
	
	1. 정수 - smallint(자바의 short), int, bigint, decemal(10,0)
	2. 실수 - float, double, decemal(10,2)
	3. 문자열 - char(개수), varchar(최대허용개수), text(길이제한없음, 허용하는 최대크기만큼)
	4. 날짜 - date 날짜만, time 시간만, datetime 날짜시간모두  <- 대소비교 가능
	5. boolean 타입 없음 -> 0, 1로 표현
*/

# 자동형변환
	select '100' + '200' from dual; -- 300
	select '100' + 200 ; -- 300    from dual은 생략가능
	select concat('100', '200'); -- 100200
	select concat(100, 200); -- 100200
	select '100' + 200 + '300abc'; -- 600
	
	select 100>0; -- 1
	select 1>'300abc'; -- 0
	
# 문자열 길이
	select char_length('mysql') from dual; -- 5  글자수를 카운팅
	select char_length('마이에스큐엘'); -- 6  
	
	select length('mysql'); -- 5 바이트수를 카운팅 , 영어는 1글자가 1바이트
	select length('마이에스큐엘'); -- 18  한글은 1글자가 3바이트
	
	select bit_length('mysql'); -- 40비트
	select bit_length('마이에스큐엘'); -- 144비트
	
# 문자열 결합
	select concat('둘리','또치','도우너','마이콜');
	select concat_ws('/','둘리','또치','도우너','마이콜'); -- word separator 구분자를 이용해서 문자연결

# 문자찾기
	elt(idx, '문자열1', '문자열2', '문자열3', ....)
		-- Extract(추출), Load(로드), Transform(변환)
		-- 지정된 idx에 해당하는 문자열을 반환하는 함수

	field('둘리',   '또치', '도우너', '둘리', ....)
		-- 찾는 문자열 '둘리'와 일치하는 항목이 있으면 몇번째인지 값을 리턴하고, 없으면 0을 리턴
	
	# 검색할 문자열의 시작위치를 찾아내는 함수 3종세트 - 찾고자 결과가 없으면 0을 리턴	
	
	find_in_set(찾는문자열, 쉼표로 구분된 검색대상 문자열)
	select find_in_set("둘리", "또치,도우너,마이콜,둘리,영희") as '둘리의 인덱스'; -- 4
	
	locate(찾는문자열, 검색대상문자열)
	select locate('둘리','아기공룡둘리와 친구들'); -- 5
	
	instr(검색대상문자열, 찾는문자열)
	select instr('아기공룡둘리와 친구들','공룡'); -- 3

	
	substring(검색대상문자열, 시작idx, 가져올개수길이)
		-- 자바에서는 str.substring(시작idx, 끝idx)
		-- 길이를 미입력하면 끝까지 추출
	select substring("동해물과 백두산이 마르도 닳도록", 6, 3); -- 백두산 
	select substring("동해물과 백두산이 마르도 닳도록", 6); -- 백두산이 마르도 닳도록 
	
	insert(원본문자열, 시작인덱스, 삭제할개수, 추가할문자열)
		select insert("아기공룡둘리", 3, 2, "");
		select insert("아기공룡둘리", 3, 2, "사랑");
	
	replace(원본문자열, old문자열, new문자열);
		select replace("이것이 자바다~! 자바다~!", "자바", "JAVA");
	
	repeat(문자열, 출력횟수)
		select repeat('*', 10);
	
	left(원본문자열,개수) -- 왼쪽에서부터 3글자만 출력
		select left(first_name,3) from employees; 
		
	right(원본문자열,개수)
		select right("아기공룡둘리", 2); -- 둘리
	
	upper(대문자로 변환)
		select upper("i am a boy~!");
	
	lower(소문자로 변환)
		select lower("YOU ARE A GIRL~!");
	
	-- lpad(), rpad()는 왼쪽이나 오른쪽의 정렬효과를 주기 위해 사용
	-- 자리수가 남으면 채워주는 함수
	
	lpad(출력대상, 전체자리수, 남는자리를 대체할 문자)
		select lpad(salary, 10, '*') from emp_copy;	
	
	rpad(출력대상, 전체자리수, 남는자리를 대체할 문자)
		select rpad(salary, 15, '*') from emp_copy;
	
	
# 숫자함수
	
	실수를 정수로 만드는 함수 : truncate(), round()
	
	truncate(1234.5678, 0) - Math.floor()와 비슷한 기능
		-- 지정한 소수점자리 까지만 출력, 반올림 안함(버림, 내림)
		-- 출력결과 무의미한 소수점값들을 없애버릴때 자주 사용
		-- 실수를 정수로 표현
		select truncate(123456789.987, 1)  from dual; -- 123456789.9
	
	round(1234.5678, 0) -- 반올림
		-- 실수를 정수로 표현
		select round(3456.789, 0); -- 3457
		select round(3456.789, 1); -- 3456.8
	
	format(1234.5678, 0)
		-- 문자열로 변환하며, 변환시 반올림 처리한다.
		-- 출력시 1000단위 마다 콤마(,)를 찍어준다.
		select format(123456789.987, 1)  from dual; -- 123,456,790.0
	

#employees 테이블에서 2006년도에 입사한 사원이름과 입사일을 substring(), instr() 함수를 이용해서 각각 조회하시오.
select first_name, hire_date from employees where year(hire_date)=2006; 

select first_name, hire_date from employees where substring(hire_date,1,4)=2006; 

select first_name, hire_date from employees where instr(hire_date, '2006') = 1;

select first_name, hire_date from employees where substring(hire_date, instr(hire_date, '2006'), 4) 


set @pw = "abc123가나다";

#@pw 변수의 내용 전체를 '*'별표 처리하여 출력하시오.
select repeat('*', char_length(@pw));
select insert(@pw, 1, char_length(@pw), repeat('*', char_length(@pw)));
select replace(@pw, @pw, repeat('*', char_length(@pw)));

#@pw 변수의 내용중 앞에 두글자만 보여주고 나머지는 별표 처리하여 출력하시오.
select concat(left(@pw,2),repeat('*',char_length(@pw)-2));
select insert(@pw, 3, char_length(@pw)-2, repeat('*', char_length(@pw)-2)); 
select replace(@pw, substring(@pw,3), repeat('*', char_length(@pw)-2 ) );


#사용자정의 변수 var1에 50 을 값으로 할당후 조회하시오.
set @var1 = 50;
select @var1 from dual;

#emp_copy 테이블에서 @var1의 값과 같은 부서코드에 근무하는 사원을 조회하시오.
select * from emp_copy where dept_id = @var1;

/*
	if함수 3종세트
	
	1. ifnull(필드명,대체문자열)  -  만약 지정한 필드값이 null이면 대체문자열로 출력
	
	2. if(조건,a,b) -- 조건이 참이면 a, 거짓이면 b를 리턴 (삼항연산자와 비슷)
	
	3. nullif(값1,값2) - 두 값이 같으면 null 리턴, 다르면 앞의 값을 리턴

*/

#employees 테이블에서 부서번호가 없는 사원을 부서정보를 '부서미배정'으로 표시해서 출력하시오.
select first_name, ifnull(department_id,"부서미배정")  from employees where department_id is null;

select if(@var1>1, '1보다 크다', '1보다 크지 않다');
select first_name, if(salary>10000, '고액연봉자', '평균연봉') from employees;

-- 두값이 같으면 null, 다르면 앞의 값을 리턴
select nullif(100,100), nullif(100,200), nullif(200,100);


#employees 테이블에서 case~end 연산자를 사용하여 
#급여를 기준으로 '임원,부장,과장,대리,사원'으로 이름과 함께 직급을 출력하시오.
#2만이상 임원, 15000이상 부장, 1만이상 과장, 5천이상 대리, 그외는 사원
select first_name,
salary, 

(case
	when salary>=20000 then '임원'
	when salary>=15000 then '부장'
	when salary>=10000 then '과장'
	when salary>=5000 then '대리'
	else '사원'
end) as '직급'

from employees;


#employees 테이블에서 사원들의 이름과 연봉(본봉*12 + 커미션)을 조회하시오. 
#연산식에 들어가는 항목중의 하나라도 null이면, 전체 연산결과도 null 이다.
select first_name as '이름', 
(     salary*12+ifnull(salary*commission_pct,0)    ) as 연봉 
from employees order by 2 desc;


#emp_copy 테이블에서 name이 세글자로 이루어진 레코드를 조회하시오.
select * from emp_copy where char_length(name)=3; 


#실수 1234.5678을 소수점이 없는 정수 문자열로 만드시오. (단, 반올림 적용)
select format(1234.5678,0) from dual; -- 1,2345


#실수 1234.5678을 소수점 한자리를 가진 실수 문자열로 만드시오. (단, 반올림 적용)
select format(1234.5678,1) from dual;


#문자열 '가나다라마바사'에서 '나다라'를 삭제하고 그 자리에 'abcdefg'를 삽입하시오.
select replace('가나다라마바사','나다라','abcdefg');
select insert('가나다라마바사',2,3,'abcdefg');


#employees 테이블에서 사원의 급여를 15자리로 하여 출력하되 왼쪽의 빈 공백부분을 '-'으로 채워서 출력하시오.
select lpad(salary,15,'-') from employees;

#employees 테이블에서 사원의 급여를 15자리로 하여 출력하되 오른쪽의 빈 공백부분을 '*'으로 채워서 출력하시오.
select rpad(salary,15,'*') from employees;


#체육대회에서 사번이 홀수인 사람은 백팀, 짝수이면 청팀으로 나누려 한다. if() 함수를 이용하여 작성하시오.
select first_name, employee_id, if(mod(employee_id,2)=1,'백팀','청팀') from employees;


#체육대회에서 사번이 홀수인 사람은 백팀, 짝수이면 청팀으로 나누려 한다. case~end 연산자를 이용하여 작성하시오.
select first_name, employee_id, 

(case mod(employee_id,2)
	when 1 then	'백팀'
	when 0 then	'청팀'
end) as '팀구분'

from employees;


#좌우공백제거
set @sns = '       재밋어요~! 웃겨요~!         ';

#@sns 변수의 왼쪽 공백을 모두 제거후 문자의 개수를 출력하시오.
select char_length(@sns), char_length(ltrim(@sns)) ;  -- 28 -> 21

#@sns 변수의 오른쪽 공백을 모두 제거후 문자의 개수를 출력하시오.
select char_length(@sns), char_length(rtrim(@sns));   -- 28 -> 19

#@sns 변수의 좌우 공백을 모두 제거후 문자의 개수를 출력하시오.
select char_length(@sns), char_length(trim(@sns));   -- 28 -> 12 

#분석시 의미없는 좌우 데이터 잘라내기
set @sns = 'ㅋㅋㅋㅋ60계 ㅋㅋㅋ치킨 너무 맛나요~!ㅋㅋㅋㅋ'; #값 재할당시에도 set 키워드 사용


#@sns 변수의 내용중 왼쪽 'ㅋㅋㅋㅋ'를 trim() 함수를 사용하여 제거후 출력하시오.
select trim(leading 'ㅋ' from @sns); -- 왼쪽의 'ㅋ'를 모두 제거
select trim(trailing 'ㅋ' from @sns); -- 오른쪽의 'ㅋ'를 모두 제거
select trim(both 'ㅋ' from @sns); -- 양쪽의 'ㅋ'를 모두 제거

#@sns 변수의 내용중 모든 'ㅋ'를 제거후 출력하시오.
select replace(@sns,'ㅋ',''); 

#0<x<1 사이의 난수 출력
select rand();


#1~100까지의 난수를 출력하시오. -> (0~99)+1
select truncate(1+rand()*100, 0);


#employees 테이블에서 급여의 평균을 구하되 소수점 이하는 출력되지 않게 반올림하시오.
select round(avg(salary),0)as 급여평균  from employees;


#employees 테이블에서 급여의 평균을 구하되 소수점 이하는 버리시오.
select truncate(avg(salary),0) as 급여평균  from employees;


#날짜,시간

#년월일 시분초를 출력하는 세개의 함수를 이용하여 현재의 년월일 시분초를 조회하시오.
select now(), sysdate(), current_timestamp();


#년월일을 출력하는 두개의 함수를 이용하여 현재의 년월일을 조회하시오.
select curdate(), current_date();


#시분초를 출력하는 두개의 함수를 이용하여 현재의 시분초를 조회하시오.
select curtime(), current_time();


#현재시간 now()에서 년월일, 시분초를 각각 세분화 추출하여 출력하시오.
select now(), 
date(now()), year(now()), month(now()), day(now()),
time(now()), hour(now()), minute(now()), second(now());


#employees 테이블에서 2006년도에 입사한 사원이름과 입사일을 year() 함수를 이용해서 각각 조회하시오.
select first_name, date(hire_date) from employees where year(hire_date)='2006';

#employees 테이블에서 전체 사원중 6월 입사자의 이름과 입사일을 각각 조회하시오.
select first_name, date(hire_date) from employees where month(hire_date)='06';


#'20240130152950'를 날짜 형식의 문자열로 변환하시오.
select date_format('20240130152950','%Y-%m-%d %H:%i:%s') ;

#date_format() 하나로 년월일 시분초를 다 가져올 수 있다.
select date_format(now(),'%Y'), date_format(now(),'%m') 


select weekday(now());#월요일 0
select dayofweek(now());#일요일 1


#월요일을 0으로 하는 weekday()를 이용하여 요일을 구하시오
select 
case weekday(now())
	when 0 then '월요일'	
	when 1 then '화요일'
	when 2 then '수요일'
	when 3 then	'목요일'
	when 4 then	'금요일'
	when 5 then	'토요일'
	when 6 then	'일요일'
end as 오늘은;



#일요일을 1로 하는 dayofweek()를 이용하여 요일을 구하시오.
select elt(dayofweek(now()), "일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일") as '오늘은';


#오늘, 내일, 어제, 일주일전후, 한달전후, 1년전후 날짜를 출력하시오.
select current_date() '오늘',
	adddate(curdate(),interval 1 day) '내일', 
	subdate(curdate(),interval 1 day) '어제',
	
	adddate(curdate(),interval 7 day) '일주일후',
	subdate(curdate(),interval 7 day) '일주일전',
	
	adddate(curdate(),interval 1 month) '1개월후',
	subdate(curdate(),interval 1 month) '1개월전',
	
	adddate(curdate(),interval 1 year) '1년후',
	subdate(curdate(),interval 1 year) '1년전' ;
	
#현재시간, 1시간전후, 1분전후, 1초전후 시간을 출력하시오.	
select current_time(),
	adddate(curtime(), interval 1 hour) '1시간후',
	addtime(curtime(), "1:00:00") '1시간후',
	
	subdate(curtime(), interval 1 hour) '1시간전',
	subtime(curtime(), "1:00:00") '1시간전',
	 
	adddate(curtime(), interval 1 minute) '1분후',
	addtime(curtime(), "00:01:00") '1분후',
	
	subdate(curtime(), interval 1 minute) '1분전',
	subtime(curtime(), "00:01:00") '1분전',

	subdate(curtime(), interval 1 second) '1초후',
	subtime(curtime(), "00:00:01") '1초전';
	

#현재시간에서 2시간 후와 전의 시간을 출력하시오.
select curtime() '현재', 
adddate(curtime(), interval 2 hour) '2시간 후', 
subdate(curtime(), interval 2 hour) '2시간 전'; 

select curtime() '현재', 
addtime(curtime(), "2:00:00") '2시간 후', 
subtime(curtime(), "2:00:00") '2시간 전'; 


#오늘을 기준으로 2023-02-28부터 경과한 日수를 조회하시오 -> datediff(최근날짜, 과거날짜)
select curdate(), datediff(curdate(), '2023-11-28'); -- 65
select curdate(), datediff('2023-11-28', curdate()); # -65
select curdate(), abs(datediff('2023-11-28', curdate())); # 65

#오전 06시부터 현재까지 경과된 시간을 조회하시오.
select time(now()), timediff(time(now()),'06:00:00');

#두 날짜 202402~202311 사이의 경과된 개월수를 조회하시오.
select period_diff('202402','202311'); -- 3

#employees 테이블에서 각 사원들이 입사한지 얼마나 경과되었는지 조회하시오.

# 1. 입사경과일수
select first_name, date(hire_date) '입사일', datediff(curdate(),date(hire_date)) '입사경과일수' from employees;

# 2. 입사경과주수
select first_name, date(hire_date) '입사일', truncate(datediff(curdate(),date(hire_date))/7,0)  '입사경과주수' from employees;

# 3. 입사경과개월수
select first_name, date(hire_date) '입사일', period_diff(date_format(now(),'%Y%m') , date_format(hire_date,'%Y%m'))  '입사경과개월수' from employees;

# 4. 입사경과년수
select first_name, date(hire_date) '입사일', truncate(datediff(curdate(),date(hire_date))/365,0)  '입사경과년수' from employees;

#명시적 형변환 - cast(), convert()
#cast() 를 사용하여 123.5678을 반올림하여 정수로 변환하시오.
select cast(123.5678 as signed integer); -- 124

#convert() 를 사용하여 123.5678을 반올림하여 정수로 변환하시오.
select convert(123.5678, signed integer); -- 124

desc emp_copy;

select * from emp_copy;
update emp_copy set dept_id = null where name="최부장";

#emp_copy 테이블의 모든 데이터를 json 문자열로 출력하시오.
select json_object('name',name, 'id',id, 'salary',salary, 'dept_id',ifnull(dept_id,'부서미배정'), 'hire_date',hire_date) as JSON타입 from emp_copy;







