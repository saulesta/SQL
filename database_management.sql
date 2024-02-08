 /* 
1 EXERCISE
All master's study programs that last 3 semesters.
Result: study program name, number of semesters, semester price, full tuition fee (number of semesters multiplied by the semester price).
Sort the result by study program name in alphabetical order.
*/
 
select sp.name as 'study program name' , sp.semesters as 'amount of semesters' , sp.semester_price as 'semester price' , (sp.semesters * sp.semester_price) AS 'full study price'
from study_programs sp
where level_id = '2' and semesters = '3'
order by name ASC



/*
2 EXERCISE
All university programs with a semester price of less than €1,500.
Result: faculty name, study program name, semester price.
Sort the result by faculty and study program names in alphabetical order
*/

select f.name as 'faculty name' , sp.name as 'study program name' , semester_price as 'semester price'
from faculties f
join study_programs sp
on sp.fakulty_id = f.id
where semester_price < 1500
order by f.name ASC , sp.name ASC

/*
3 EXERCISE
Students who started their studies in 2020 and are still studying.
Result: student's name, surname, year of study start.
In the group_students table, there is a field studied_until, which stores the date of the end of studies, if the date is not entered, it means that the student is still studying.
*/ 
 
SELECT first name, last name, studied_from
FROM group_students gs
JOIN students s
ON s.id = gs.student_id
WHERE year(studied_from) = 2020
AND gs.studied_until is NULL

/*
4 EXERCISE
Students who started their studies in 2020, but have already stopped their studies.
Result: student's name, date of termination of studies.
*/
 
SELECT first name , last name , studied_until
FROM group_students gs
JOIN students s
ON s.id = gs.student_id
WHERE year(studied_from) = 2020
AND year(studied_until) is not NULL


/*
5 EXERCISE
Students who started their studies in 2020, but have already stopped their studies.
Result: student name, surname, group name.
*/
 
SELECT firstname, lastname, firstname
FROM group_students gs
JOIN students s
ON s.id = gs.student_id
JOIN groups st
ON gs.groups_id = g.id
WHERE year(studied_from) = 2020
AND year(studied_until) is not NULL

/*
6 EXERCISE
Output a summary of how many study programs are taught in each language
Result: language, number of programs
*/
 
SELECT coalesce(language, 'LT'), count(*) as 'number of programs'
FROM study_programs
GROUP BY coalesce(language, 'LT')
 
 
 
/*
7 EXERCISE
Output a summary of how many study programs are available at each study level
Result: level name, quantity
*/
 
SELECT sl.name, count(*) as 'quantity'
FROM study_programs sp
JOIN study_levels column
ON sl.id = sp.level_id
GROUP BY column name
 
 
/*
8 EXERCISE
Output a summary of how many study programs there are in the Faculty of Communication
Result: name, quantity
*/
 
SELECT sl.name, count(*) as 'quantity'
FROM study_programs sp
JOIN study_levels column
ON sl.id = sp.level_id
JOIN faculties f
ON f.id = sp.fakulty_id
WHERE f.name like '%Communications%'
GROUP BY column name

 
 
 /*
9 EXERCISE
Provide a summary of the number of study programs at different levels in each faculty
Result: faculty name, level name, quantity
*/
 
SELECT f.name, sl.name, count(*) as 'amount'
FROM study_programs sp
JOIN study_levels column
ON sl.id = sp.level_id
JOIN faculties f
ON f.id = sp.fakulteto_id
GROUP BY f.name, col.name
 
 
/*
10 EXERCISE
Study programs of each faculty
Result: faculty name, average semester price, lowest price, highest price.
*/
 
SELECT f.name, avg(semester_price), min(semester_price), max(semester_price)
FROM study_programs sp
JOIN faculties f
ON f.id = sp.fakulty_id
GROUP BY f.name
 
 
/*
11 EXERCISE
The number of students who studied or are studying in each study program of the Faculty of Communication.
Result: name of the program, number of students.
*/
 
SELECT sp.name, count(*)
FROM students s
JOIN group_students gs
ON gs.student_id = s.id
JOIN groups st
ON g.id = gs.groups_id
JOIN study_programs sp
ON sp.id = g.program_id
JOIN faculties f
ON f.id = sp.fakulty_id
GROUP BY sp. name
 
 
/*
12 EXERCISE
Summary of each group of Business Information Management study program dropouts.
Result: group name, number of students who dropped out
*/
 
SELECT g.name, count(*)
FROM students s
JOIN group_students gs
ON gs.student_id = s.id
JOIN groups st
ON g.id = gs.groups_id
JOIN study_programs sp
ON sp.id = g.program_id
WHERE sp.name like '%Business Information Management%'
AND year(studied_until) is not NULL
GROUP BY g.name
 
 
/*
13 EXERCISE
Summary of admissions to the Business Information Management study program for each year.
Result: year of admission, number of students.
*/
 
