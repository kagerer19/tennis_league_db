/* COMPETENCE CHECK */
/*INSERTS*/

/* 1) The management would like a list of the different salaries per job. The output should contain the job_id as well as the sum of the salaries per job_id. In addition, the output should be sorted in descending order according to the sum of the salaries. */
SELECT E.JOB_ID,
       SUM(E.SAL + NVL(E.COMM_POT, 0)) AS TOTAL_SALARY
FROM EMPLOYEES E
         JOIN JOBS J ON E.JOB_ID = J.JOB_ID
GROUP BY E.JOB_ID
ORDER BY TOTAL_SALARY DESC;


/* 2) The personnel department wants to have information about the average salary of the employees at the current time. */
SELECT ROUND(AVG(SAL)) AS AVERAGE_SAL
FROM EMPLOYEES;


/* 3) The personnel department would like a list of all employees (first name, last name), on which the department name (department_name) is also displayed. */

/* INSERT A LEFT JOIN TO SHOW ALL EMPLOYEES INCLUDING THOSE THAT DO NOT BELONG TO A DEPARTMENT */

SELECT E.FIRST_NAME, E.LAST_NAME, D.DEPARTMENT_ID
FROM EMPLOYEES E
         JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
ORDER BY DEPARTMENT_ID;

/* 4) For the new stationery, the secretary's office needs a list of all departments (department_name) as well as their address consisting of the postal code, the city, the province, and the street_address */
SELECT D.DEPARTMENT_NAME, L.POSTAL_CODE, L.CITY, L.STATE_PROVINCE, L.STREET_ADDRESS
FROM DEPARTMENTS D
         JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID
ORDER BY DEPARTMENT_NAME;


/* 5) The secretariat thanks for the list, but would like to have the name of the country in addition. */
SELECT D.DEPARTMENT_NAME, L.POSTAL_CODE, L.CITY, L.STATE_PROVINCE, L.STREET_ADDRESS, C.COUNTRY_NAME
FROM DEPARTMENTS D
         JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID
         JOIN COUNTRIES C ON L.COUNTRY_ID = C.COUNTRY_ID
ORDER BY DEPARTMENT_NAME;


/* 6) The secretariat thanks for the updated list. Embarrassed, the first and last name as "Manager" of the respective manager of the department is now requested in addition. */
SELECT D.DEPARTMENT_NAME,
       L.POSTAL_CODE,
       L.CITY,
       L.STATE_PROVINCE,
       L.STREET_ADDRESS,
       C.COUNTRY_NAME,
       M.FIRST_NAME AS Manager_first_name,
       M.LAST_NAME  AS Manager_last_name
FROM DEPARTMENTS D
         LEFT JOIN
     LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID
         LEFT JOIN
     COUNTRIES C ON L.COUNTRY_ID = C.COUNTRY_ID
         LEFT JOIN
     EMPLOYEES M ON D.MANAGER_ID = M.EMPLOYEE_ID
ORDER BY DEPARTMENT_NAME;

/* 7) The personnel department needs a list of the employees with the following contents: */
/* 7.1.) First and last name as "Name */
SELECT FIRST_NAME || ' ' || LAST_NAME AS NAME
FROM EMPLOYEES;

/* 7.2.) job_title as "job" */
SELECT FIRST_NAME || ' ' || LAST_NAME AS NAME,
       JOB_ID                         AS JOB
FROM EMPLOYEES;
/* 7.3.) The salary */
SELECT FIRST_NAME || ' ' || LAST_NAME AS NAME,
       JOB_ID                         AS JOB,
       SAL + NVL(COMM_POT, 0)         AS SALARY
FROM EMPLOYEES;
/* 7.4.) The department name */
SELECT E.FIRST_NAME || ' ' || E.LAST_NAME AS NAME,
       E.JOB_ID                           AS JOB,
       E.SAL + NVL(E.COMM_POT, 0)         AS SALARY,
       D.DEPARTMENT_NAME
FROM EMPLOYEES E
         JOIN
     DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;

/*8) The new General Manager asks you to find out which subordinates each employee has. You could now collect the data manually*/
SELECT
    M.FIRST_NAME || ' ' || M.LAST_NAME AS MANAGER_NAME,
    E.FIRST_NAME || ' ' || E.LAST_NAME AS SUBORDINATE_NAME
FROM
    EMPLOYEES M
JOIN
    EMPLOYEES E ON M.EMPLOYEE_ID = E.MANAGER_ID
ORDER BY
    M.FIRST_NAME, M.LAST_NAME, E.FIRST_NAME, E.LAST_NAME;
