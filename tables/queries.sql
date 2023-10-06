/* SQL Exercise-3 */

/* 1. output of PLAYERNO, NAME of players born after 1960.  */
SELECT PLAYERNO
FROM PLAYERS
WHERE YEAR_OF_BIRTH > 1960;

/* 2. output of PLAYERNO, NAME and TOWN of all female players who do not reside in Strat- ford. */
SELECT PLAYERNO, NAME, TOWN
FROM PLAYERS
WHERE SEX = 'F';

/* 3. output of player numbers of players who joined the club between 1970 and 1980. */
SELECT PLAYERNO
FROM PLAYERS
WHERE YEAR_JOINED >= 1970
  AND YEAR_JOINED >= 1980;


/* 4. output of PlayerId, Name, Year of Birth of players born in a leap year. */
SELECT PLAYERNO
FROM PLAYERS
WHERE (MOD(YEAR_OF_BIRTH, 4) = 0 AND MOD(YEAR_OF_BIRTH, 100) <> 0)
   OR MOD(YEAR_OF_BIRTH, 400) = 0;


/*5. output of the penalty numbers of the penalties between 50,- and 100,-.*/
SELECT AMOUNT
FROM PENALTIES
WHERE AMOUNT >= 50
  AND AMOUNT <= 100;


/*6. output of PlayerId, name of players who do not live in Stratford or Douglas.*/
SELECT PLAYERNO, NAME
FROM PLAYERS
WHERE TOWN NOT IN ('Stratford', 'Douglas');

/*7. output of playerId and name of players whose name contains 'is'.*/
SELECT PLAYERNO, NAME
FROM PLAYERS
WHERE NAME LIKE '%is%';

/*8. output of all hobby players.*/
SELECT PLAYERNO, NAME
FROM PLAYERS
WHERE LEAGUENO IS NULL;


/* 9. output of those employees who receive more commission than salary. */
SELECT EMPNO, ENAME
FROM EMP
WHERE COMM > SAL;


/* 10. output of all employees from department 30 whose salary is greater than or equal to 1500. */
SELECT EMPNO, ENAME, DEPTNO
FROM EMP
WHERE DEPTNO = 30
  and SAL >= 1500;

/* 11. output of all managers who do not belong to department 30. */
SELECT MGR
FROM EMP
WHERE DEPTNO NOT IN (30);


/* 12. output of all employees from department 10 who are neither managers nor clerical workers (CLERK). */
SELECT EMPNO, ENAME
FROM EMP
WHERE DEPTNO = 10
  AND JOB NOT IN ('Manager', 'Clerk');


/* 13. output of all employees who earn between 1200,- and 1300,-. */
SELECT EMPNO, ENAME
FROM EMP
WHERE SAL > 1200
  AND SAL < 1300;


/* 14. output all employees whose name is 5 characters long and begins with ALL. */
SELECT *
FROM EMP
WHERE length(ENAME) = 5
  AND ENAME LIKE '%ALL%';


/* 15. output the total salary (salary + commission) for each employee. */
SELECT EMPNO, ENAME, SAL + NVL(COMM, 0) as TOTAL_SALARY
FROM EMP;


/* 16. output all employees, whose commission is over 25% of the salary. */
SELECT *
FROM EMP
WHERE COMM > 0.25 * SAL;


/* 17. searched is the average salary of all office employees. */
SELECT round(avg(SAL))
FROM EMP;


/* 18. searched is the number of employees who have received a commission. */
SELECT EMPNO, ENAME
FROM EMP
WHERE SAL IS NOT NULL;


/* 19. wanted is the number of different jobs in department 30. */
SELECT count(DISTINCT JOB)
FROM EMP
WHERE DEPTNO = 30;


/* 20. wanted is the number of employees in department 30. */
SELECT COUNT(EMPNO)
FROM EMP
WHERE DEPTNO = 30;

/* 21. output of employees hired between 4/1/81 and 15/4/81. */
SELECT *
FROM EMP
WHERE HIREDATE > TO_DATE('4-JAN-1981', 'DD-MON-YYYY')
  AND HIREDATE < TO_DATE('15-APR-1981', 'DD-MON-YYYY');


