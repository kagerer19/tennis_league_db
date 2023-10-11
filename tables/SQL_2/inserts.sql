/* COMPETENCE CHECK */
CREATE TABLE Regions
(
    REG_ID   NUMBER(11) PRIMARY KEY,
    REG_NAME VARCHAR(25)
);

CREATE TABLE Countries
(
    COUNTRY_ID   CHAR(2) PRIMARY KEY,
    COUNTRY_NAME VARCHAR(40),
    REG_ID       NUMBER(11),
    FOREIGN KEY (REG_ID) REFERENCES Regions (REG_ID)
);

CREATE TABLE Locations
(
    LOCATION_ID    CHAR(4) PRIMARY KEY,
    STREET_ADDRESS VARCHAR(40),
    POSTAL_CODE    NUMBER(15),
    CITY           VARCHAR(30),
    STATE_PROVINCE VARCHAR(25),
    COUNTRY_ID     CHAR(2),
    FOREIGN KEY (COUNTRY_ID) REFERENCES Countries (COUNTRY_ID)
);


CREATE TABLE Departments
(
    DEPARTMENT_ID   NUMBER(4) PRIMARY KEY,
    DEPARTMENT_NAME VARCHAR(40),
    MANAGER_ID      NUMBER(6),
    LOCATION_ID     CHAR(4),
    FOREIGN KEY (LOCATION_ID) REFERENCES Locations (LOCATION_ID)
);

CREATE TABLE Jobs
(
    JOB_ID    VARCHAR(20) PRIMARY KEY,
    JOB_TITLE VARCHAR(40),
    MIN_SAL   NUMBER(11),
    MAX_SAL   NUMBER(11)
);

CREATE TABLE Employees
(
    EMPLOYEE_ID   NUMBER(6) PRIMARY KEY,
    FIRST_NAME    VARCHAR(40),
    LAST_NAME     VARCHAR(40),
    EMAIL         VARCHAR(40),
    PHONE_NUM     VARCHAR(22),
    HIRE_DATE     DATE,
    JOB_ID        VARCHAR(20),
    SAL           DECIMAL(8, 2),
    COMM_POT      DECIMAL(8, 2),
    MANAGER_ID    NUMBER(11),
    DEPARTMENT_ID NUMBER(4),
    FOREIGN KEY (JOB_ID) REFERENCES Jobs (JOB_ID),
    FOREIGN KEY (DEPARTMENT_ID) REFERENCES Departments (DEPARTMENT_ID),
    FOREIGN KEY (MANAGER_ID) REFERENCES Employees (EMPLOYEE_ID)
);


CREATE TABLE JOB_HISTORY
(
    EMPLOYEE_ID   NUMBER(6),
    START_DATE    DATE,
    END_DATE      DATE,
    JOB_ID        VARCHAR(20),
    DEPARTMENT_ID NUMBER(4),
    PRIMARY KEY (EMPLOYEE_ID, START_DATE),
    FOREIGN KEY (JOB_ID) REFERENCES Jobs (JOB_ID),
    FOREIGN KEY (EMPLOYEE_ID) REFERENCES Employees (EMPLOYEE_ID),
    FOREIGN KEY (DEPARTMENT_ID) REFERENCES Departments (DEPARTMENT_ID)
);


/*
### Table Creation Order:
1. `Regions` - No dependencies.
2. `Jobs` - No dependencies.
3. `Countries` - Depends on `Regions`.
4. `Locations` - Depends on `Countries`.
5. `Departments` - Depends on `Locations`.
6. `Employees` - Depends on `Jobs`, `Departments`, and self-referential for the manager.
7. `JOB_HISTORY` - Depends on `Employees`, `Jobs`, and `Departments`.

### Data Insertion Order:
1. `Regions`
2. `Jobs`
3. `Countries` - After `Regions`.
4. `Locations` - After `Countries`.
5. `Departments` - After `Locations`.
6. `Employees` - After `Jobs`, `Departments`. Note: If you have employees who are managers, you'll want to ensure that any managers are inserted before the employees they manage to satisfy the foreign key constraint.
7. `JOB_HISTORY` - After `Employees`, `Jobs`, and `Departments`.

*/


/*INSERTS*/
-- Regions
INSERT INTO Regions
VALUES (1, 'Europe');
INSERT INTO Regions
VALUES (2, 'Americas');
INSERT INTO Regions
VALUES (3, 'Asia');
INSERT INTO Regions
VALUES (4, 'Middle East and Africa');
COMMIT;

