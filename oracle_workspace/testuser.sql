-- departments 테이블 생성
CREATE TABLE departments (
    department_id NUMBER PRIMARY KEY,
    department_name VARCHAR2(50) NOT NULL,
    manager_id NUMBER,
    location_id NUMBER
);

-- employees 테이블 생성
CREATE TABLE employees (
    employee_id NUMBER PRIMARY KEY,
    first_name VARCHAR2(50),
    last_name VARCHAR2(50) NOT NULL,
    email VARCHAR2(100) UNIQUE NOT NULL,
    phone_number VARCHAR2(20),
    hire_date DATE DEFAULT SYSDATE,
    job_id VARCHAR2(10) NOT NULL,
    salary NUMBER(8, 2),
    commission_pct NUMBER(5, 2),
    manager_id NUMBER,
    department_id NUMBER,
    CONSTRAINT fk_department
        FOREIGN KEY (department_id)
        REFERENCES departments(department_id),
    CONSTRAINT fk_manager
        FOREIGN KEY (manager_id)
        REFERENCES employees(employee_id)
);

-- jobs 테이블 생성
CREATE TABLE jobs (
    job_id VARCHAR2(10) PRIMARY KEY,
    job_title VARCHAR2(35) NOT NULL,
    min_salary NUMBER(8, 2),
    max_salary NUMBER(8, 2)
);

-- locations 테이블 생성
CREATE TABLE locations (
    location_id NUMBER PRIMARY KEY,
    street_address VARCHAR2(100),
    postal_code VARCHAR2(20),
    city VARCHAR2(50),
    state_province VARCHAR2(50),
    country_id VARCHAR2(2)
);

-- countries 테이블 생성
CREATE TABLE countries (
    country_id VARCHAR2(2) PRIMARY KEY,
    country_name VARCHAR2(40) NOT NULL,
    region_id NUMBER
);

-- departments 테이블 데이터 삽입
INSERT INTO departments (department_id, department_name, manager_id, location_id)
VALUES (10, 'Administration', 200, 1700);

INSERT INTO departments (department_id, department_name, manager_id, location_id)
VALUES (20, 'Marketing', 201, 1800);

INSERT INTO departments (department_id, department_name, manager_id, location_id)
VALUES (30, 'Purchasing', 202, 1700);

INSERT INTO departments (department_id, department_name, manager_id, location_id)
VALUES (40, 'Human Resources', 203, 2400);

-- employees 테이블 데이터 삽입
INSERT INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
VALUES (100, 'John', 'Doe', 'jdoe@example.com', '123-456-7890', SYSDATE, 'IT_PROG', 6000, 0.1, NULL, 10);

INSERT INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
VALUES (101, 'Jane', 'Smith', 'jsmith@example.com', '123-456-7891', SYSDATE, 'HR_REP', 4500, NULL, 100, 40);

INSERT INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
VALUES (102, 'Alice', 'Johnson', 'ajohnson@example.com', '123-456-7892', SYSDATE, 'IT_PROG', 5500, 0.05, 100, 10);

INSERT INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
VALUES (103, 'Bob', 'Williams', 'bwilliams@example.com', '123-456-7893', SYSDATE, 'HR_REP', 4800, NULL, 101, 40);

INSERT INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
VALUES (104, 'Charlie', 'Brown', 'cbrown@example.com', '123-456-7894', SYSDATE, 'IT_PROG', 6200, 0.08, 100, 10);

INSERT INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
VALUES (105, 'David', 'Lee', 'dlee@example.com', '123-456-7895', SYSDATE, 'HR_REP', 4700, NULL, 101, 40);

INSERT INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
VALUES (106, 'Eve', 'Taylor', 'etaylor@example.com', '123-456-7896', SYSDATE, 'IT_PROG', 5900, 0.07, 100, 10);

INSERT INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
VALUES (107, 'Frank', 'Davis', 'fdavis@example.com', '123-456-7897', TO_DATE('2020-05-01', 'YYYY-MM-DD'), 'IT_PROG', 5500, 0.06, 100, 10);

INSERT INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
VALUES (108, 'Grace', 'Martinez', 'gmartinez@example.com', '123-456-7898', TO_DATE('2021-03-15', 'YYYY-MM-DD'), 'HR_REP', 4700, NULL, 101, 40);

INSERT INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
VALUES (109, 'Henry', 'Miller', 'hmiller@example.com', '123-456-7899', TO_DATE('2022-08-20', 'YYYY-MM-DD'), 'IT_PROG', 5800, 0.05, 100, 10);

INSERT INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
VALUES (110, 'Ivy', 'Garcia', 'igarcia@example.com', '123-456-7900', TO_DATE('2019-11-10', 'YYYY-MM-DD'), 'HR_REP', 5000, NULL, 101, 40);

INSERT INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
VALUES (111, 'Jack', 'Rodriguez', 'jrodriguez@example.com', '123-456-7901', TO_DATE('2023-01-25', 'YYYY-MM-DD'), 'IT_PROG', 6200, 0.07, 100, 10);

INSERT INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
VALUES (112, 'Kathy', 'Wilson', 'kwilson@example.com', '123-456-7902', TO_DATE('2024-06-05', 'YYYY-MM-DD'), 'HR_REP', 4900, NULL, 101, 40);

INSERT INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
VALUES (113, 'Leo', 'Lopez', 'llopez@example.com', '123-456-7903', TO_DATE('2018-09-30', 'YYYY-MM-DD'), 'IT_PROG', 6000, 0.09, 100, 10);

INSERT INTO jobs (job_id, job_title, min_salary, max_salary)
VALUES ('IT_PROG', 'IT Programmer', 5000, 9000);

INSERT INTO jobs (job_id, job_title, min_salary, max_salary)
VALUES ('HR_REP', 'Human Resources Representative', 3000, 5000);

-- locations 테이블 데이터 삽입
INSERT INTO locations (location_id, street_address, postal_code, city, state_province, country_id)
VALUES (1700, '123 Main St', '12345', 'New York', 'NY', 'US');

INSERT INTO locations (location_id, street_address, postal_code, city, state_province, country_id)
VALUES (1800, '456 Market St', '67890', 'San Francisco', 'CA', 'US');

-- countries 테이블 데이터 삽입
INSERT INTO countries (country_id, country_name, region_id)
VALUES ('US', 'United States', 1);

INSERT INTO countries (country_id, country_name, region_id)
VALUES ('IN', 'India', 2);

commit;

--1. 직원수는 모두 몇명인가?

--2. 직원 id, firstname, lastname, 부서명을 출력하시오.

--3. 부서(부서명)별 직원수를 구하시오.

--4. jobtitle별 직원수를 구하시오

--5. 부서(부서명)별 최대급여(반올림)를 구하시오.

--6. 전체직원 평균급여보다 적은 급여를 받는 직원의 firstname,lastname과 급여를 구하시오. subquery사용

--7. 직원의 fullname (firstname+lastname)과 각 직원의 매니져명(firstname+lastname)을 구하시오.
--   매니져가 없는 직원 포함

--8. 평균급여가 낮은 부서부터 부서명, 평균급여(반올림적용)를 출력하시오

--9. 년도별로 입사한 직원수를 구하시오.
-- 출력예시 :   2025   7

--10. 직원명(firstname+lastname), 부서명, 직책(job)명을 구하시오. ANSI SQL