/* SQL Exercise-4 */
/* 1. output TEAMNO of the teams in which the player with the number 27 is not captain */
SELECT TEAMNO
FROM TEAMS
WHERE PLAYERNO IN (SELECT PLAYERNO FROM PLAYERS WHERE PLAYERNO NOT IN 27);

/* 2. output of PLAYERNO, NAME and INITIALS of the players who have won at least one match */
SELECT PLAYERNO, NAME, INITIALS
FROM PLAYERS
WHERE PLAYERNO IN (SELECT PLAYERNO FROM MATCHES WHERE WON >= 1);

/* 3. output of playerNo and name of the players who have received at least one penalty */
SELECT PLAYERNO, NAME
FROM PLAYERS
WHERE PLAYERNO IN
      (SELECT PLAYERNO
       FROM PENALTIES
       GROUP BY PLAYERNO
       HAVING COUNT(PLAYERNO) > 1);

/* 4. output of playerNo and name of the players, who have received at least one penalty over 50.*/
SELECT PLAYERNO, NAME
FROM PLAYERS
WHERE PLAYERNO in (SELECT PLAYERNO FROM PENALTIES WHERE AMOUNT > 50);

/* 5. output of PlayerNo and name of players born in the same year as R. Parmenter*/
SELECT PLAYERNO, NAME
FROM PLAYERS
WHERE YEAR_OF_BIRTH IN (SELECT YEAR_OF_BIRTH FROM PLAYERS WHERE YEAR_OF_BIRTH = 1963);


/* 6. output of playerNo and name of the oldest player from Stratford*/
SELECT PLAYERNO, NAME
FROM PLAYERS
WHERE YEAR_OF_BIRTH IN (SELECT min(YEAR_OF_BIRTH) FROM PLAYERS WHERE TOWN = 'Stratford');

/*   SQL Exercise 5   */

/* 1. number of new players per year */
SELECT YEAR_JOINED, COUNT(*) AS NUMBER_OF_PLAYERS
FROM PLAYERS
GROUP BY YEAR_JOINED
ORDER BY YEAR_JOINED;

/* 2. number and average amount of penalties per player */
SELECT PLAYERNO,
       COUNT(*)           AS NUMBER_OF_PENALTIES,
       ROUND(AVG(AMOUNT)) AS AVERAGE_AMOUNT
FROM PENALTIES
GROUP BY PLAYERNO
ORDER BY PLAYERNO;

/* 3. number of penalties for the years before 1983 */
SELECT EXTRACT(YEAR FROM PEN_DATE) AS PENALTY_YEAR, COUNT(*) AS NUMBER_OF_PENS
FROM PENALTIES
WHERE EXTRACT(YEAR FROM PEN_DATE) < 1983
GROUP BY EXTRACT(YEAR FROM PEN_DATE)
ORDER BY PENALTY_YEAR;

/* 4. in which cities live more than 4 players */
SELECT TOWN
FROM PLAYERS
GROUP BY TOWN
HAVING COUNT(*) > 4;

/* 5. PLAYERNO of those players whose penalty total is over 150 */
SELECT PLAYERNO
FROM PENALTIES
WHERE AMOUNT > 150;

/* 6. NAME and INITIALS of those players who received more than one penalty */
SELECT NAME, INITIALS
FROM PLAYERS
WHERE PLAYERNO IN
      (SELECT PLAYERNO FROM PENALTIES GROUP BY PLAYERNO HAVING COUNT(*) > 1);

/* 7. in which years there were exactly 2 penalties */
SELECT EXTRACT(YEAR FROM PEN_DATE) AS PENALTY_YEAR, COUNT(*) AS NUMBER_OF_PENS
FROM PENALTIES
GROUP BY EXTRACT(YEAR FROM PEN_DATE)
HAVING COUNT(*) = 2
ORDER BY PENALTY_YEAR;

/* 8. NAME and INITIALS of the players who received 2 or more penalties over $40 */
SELECT NAME, INITIALS
FROM PLAYERS
WHERE PLAYERNO IN
      (SELECT PLAYERNO FROM PENALTIES GROUP BY PLAYERNO HAVING COUNT(*) > 2 AND SUM(PENALTIES.AMOUNT) > 40);