-- Countries
INSERT INTO Countries
VALUES ('US', 'United States of America', 2);
INSERT INTO Countries
VALUES ('CA', 'Canada', 2);
INSERT INTO Countries
VALUES ('UK', 'United Kingdom', 1);
INSERT INTO Countries
VALUES ('DE', 'Germany', 1);
COMMIT;
-- Locations
INSERT INTO Locations
VALUES (1400, '2014 Jabberwocky Rd', '26192', 'Southlake', 'Texas', 'US');
INSERT INTO Locations
VALUES (1500, '2011 Interiors Blvd', '99236', 'South San Francisco', 'California', 'US');
INSERT INTO Locations
VALUES (1700, '2004 Charade Rd', '98199', 'Seattle', 'Washington', 'US');
INSERT INTO Locations
VALUES (1800, '147 Spadina Ave', 'M5V 2L7', 'Toronto', 'Ontario', 'CA');
INSERT INTO Locations
VALUES (2500, 'Magdalen Centre, The Oxford Science Park', 'OX9 9ZB', 'Oxford', 'Oxford', 'UK');
COMMIT;


-- Departments
INSERT INTO Departments
VALUES (10, 'Administration', 200, 1700);
INSERT INTO Departments
VALUES (20, 'Marketing', 201, 1800);
INSERT INTO Departments
VALUES (60, 'IT', 103, 1400);
INSERT INTO Departments
VALUES (90, 'Executive', 100, 1700);
INSERT INTO Departments
VALUES (50, 'Shipping', 121, 1500);
INSERT INTO Departments
VALUES (80, 'Sales', 145, 2500);
INSERT INTO Departments
VALUES (110, 'Accounting', 205, 1700);
INSERT INTO Departments
VALUES (190, 'Contracting', NULL, 1700);
COMMIT;
-- Jobs
INSERT INTO Jobs
VALUES ('AD_PRES', 'President', 20000, 40000);
INSERT INTO Jobs
VALUES ('AD_VP', 'Administration Vice President', 15000, 30000);
INSERT INTO Jobs
VALUES ('SA_MAN', 'Sales Manager', 10000, 20000);
INSERT INTO Jobs
VALUES ('MK_REP', 'Marketing Representative', 4000, 9000);
INSERT INTO Jobs
VALUES ('AD_ASST', 'Administration Assistant', 3000, 6000);
INSERT INTO Jobs
VALUES ('AC_MGR', 'Accounting Manager', 8200, 16000);
INSERT INTO Jobs
VALUES ('AC_ACCOUNT', 'Public Accountant', 4200, 9000);
INSERT INTO Jobs
VALUES ('SA_REP', 'Sales Representative', 6000, 12000);
INSERT INTO Jobs
VALUES ('ST_MAN', 'Stock Manager', 5500, 8500);
INSERT INTO Jobs
VALUES ('ST_CLERK', 'Stock Clerk', 2000, 5000);
INSERT INTO Jobs
VALUES ('SH_CLERK', 'Shipping Clerk', 2500, 5500);
INSERT INTO Jobs
VALUES ('IT_PROG', 'Programmer', 4000, 10000);
INSERT INTO Jobs
VALUES ('MK_MAN', 'Marketing Manager', 9000, 15000);
COMMIT;

/* Employees */