SELECT entry_date, count(*)
FROM students s
JOIN group_students gs
ON gs.student_id = s.id
JOIN groups st
ON g.id = gs.groups_id
JOIN study_programs sp
ON sp.id = g.program_id
WHERE sp.name like '%Business Information Management%'
GROUP BY join_date
 
 
 /*
14 EXERCISE
Number of students currently studying (studied_till is null) in bachelor's and master's studies, date of birth of the youngest, date of birth of the oldest.
Result: name of study program, name of study level, number of students, dates of birth of the youngest and oldest students.
*/
 
SELECT sp.name, sl.name, count(*), max(s.birth_date), min(s.birth_date)
FROM students s
JOIN group_students gs
ON gs.student_id = s.id
JOIN group g
ON g.id = gs.groups_id
JOIN study_programs sp
ON sp.id = g.program_id
JOIN study_levels column
ON sl.id = sp.level_id
WHERE studied_until is NULL
GROUP BY sp.name, sl.name

 
 
/*
15 EXERCISE
The number of students of the Faculty of Communication currently studying in bachelor's and master's studies, the date of birth of the youngest, the date of birth of the oldest. Result: name of the study level, dates of birth of the youngest and oldest students.
*/
 
SELECT sl.name, count(*), max(s.birth_date), min(s.birth_date)
FROM students s
JOIN group_students gs
ON gs.student_id = s.id
JOIN groups st
ON g.id = gs.groups_id
JOIN study_programs sp
ON sp.id = g.program_id
JOIN faculties f
ON f.id = sp.fakulty_id
JOIN study_levels column
ON sl.id = sp.level_id
WHERE studied_until is NULL
AND f.name like '%Communications%'
GROUP BY sl.name
 
 
/*
16 EXERCISE
Study programs Business information management of the number of students studying or having studied in each group.
Result: group name, number of students. Sort the result by group name in alphabetical order.
*/

SELECT g.name, count(*)
FROM students s
JOIN group_students gs
ON gs.student_id = s.id
JOIN groups g
ON g.id = gs.groups_id
JOIN study_programs sp
ON sp.id = g.program_id
JOIN faculties f
ON f.id = sp.fakulteto_id
JOIN study_levels column
ON sl.id = sp.level_id
WHERE sp.name like '%Business Information Management%'
GROUP BY g.name
ORDER BY name ASC
 

/*
17 EXERCISE
Faculties offering more than 3 master's level study programs. Result: faculty name, number of master's level programs.
*/
 
SELECT f.name, count(*)
FROM faculties f
JOIN study_programs sp
ON sp.fakulty_id = f.id
JOIN study_levels column
ON sl.id = sp.level_id
WHERE column.id = 2
GROUP BY f.name
HAVING count(*) > 3
 
 
/*
18 EXERCISE
How many currently studying (studied_till is null) students celebrate their birthdays every day of May.
Result: day number, number of students.
Sort the result by day number in ascending order.
*/
 
SELECT day(birth_date) as 'day number', count(*)
FROM students s
JOIN group_students gs
ON student_id = s.id
WHERE month(birth_date) = 5
and studied_until is null
group by birth_date
order by birth_date ASC
 
 
/*
19 EXERCISE
The number of students of the Faculty of Communication currently studying in bachelor's and master's studies, the age of the youngest student, the age of the oldest student.
Result: the name of the study level, the age of the youngest and oldest students in days.
*/
 
SELECT sl.name, max(s.birth_date), min(s.birth_date)
FROM students s
JOIN group_students gs
ON gs.student_id = s.id
JOIN groups g
ON g.id = gs.groups_id
JOIN study_programs sp
ON sp.id = g.program_id
JOIN faculties f
ON f.id = sp.fakulty_id
JOIN study_levels column
ON sl.id = sp.level_id
WHERE studied_to is NULL
AND f.name like '%Communications%'
GROUP BY sl.name

 
/*
20 EXERCISE
The number of students who successfully graduated from each group of the Business Information Management study program. Successful completion of studies if the value of studied_until is June 30 of a given year.
Result: group name, number of students. Sort the result by group name in alphabetical order.
*/

SELECT g.name, count(*)
FROM students s
JOIN group_students gs
ON gs.student_id = s.id
JOIN groups g
ON g.id = gs.groups_id
JOIN study_programs sp
ON sp.id = g.program_id
JOIN faculties f
ON f.id = sp.fakulty_id
JOIN study_levels sl
ON sl.id = sp.level_id
WHERE sp.name like '%Business Information Management%'
AND MONTH(studied_until) = 6
AND DAY(studied_until) = 30
GROUP BY g.name
ORDER BY name ASC