-- Retrieve the team names and their corresponding project count.
SELECT t.team_name, COUNT(tp.project_id) AS project_count
FROM teams t
LEFT JOIN team_project tp ON t.team_id = tp.team_id
GROUP BY t.team_name;

-- Retrieve the projects managed by the managers whose first name starts with "J" or "D".

SELECT DISTINCT ON (p.project_id) p.project_id, p.name, t.team_name, e.first_name AS manager_first_name, e.last_name AS manager_last_name
FROM projects p
JOIN team_project tp ON p.project_id = tp.project_id
JOIN teams t ON tp.team_id = t.team_id
JOIN employees e ON t.team_id = e.team
WHERE e.title_id = 2 AND (e.first_name LIKE 'J%' OR e.first_name LIKE 'D%')
ORDER BY p.project_id;

-- Retrieve all the employees (both directly and indirectly) working under Andrew Martin

WITH RECURSIVE employee_hierarchy AS (
  SELECT e.employee_id, e.first_name, e.last_name, e.manager_id
  FROM employees e
  WHERE e.employee_id IN (
    SELECT employee_id
    FROM employees
    WHERE first_name = 'Andrew' AND last_name = 'Martin'
  )
  UNION
  SELECT e.employee_id, e.first_name, e.last_name, e.manager_id
  FROM employees e
  JOIN employee_hierarchy eh ON e.manager_id = eh.employee_id
)
SELECT *
FROM employee_hierarchy
WHERE employee_id <> (
  SELECT employee_id
  FROM employees
  WHERE first_name = 'Robert' AND last_name = 'Brown'
);

-- Retrieve all the employees (both directly and indirectly) working under Robert Brown

WITH RECURSIVE employee_hierarchy AS (
  SELECT e.employee_id, e.first_name, e.last_name, e.manager_id
  FROM employees e
  WHERE e.employee_id IN (
    SELECT employee_id
    FROM employees
    WHERE first_name = 'Robert' AND last_name = 'Brown'
  )
  UNION
  SELECT e.employee_id, e.first_name, e.last_name, e.manager_id
  FROM employees e
  JOIN employee_hierarchy eh ON e.manager_id = eh.employee_id
)
SELECT *
FROM employee_hierarchy
WHERE employee_id <> (
  SELECT employee_id
  FROM employees
  WHERE first_name = 'Robert' AND last_name = 'Brown'
);

-- Retrieve the average hourly salary for each title.

SELECT title_id, AVG(hourly_salary) AS average_hourly_salary
FROM employees
GROUP BY title_id;

--- Retrieve the employees who have a higher hourly salary than their respective team's average hourly salary.