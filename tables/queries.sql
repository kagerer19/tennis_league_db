/* EX-3 */

/* 1. output of PLAYERNO, NAME of players born after 1960.  */
select PLAYERNO
from PLAYERS
where YEAR_OF_BIRTH > 1960;

/* 2. output of PLAYERNO, NAME and TOWN of all female players who do not reside in Strat- ford. */
select PLAYERNO, NAME, TOWN
from PLAYERS
where SEX = 'F';

/* 3. output of player numbers of players who joined the club between 1970 and 1980. */
select PLAYERNO
from PLAYERS
where YEAR_JOINED >= 1970
  and YEAR_JOINED >= 1980;


/* 4. output of PlayerId, Name, Year of Birth of players born in a leap year. */
select PLAYERNO
from PLAYERS
where (MOD(YEAR_OF_BIRTH, 4) = 0 and MOD(YEAR_OF_BIRTH, 100) <> 0)
   or MOD(YEAR_OF_BIRTH, 400) = 0;


/*5. output of the penalty numbers of the penalties between 50,- and 100,-.*/
select AMOUNT
from PENALTIES
where AMOUNT >= 50
  and AMOUNT <= 100;


/*6. output of PlayerId, name of players who do not live in Stratford or Douglas.*/
select PLAYERNO, NAME
from PLAYERS
where TOWN not in ('Stratford', 'Douglas');

/*7. output of playerId and name of players whose name contains 'is'.*/
select PLAYERNO, NAME
from PLAYERS
where NAME like '%is%';

/*8. output of all hobby players.*/
select PLAYERNO, NAME
from PLAYERS
where LEAGUENO IS NULL;


/* 9. output of those employees who receive more commission than salary. */
select EMPNO, ENAME
from EMP
where COMM > SAL;


/* 10. output of all employees from department 30 whose salary is greater than or equal to 1500. */
select EMPNO, ENAME, DEPTNO
from EMP
where DEPTNO = 30
  and SAL >= 1500;

/* 11. output of all managers who do not belong to department 30. */
select MGR
from EMP
where DEPTNO not in (30);


/* 12. output of all employees from department 10 who are neither managers nor clerical workers (CLERK). */
select EMPNO, ENAME
from EMP
where DEPTNO = 10
  and JOB not in ('Manager', 'Clerk');


/* 13. output of all employees who earn between 1200,- and 1300,-. */
select EMPNO, ENAME
from EMP
where SAL > 1200
  and SAL < 1300;


/* 14. output all employees whose name is 5 characters long and begins with ALL. */
select *
from EMP
where length(ENAME) = 5
  and ENAME like '%ALL%';


/* 15. output the total salary (salary + commission) for each employee. */
select EMPNO, ENAME, SAL + NVL(COMM, 0) as TOTAL_SALARY
from EMP;


/* 16. output all employees, whose commission is over 25% of the salary. */
select *
from EMP
where COMM > 0.25 * SAL;


/* 17. searched is the average salary of all office employees. */
select round(avg(SAL))
from EMP;


/* 18. searched is the number of employees who have received a commission. */
select EMPNO, ENAME
from EMP
where SAL is not null;


/* 19. wanted is the number of different jobs in department 30. */
select count(DISTINCT JOB)
from EMP
where DEPTNO = 30;


/* 20. wanted is the number of employees in department 30. */
select COUNT(EMPNO)
from EMP
where DEPTNO = 30;

/* 21. output of employees hired between 4/1/81 and 15/4/81. */
select *
from EMP
where HIREDATE > TO_DATE('4-JAN-1981', 'DD-MON-YYYY')
  and HIREDATE < TO_DATE('15-APR-1981', 'DD-MON-YYYY');


/* EX-4 */
/* 1. output TEAMNO of the teams in which the player with the number 27 is not captain */
select TEAMNO
from TEAMS
where PLAYERNO in (select PLAYERNO from PLAYERS where PLAYERNO not in 27);

/* 2. output of PLAYERNO, NAME and INITIALS of the players who have won at least one match */
select PLAYERNO, NAME, INITIALS
from PLAYERS
where PLAYERNO in (select PLAYERNO from MATCHES where WON >= 1);

/* 3. output of playerNo and name of the players who have received at least one penalty */
select PLAYERNO, NAME from PLAYERS where PLAYERNO in (select count(DISTINCT PLAYERNO) from PENALTIES);

/* 4. output of playerNo and name of the players, who have received at least one penalty over 50.*/

/* 5. output of PlayerNo and name of players born in the same year as R. Parmenter*/

/* 6. output of playerNo and name of the oldest player from Stratford*/


