/* 9. NAME and INITIALS of the player with the highest penalty amount */

SELECT NAME, INITIALS
FROM PLAYERS
WHERE PLAYERNO IN
      (SELECT PLAYERNO
       FROM PENALTIES
       GROUP BY PLAYERNO
       HAVING SUM(AMOUNT) =
              (SELECT MAX(TOT_AMOUNT)
               FROM (SELECT SUM(AMOUNT) AS TOT_AMOUNT
                     FROM PENALTIES
                     GROUP BY PLAYERNO)));

/* 10. in which year there were the most penalties and how many were there */
SELECT EXTRACT(YEAR FROM PEN_DATE) AS PENALTY_YEAR, COUNT(*) AS NUMBER_OF_PENS
FROM PENALTIES
GROUP BY EXTRACT(YEAR FROM PEN_DATE)
HAVING COUNT(*) = (SELECT MAX(PenaltyCount)
                   FROM (SELECT EXTRACT(YEAR FROM PEN_DATE) AS Year, COUNT(*) AS PenaltyCount
                         FROM PENALTIES
                         GROUP BY EXTRACT(YEAR FROM PEN_DATE)))
ORDER BY PENALTY_YEAR;

/* 11. For each occurnce of a players in teams, show the PLAYERNO, TEAMNO, "WON - LOST" (nicely formatted, for example "3 - 2") sorted by the sum of lost Matches of this player in this team.   */
SELECT PLAYERNO, TEAMNO, CONCAT(CONCAT(WON, '-'), LOST) AS WON_LOST
FROM MATCHES
GROUP BY PLAYERNO, TEAMNO, CONCAT(CONCAT(WON, '-'), LOST)
ORDER BY SUM(LOST);



/*   EMP Section   */
/* 12. output of all employees from department 30 sorted by their salary starting with the highest salary.*/
SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE DEPTNO = 30
ORDER BY SAL DESC;

/* 13. output of all employees sorted by job and within the job by their salary*/
SELECT JOB, ENAME, SAL
FROM EMP
ORDER BY JOB, SAL DESC;

/* 14. output of all employees sorted by their year of employment in descending order and within the year by their name*/
SELECT ENAME, HIREDATE
FROM EMP
ORDER BY ENAME, HIREDATE DESC;

/* 15. output of all salesmen in descending order regarding the ratio commission to salary*/
SELECT JOB, ENAME, SAL
FROM EMP
WHERE JOB = 'SALESMAN'
ORDER BY (COMM / SAL) DESC;

/* 16. output the average salary for each department number*/
SELECT DEPTNO, ROUND(AVG(SAL)) AS AVERAGE_SAL
FROM EMP
GROUP BY DEPTNO
ORDER BY DEPTNO;

/* 17. calculate the average annual salaries of those jobs that are performed by more than 2 employees */
SELECT JOB, ROUND(AVG(SAL)) AS AVERAGE_SAL
FROM EMP
GROUP BY JOB
HAVING COUNT(*) > 2;

/* 18. output all department numbers with at least 2 office workers*/
SELECT JOB, DEPTNO
FROM EMP
GROUP BY DEPTNO, JOB
HAVING COUNT(*) >= 2;

/* 19. find the average value for salary and commission of all employees from department 30*/
SELECT ROUND(AVG(SAL))  AS AVG_SALARY,
       ROUND(AVG(COMM)) AS AVG_COMMISSION
FROM EMP
WHERE DEPTNO = 30;


/* SQL Exercise 6 */
/* 1-5 Tennis query */


/* 1. NAME, INITIALS and number of sets won for each player */
SELECT NAME,
       INITIALS,
       (SELECT SUM(WON)
        FROM MATCHES
        WHERE PLAYERS.PLAYERNO = MATCHES.PLAYERNO) AS SETS_WON
FROM PLAYERS
ORDER BY NAME, INITIALS;

/* 2. NAME, PEN_DATE and AMOUNT sorted in descending order by AMOUNT */
SELECT NAME, PEN_DATE, AMOUNT
FROM PLAYERS,
     PENALTIES
