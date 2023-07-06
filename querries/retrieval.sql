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
