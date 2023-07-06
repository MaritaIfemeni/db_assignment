-- - Create a function `track_working_hours(employee_id, project_id, total_hours)` to insert data into the hour_tracking table to track the working hours for each employee on specific projects. Make sure that data need to be validated before the insertion. Test this function

-- SELECT track_working_hours(20, 7, 40.5);
-- SELECT track_working_hours(23, 7, 32.25);
-- SELECT track_working_hours(12, 7, 22.75);
-- -- and so on...

-- Create the function track_working_hours
CREATE OR REPLACE FUNCTION track_working_hours(
  p_employee_id INTEGER,
  p_project_id INTEGER,
  p_total_hours NUMERIC
)
RETURNS VOID AS
$$
BEGIN
  -- Validate the employee_id and project_id
  IF NOT EXISTS (SELECT 1 FROM employees WHERE employee_id = p_employee_id) THEN
    RAISE EXCEPTION 'Invalid employee_id: %', p_employee_id;
  END IF;
  IF NOT EXISTS (SELECT 1 FROM projects WHERE project_id = p_project_id) THEN
    RAISE EXCEPTION 'Invalid project_id: %', p_project_id;
  END IF;
  -- Insert the working hours into the hours_tracking table
  INSERT INTO hours_tracking (employee_id, project_id, total_hours)
  VALUES (p_employee_id, p_project_id, p_total_hours);
  -- Print a success message
  RAISE NOTICE 'Working hours inserted successfully: employee_id=%, project_id=%, total_hours=%', p_employee_id, p_project_id, p_total_hours;
END;
$$
LANGUAGE plpgsql;


-- - Create a function `create_project_with_teams` to create a project and assign teams to that project simultaneously. Test this function
-- ```
-- SELECT create_project_with_teams(
--     'New Project',
--     'Client XYZ',
--     '2023-07-01',
--     '2023-12-31',
--     ARRAY[1, 2, 3]
-- );
-- ```

-- Create the function create_project_with_teams
CREATE OR REPLACE FUNCTION create_project_with_teams(
  p_name VARCHAR,
  p_client VARCHAR,
  p_start_date DATE,
  p_deadline DATE,
  p_team_ids INTEGER[]
)
RETURNS VOID AS
$$
DECLARE
  v_project_id INTEGER;
  v_team_id INTEGER;
BEGIN
  -- Create the project
  INSERT INTO projects (name, client, start_date, deadline)
  VALUES (p_name, p_client, p_start_date, p_deadline)
  RETURNING project_id INTO v_project_id;
  -- Assign teams to the project
  FOREACH v_team_id IN ARRAY p_team_ids
  LOOP
    INSERT INTO team_project (team_id, project_id)
    VALUES (v_team_id, v_project_id);
  END LOOP;
  -- Print a success message
  RAISE NOTICE 'Project created with teams successfully: project_id=%, name=%', v_project_id, p_name;
END;
$$
LANGUAGE plpgsql;