INSERT INTO Employees VALUES (100, 'Steven', 'King', 'SKING', '515.123.4567', TO_DATE('1987-06-17', 'YYYY-MM-DD'), 'AD_PRES', 24000, NULL, NULL, 90);
INSERT INTO Employees VALUES (101, 'Neena', 'Kochhar', 'NKOCHHAR', '515.123.4568', TO_DATE('1989-09-21', 'YYYY-MM-DD'), 'AD_VP', 17000, NULL, 100, 90);
INSERT INTO Employees VALUES (102, 'Lex', 'De Haan', 'LDEHAAN', '515.123.4569', TO_DATE('1993-01-13', 'YYYY-MM-DD'), 'AD_VP', 17000, NULL, 100, 90);
INSERT INTO Employees VALUES (103, 'Alexander', 'Hunold', 'AHUNOLD', '590.423.4567', TO_DATE('1990-01-03', 'YYYY-MM-DD'), 'IT_PROG', 9000, NULL, 102, 60);
INSERT INTO Employees VALUES (104, 'Bruce', 'Ernst', 'BERNST', '590.423.4568', TO_DATE('1991-05-21', 'YYYY-MM-DD'), 'IT_PROG', 6000, NULL, 103, 60);
INSERT INTO Employees VALUES (107, 'Diana', 'Lorentz', 'DLORENTZ', '590.423.5567', TO_DATE('1999-02-07', 'YYYY-MM-DD'), 'IT_PROG', 4200, NULL, 103, 60);
INSERT INTO Employees VALUES (124, 'Kevin', 'Mourgos', 'KMOURGOS', '650.123.5234', TO_DATE('1999-11-16', 'YYYY-MM-DD'), 'ST_MAN', 5800, NULL, 100, 50);
INSERT INTO Employees VALUES (141, 'Trenna', 'Rajs', 'TRAJS', '650.121.8009', TO_DATE('1995-10-17', 'YYYY-MM-DD'), 'ST_CLERK', 3500, NULL, 124, 50);
INSERT INTO Employees VALUES (142, 'Curtis', 'Davies', 'CDAVIES', '650.121.2994', TO_DATE('1997-01-29', 'YYYY-MM-DD'), 'ST_CLERK', 3100, NULL, 124, 50);
INSERT INTO Employees VALUES (143, 'Randall', 'Matos', 'RMATOS', '650.121.2874', TO_DATE('1998-03-15', 'YYYY-MM-DD'), 'ST_CLERK', 2600, NULL, 124, 50);
INSERT INTO Employees VALUES (144, 'Peter', 'Vargas', 'PVARGAS', '650.121.2004', TO_DATE('1998-07-09', 'YYYY-MM-DD'), 'ST_CLERK', 2500, NULL, 124, 50);
INSERT INTO Employees VALUES (149, 'Eleni', 'Zlotkey', 'EZLOTKEY', '011.44.1344.429018', TO_DATE('2000-01-29', 'YYYY-MM-DD'), 'SA_MAN', 10500, 0.2, 100, 80);
INSERT INTO Employees VALUES (174, 'Ellen', 'Abel', 'EABEL', '011.44.1644.429267', TO_DATE('1996-05-11', 'YYYY-MM-DD'), 'SA_REP', 11000, 0.30, 149, 80);
INSERT INTO Employees VALUES (176, 'Jonathon', 'Taylor', 'JTAYLOR', '011.44.1644.429265', TO_DATE('1998-03-24', 'YYYY-MM-DD'), 'SA_REP', 8600, 0.20, 149, 80);
INSERT INTO Employees VALUES (178, 'Kimberely', 'Grant', 'KGRANT', '011.44.1644.429263', TO_DATE('1999-05-24', 'YYYY-MM-DD'), 'SA_REP', 7000, 0.15, 149, NULL);
INSERT INTO Employees VALUES (200, 'Jennifer', 'Whalen', 'JWHALEN', '515.123.4444', TO_DATE('1987-09-17', 'YYYY-MM-DD'), 'AD_ASST', 4400, NULL, 101, 10);
INSERT INTO Employees VALUES (201, 'Michael', 'Hartstein', 'MHARTSTE', '515.123.5555', TO_DATE('1996-02-17', 'YYYY-MM-DD'), 'MK_MAN', 13000, NULL, 100, 20);
INSERT INTO Employees VALUES (202, 'Pat', 'Fay', 'PFAY', '603.123.6666', TO_DATE('1997-08-17', 'YYYY-MM-DD'), 'MK_REP', 6000, NULL, 201, 20);
INSERT INTO Employees VALUES (205, 'Shelley', 'Higgins', 'SHIGGINS', '515.123.8080', TO_DATE('1994-06-07', 'YYYY-MM-DD'), 'AC_MGR', 12000, NULL, 101, 110);
INSERT INTO Employees VALUES (206, 'William', 'Gietz', 'WGIETZ', '515.123.8181', TO_DATE('1994-06-07', 'YYYY-MM-DD'), 'AC_ACCOUNT', 8300, NULL, 205, 110);

COMMIT;


/* Job History */

INSERT INTO JOB_HISTORY
VALUES ( 102
       , TO_DATE('1993-01-13', 'YYYY-MM-DD')
       , TO_DATE('1998-06-24', 'YYYY-MM-DD')
       , 'IT_PROG'
       , 60);

INSERT INTO JOB_HISTORY
VALUES ( 101
       , TO_DATE('1989-09-21', 'YYYY-MM-DD')
       , TO_DATE('1993-10-27', 'YYYY-MM-DD')
       , 'AC_ACCOUNT'
       , 110);

INSERT INTO JOB_HISTORY
VALUES ( 201
       , TO_DATE('1996-02-17', 'YYYY-MM-DD')
       , TO_DATE('1999-12-19', 'YYYY-MM-DD')
       , 'MK_REP'
       , 20);

INSERT INTO JOB_HISTORY
VALUES ( 200
       , TO_DATE('1987-09-17', 'YYYY-MM-DD')
       , TO_DATE('1993-06-17', 'YYYY-MM-DD')
       , 'AD_ASST'
       , 90);

INSERT INTO JOB_HISTORY
VALUES ( 176
       , TO_DATE('1999-01-01', 'YYYY-MM-DD')
       , TO_DATE('1999-12-31', 'YYYY-MM-DD')
       , 'SA_MAN'
       , 80);

INSERT INTO JOB_HISTORY
VALUES ( 200
       , TO_DATE('1994-06-01', 'YYYY-MM-DD')
       , TO_DATE('1998-12-31', 'YYYY-MM-DD')
       , 'AC_ACCOUNT'
       , 90);

INSERT INTO JOB_HISTORY
VALUES ( 101
       , TO_DATE('1993-10-28', 'YYYY-MM-DD')
       , TO_DATE('1997-03-15', 'YYYY-MM-DD')
       , 'AC_MGR'
       , 110);

INSERT INTO JOB_HISTORY
VALUES ( 176
       , TO_DATE('1998-03-24', 'YYYY-MM-DD')
       , TO_DATE('1998-12-31', 'YYYY-MM-DD')
       , 'SA_REP'
       , 80);
COMMIT;