WHERE PLAYERS.PLAYERNO = PENALTIES.PLAYERNO
ORDER BY AMOUNT DESC;


/* 3. TEAMNO, NAME (of the captain) per team */
SELECT TEAMNO, NAME
FROM PLAYERS,
     TEAMS
WHERE PLAYERS.PLAYERNO = TEAMS.PLAYERNO;


/* 4. NAME (player name), WON, LOST of all won matches*/
SELECT NAME, WON, LOST
FROM PLAYERS,
     MATCHES
WHERE PLAYERS.PLAYERNO = MATCHES.PLAYERNO
  AND MATCHES.WON > 0;

/* 5. PLAYERNO, NAME and penalty amount for each team player. If a player has not yet received a penalty, it should still be issued. Sorting should be done in ascending order of penalty amount */
SELECT NAME, AMOUNT, PLAYERS.PLAYERNO
FROM PLAYERS,
     PENALTIES
WHERE PLAYERS.PLAYERNO = PENALTIES.PLAYERNO
ORDER BY PLAYERNO DESC;


/* 6-9 EmptDept query */


/* 6. in which city does the employee Allen work? */
SELECT DEPT.LOC
FROM EMP,
     DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO
  AND EMP.ENAME = 'ALLEN';


/* 7. search for all employees who earn more than their supervisor */
SELECT E.EMPNO, E.ENAME
FROM EMP E
WHERE E.SAL > (SELECT E2.SAL FROM EMP E2 WHERE E2.EMPNO = E.MGR);


/* 8. output the number of hires in each year */
SELECT EXTRACT(YEAR FROM HIREDATE) AS HIRE_YEAR, COUNT(*) AS NUMBER_OF_HIRES
FROM EMP
GROUP BY EXTRACT(YEAR FROM HIREDATE)
ORDER BY HIRE_YEAR;


/* 9. output all employees who have a job like an employee from CHICAGO. */
SELECT ENAME, JOB
FROM EMP
WHERE JOB IN (SELECT DISTINCT JOB
              FROM EMP
              WHERE DEPTNO IN (SELECT DEPTNO
                               FROM DEPT
                               WHERE LOC = 'CHICAGO'));



/*  SQL Exercise 7     */

/*  1-4 Tennis query    */

/*  1. output of players names who played for both team 1 and team 2.   */
SELECT P.NAME
FROM PLAYERS P
WHERE EXISTS (SELECT 1 FROM MATCHES M WHERE M.PLAYERNO = P.PLAYERNO AND M.TEAMNO = 1)
  AND EXISTS (SELECT 1 FROM MATCHES M WHERE M.PLAYERNO = P.PLAYERNO AND M.TEAMNO = 2);


/*  2. output the NAME and INITIALS of the players who did not receive a penalty in 1980    */
SELECT NAME, INITIALS
FROM PLAYERS P
WHERE NOT EXISTS (SELECT 1
                  FROM PENALTIES PEN
                  WHERE PEN.PLAYERNO = P.PLAYERNO
                    AND EXTRACT(YEAR FROM PEN.PEN_DATE) = 1980)
ORDER BY NAME;


/*  3. output of players who received at least one penalty over $80    */
SELECT NAME
FROM PLAYERS P
WHERE EXISTS(SELECT 1
             FROM PENALTIES PEN
             WHERE PEN.PLAYERNO = P.PLAYERNO
               AND PEN.AMOUNT > 80)
ORDER BY NAME;


/*  4. output of players who had all penalties over $80.    */
SELECT NAME
FROM PLAYERS P
WHERE NOT EXISTS (SELECT 1
                  FROM PENALTIES PEN
                  WHERE PEN.PLAYERNO = P.PLAYERNO
                    AND PEN.AMOUNT <= 80)
  AND EXISTS (SELECT 1
              FROM PENALTIES PEN
              WHERE PEN.PLAYERNO = P.PLAYERNO)
ORDER BY NAME;


/*  5-8 EmpDept query    */

/*  5. find all employees whose salary is higher than the average salary of their department    */

/*  6. identify all departments that have at least one employee    */

/*  7. output of all departments that have at least one employee earning over $1000    */

/* 8. output of all departments in which each employee earns at least 1000,-. */