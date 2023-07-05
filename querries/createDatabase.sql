-- Table: public.employees

-- DROP TABLE IF EXISTS public.employees;

CREATE TABLE IF NOT EXISTS public.employees
(
    employee_id integer NOT NULL DEFAULT nextval('employees_employee_id_seq'::regclass),
    first_name character varying(50) COLLATE pg_catalog."default",
    last_name character varying(50) COLLATE pg_catalog."default",
    hire_date date,
    hourly_salary numeric,
    title_id integer,
    manager_id integer,
    team character varying(50) COLLATE pg_catalog."default",
    CONSTRAINT employees_pkey PRIMARY KEY (employee_id),
    CONSTRAINT fk_employees_manager FOREIGN KEY (manager_id)
        REFERENCES public.employees (employee_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_employees_team FOREIGN KEY (team)
        REFERENCES public.teams (team_name) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_employees_title FOREIGN KEY (title_id)
        REFERENCES public.titles (title_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.employees
    OWNER to postgres;

-- Table: public.hours_tracking

-- DROP TABLE IF EXISTS public.hours_tracking;

CREATE TABLE IF NOT EXISTS public.hours_tracking
(
    employee_id integer,
    project_id integer,
    total_hours integer,
    CONSTRAINT hours_tracking_employee_id_fkey FOREIGN KEY (employee_id)
        REFERENCES public.employees (employee_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT hours_tracking_project_id_fkey FOREIGN KEY (project_id)
        REFERENCES public.projects (project_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.hours_tracking
    OWNER to postgres;  

-- Table: public.hours_tracking

-- DROP TABLE IF EXISTS public.hours_tracking;

CREATE TABLE IF NOT EXISTS public.hours_tracking
(
    employee_id integer,
    project_id integer,
    total_hours integer,
    CONSTRAINT hours_tracking_employee_id_fkey FOREIGN KEY (employee_id)
        REFERENCES public.employees (employee_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT hours_tracking_project_id_fkey FOREIGN KEY (project_id)
        REFERENCES public.projects (project_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.hours_tracking
    OWNER to postgres;

-- Table: public.projects

-- DROP TABLE IF EXISTS public.projects;

CREATE TABLE IF NOT EXISTS public.projects
(
    project_id integer NOT NULL DEFAULT nextval('projects_project_id_seq'::regclass),
    name character varying(50) COLLATE pg_catalog."default",
    client character varying(50) COLLATE pg_catalog."default",
    start_date date,
    deadline date,
    CONSTRAINT projects_pkey PRIMARY KEY (project_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.projects
    OWNER to postgres;


-- Table: public.team_project

-- DROP TABLE IF EXISTS public.team_project;

CREATE TABLE IF NOT EXISTS public.team_project
(
    team_id integer,
    project_id integer,
    CONSTRAINT team_project_project_id_fkey FOREIGN KEY (project_id)
        REFERENCES public.projects (project_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT team_project_team_id_fkey FOREIGN KEY (team_id)
        REFERENCES public.teams (team_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.team_project
    OWNER to postgres;


-- Table: public.teams

-- DROP TABLE IF EXISTS public.teams;

CREATE TABLE IF NOT EXISTS public.teams
(
    team_id integer NOT NULL DEFAULT nextval('teams_team_id_seq'::regclass),
    team_name character varying(50) COLLATE pg_catalog."default",
    location character varying(50) COLLATE pg_catalog."default",
    CONSTRAINT teams_pkey PRIMARY KEY (team_id),
    CONSTRAINT unique_team_name UNIQUE (team_name)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.teams
    OWNER to postgres;


-- Table: public.titles

-- DROP TABLE IF EXISTS public.titles;

CREATE TABLE IF NOT EXISTS public.titles
(
    title_id integer NOT NULL DEFAULT nextval('titles_title_id_seq'::regclass),
    name character varying(50) COLLATE pg_catalog."default",
    CONSTRAINT titles_pkey PRIMARY KEY (title_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.titles
    OWNER to postgres;