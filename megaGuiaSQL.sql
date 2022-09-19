SELECT * FROM employees;
SELECT * FROM job_history;
--UNO
SELECT 
    job_id,
    job_title,
    min_salary,
    max_salary
FROM jobs
WHERE min_salary > 10000
ORDER BY min_salary ASC;
--DOS
SELECT 
    first_name,
    hire_date
FROM employees
WHERE hire_date BETWEEN TO_DATE ('2002/01/01', 'yyyy/mm/dd')AND
    TO_DATE ('2005/12/30', 'yyyy/mm/dd')
ORDER BY hire_date ASC;
--TRES
SELECT
    first_name,
    hire_date
FROM employees
WHERE job_id='SA_MAN' OR job_id='IT_PROG'; --los id se sacaron de la tabla jobs
--CUATRO
SELECT
    employee_id,
    first_name,
    last_name,
    email,
    phone_number,
    hire_date,
    job_id,
    salary,
    commission_pct,
    manager_id,
    department_id
FROM employees
WHERE hire_date>= TO_DATE ('2008/01/01', 'yyyy/mm/dd');
--CINCO
SELECT
    employee_id,
    first_name,
    last_name,
    email,
    phone_number,
    hire_date,
    job_id,
    salary,
    commission_pct,
    manager_id,
    department_id
FROM employees
WHERE employee_id=150 OR employee_id=160;
--SEIS
SELECT
    first_name,
    salary,
    commission_pct,
    hire_date
FROM employees
WHERE salary < 10000;
--SIETE
SELECT 
    job_title,
    max_salary - min_salary AS "Diferencia"
FROM jobs
WHERE max_salary - min_salary BETWEEN 10000 AND 20000;
--OCHO
SELECT
    first_name,
    salary,
    ROUND(salary, -3) AS Redondeo
FROM employees;
--NUEVE
SELECT
    job_id,
    job_title,
    min_salary,
    max_salary
FROM jobs
ORDER BY job_title ASC;
--DIEZ
SELECT
    first_name,
    last_name
FROM employees
WHERE first_name LIKE 'S%' OR last_name LIKE 'S%';
--ONCE
SELECT
    employee_id,
    first_name,
    last_name,
    email,
    phone_number,
    hire_date,
    job_id,
    salary,
    commission_pct,
    manager_id,
    department_id
FROM employees
WHERE EXTRACT(MONTH from hire_date) = 5
ORDER BY hire_date ASC;
--OPCION 2
SELECT * FROM EMPLOYEES WHERE TO_CHAR(HIRE_DATE, 'MON')= 'MAY' ORDER BY hire_date ASC;
--DOCE
SELECT
    employee_id,
    first_name,
    last_name,
    email,
    phone_number,
    hire_date,
    job_id,
    salary,
    commission_pct,
    manager_id,
    department_id
FROM employees
WHERE commission_pct IS NULL AND salary BETWEEN 5000 and 10000 and department_id = 50;
--TRECE 
SELECT 
    first_name,
    hire_date,
    ADD_MONTHS(TRUNC(hire_date, 'MM'),1) AS "Primer Pago"
FROM employees;
--CATORCE "Anhos Trabajados"
SELECT 
    first_name,
    hire_date,
    ROUND(MONTHS_BETWEEN(SYSDATE,hire_date)/12) AS "Años Trabajados"
FROM employees;
--Quince "Contratos del anho 2002"
SELECT first_name,
    hire_date
FROM employees
WHERE EXTRACT(YEAR FROM hire_date) = 2002;
--DIECISEIS "Solo la Primera Palabra del Trabajo"
SELECT job_title,
   NVL(SUBSTR(job_title,0,INSTR(job_title,' ')-1),job_title)
   --OTRA OPCION
   --COALESCE(SUBSTR(job_title,1,INSTR(job_title,' ')),job_title)
FROM jobs;
--DIECISIETE
SELECT first_name,
    last_name
FROM employees
WHERE INSTR(last_name,'b')=3;
--DIECIOCHO
SELECT UPPER(first_name),
    LOWER(email)
FROM employees;
--DIECINUEVE
SELECT employee_id,
    first_name,
    last_name,
    email,
    phone_number,
    hire_date,
    job_id,
    salary,
    commission_pct,
    manager_id,
    department_id
FROM employees
WHERE EXTRACT(YEAR from hire_date) = 2005;
--VEINTE DIAS TRABAJADOS
SELECT TO_DATE(SYSDATE)-TO_DATE('01/01/2011', 'DD/MM/YYYY') AS "Dias"
FROM employees
WHERE ROWNUM =1;
--VEINTIUNO
SELECT hire_date
FROM employees
WHERE EXTRACT(YEAR FROM hire_date)=2005
GROUP BY EXTRACT(MONTH FROM hire_date)
