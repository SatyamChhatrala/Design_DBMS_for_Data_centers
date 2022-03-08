--
-- PostgreSQL database dump
--

-- Dumped from database version 13.4
-- Dumped by pg_dump version 13.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: SV_DB; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA "SV_DB";


ALTER SCHEMA "SV_DB" OWNER TO postgres;

--
-- Name: Test_2021; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA "Test_2021";


ALTER SCHEMA "Test_2021" OWNER TO postgres;

--
-- Name: dbms_project1; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA dbms_project1;


ALTER SCHEMA dbms_project1 OWNER TO postgres;

--
-- Name: scm_db; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA scm_db;


ALTER SCHEMA scm_db OWNER TO postgres;

--
-- Name: Func_1(character varying); Type: FUNCTION; Schema: dbms_project1; Owner: postgres
--

CREATE FUNCTION dbms_project1."Func_1"(country character varying) RETURNS TABLE(ans character varying)
    LANGUAGE plpgsql
    AS $$
begin
return query select usernames from web_users where location= country;
end
$$;


ALTER FUNCTION dbms_project1."Func_1"(country character varying) OWNER TO postgres;

--
-- Name: Func_2(integer); Type: FUNCTION; Schema: dbms_project1; Owner: postgres
--

CREATE FUNCTION dbms_project1."Func_2"(num integer) RETURNS bigint
    LANGUAGE plpgsql
    AS $$
declare
allocated int;
used int;
begin
allocated:= (select storage_allocated from "dbms_project".Cloud_users where cloud_user_id=num);
used:=(select storage_used from "dbms_project".Cloud_users where cloud_user_id=num);
return allocated-used;
end
$$;


ALTER FUNCTION dbms_project1."Func_2"(num integer) OWNER TO postgres;

--
-- Name: Tfunc_1(); Type: FUNCTION; Schema: dbms_project1; Owner: postgres
--

CREATE FUNCTION dbms_project1."Tfunc_1"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare
a int;

begin

a:= (select active_clients from "dbms_project".server where service_id=new.service_id);
a:=a+1;

update "dbms_project".server
set active_clients=a
where service_id=new.service_id;
return new;
end
$$;


ALTER FUNCTION dbms_project1."Tfunc_1"() OWNER TO postgres;

--
-- Name: check_g_id(); Type: FUNCTION; Schema: scm_db; Owner: postgres
--

CREATE FUNCTION scm_db.check_g_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin

if exists(select 1 from "scm_db".ground_information where g_id = new.g_id)
then
RAISE NOTICE 'ID already exists';
return NULL;
else
RAISE NOTICE 'ID added successfully';
return new;
end if;
end;
$$;


ALTER FUNCTION scm_db.check_g_id() OWNER TO postgres;

--
-- Name: cricket_coach_details(); Type: FUNCTION; Schema: scm_db; Owner: postgres
--

CREATE FUNCTION scm_db.cricket_coach_details() RETURNS TABLE(n1 character varying, n2 integer)
    LANGUAGE plpgsql
    AS $$

begin
return query select c_name,salary from "scm_db".coach_details inner join "scm_db".sports_detail on sports_belong_to=s_id
where s_name='Cricket';
end;
$$;


ALTER FUNCTION scm_db.cricket_coach_details() OWNER TO postgres;

--
-- Name: display_names(integer); Type: FUNCTION; Schema: scm_db; Owner: postgres
--

CREATE FUNCTION scm_db.display_names(num integer) RETURNS TABLE(ans character varying)
    LANGUAGE plpgsql
    AS $$

begin
return query select p_name from "scm_db".player_detail where age = num ;
end;
$$;


ALTER FUNCTION scm_db.display_names(num integer) OWNER TO postgres;

--
-- Name: is_MID_NULL(); Type: FUNCTION; Schema: scm_db; Owner: postgres
--

CREATE FUNCTION scm_db."is_MID_NULL"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare
e_id bigint;

begin

e_id = new.m_id;
if(e_id is null) then
raise notice 'ID already exist';
return null;
else
return new;
end if;

end
$$;


ALTER FUNCTION scm_db."is_MID_NULL"() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: access_to; Type: TABLE; Schema: dbms_project1; Owner: postgres
--

CREATE TABLE dbms_project1.access_to (
    server_id integer NOT NULL,
    employee_id integer NOT NULL
);


ALTER TABLE dbms_project1.access_to OWNER TO postgres;

--
-- Name: charge; Type: TABLE; Schema: dbms_project1; Owner: postgres
--

CREATE TABLE dbms_project1.charge (
    price character varying NOT NULL,
    location character varying,
    service_id integer NOT NULL
);


ALTER TABLE dbms_project1.charge OWNER TO postgres;

--
-- Name: cloud_plan; Type: TABLE; Schema: dbms_project1; Owner: postgres
--

CREATE TABLE dbms_project1.cloud_plan (
    cloud_subscription_plan character varying NOT NULL,
    cloud_user_id integer NOT NULL
);


ALTER TABLE dbms_project1.cloud_plan OWNER TO postgres;

--
-- Name: cloud_users; Type: TABLE; Schema: dbms_project1; Owner: postgres
--

CREATE TABLE dbms_project1.cloud_users (
    cloud_user_id integer NOT NULL,
    username character varying,
    last_modified character varying,
    storage_allocated integer NOT NULL,
    storage_used integer NOT NULL,
    location character varying,
    service_id integer NOT NULL
);


ALTER TABLE dbms_project1.cloud_users OWNER TO postgres;

--
-- Name: department; Type: TABLE; Schema: dbms_project1; Owner: postgres
--

CREATE TABLE dbms_project1.department (
    department_id integer NOT NULL,
    name character varying,
    manager character varying,
    building character varying,
    employee_id integer NOT NULL
);


ALTER TABLE dbms_project1.department OWNER TO postgres;

--
-- Name: employee; Type: TABLE; Schema: dbms_project1; Owner: postgres
--

CREATE TABLE dbms_project1.employee (
    employee_id integer NOT NULL,
    f_name character varying,
    m_name character varying,
    l_name character varying,
    dob date,
    salary character varying,
    joining_date date,
    status character varying,
    gender character varying
);


ALTER TABLE dbms_project1.employee OWNER TO postgres;

--
-- Name: employee_contact_info; Type: TABLE; Schema: dbms_project1; Owner: postgres
--

CREATE TABLE dbms_project1.employee_contact_info (
    contact_info character varying NOT NULL,
    employee_id integer NOT NULL
);


ALTER TABLE dbms_project1.employee_contact_info OWNER TO postgres;

--
-- Name: hardware; Type: TABLE; Schema: dbms_project1; Owner: postgres
--

CREATE TABLE dbms_project1.hardware (
    hardware_id integer NOT NULL,
    date_of_purchase date,
    vendor character varying,
    storage_capacity integer NOT NULL,
    storage_type character varying,
    server_id integer
);


ALTER TABLE dbms_project1.hardware OWNER TO postgres;

--
-- Name: processor; Type: TABLE; Schema: dbms_project1; Owner: postgres
--

CREATE TABLE dbms_project1.processor (
    status character varying,
    speed character varying,
    processor_id integer NOT NULL,
    manufacturer character varying,
    memory integer NOT NULL
);


ALTER TABLE dbms_project1.processor OWNER TO postgres;

--
-- Name: repair; Type: TABLE; Schema: dbms_project1; Owner: postgres
--

CREATE TABLE dbms_project1.repair (
    repair_id integer NOT NULL,
    type character varying,
    start_date date,
    end_date date
);


ALTER TABLE dbms_project1.repair OWNER TO postgres;

--
-- Name: server; Type: TABLE; Schema: dbms_project1; Owner: postgres
--

CREATE TABLE dbms_project1.server (
    server_id integer NOT NULL,
    active_clients integer NOT NULL,
    status character varying,
    capacity integer NOT NULL,
    processor_id integer NOT NULL,
    service_id integer,
    repair_id integer NOT NULL
);


ALTER TABLE dbms_project1.server OWNER TO postgres;

--
-- Name: service; Type: TABLE; Schema: dbms_project1; Owner: postgres
--

CREATE TABLE dbms_project1.service (
    service_id integer NOT NULL,
    type character varying
);


ALTER TABLE dbms_project1.service OWNER TO postgres;

--
-- Name: software; Type: TABLE; Schema: dbms_project1; Owner: postgres
--

CREATE TABLE dbms_project1.software (
    memory integer NOT NULL,
    date_of_creation date,
    language_used character varying,
    software_id integer NOT NULL
);


ALTER TABLE dbms_project1.software OWNER TO postgres;

--
-- Name: software_update; Type: TABLE; Schema: dbms_project1; Owner: postgres
--

CREATE TABLE dbms_project1.software_update (
    memory integer NOT NULL,
    update_date date,
    update_id integer NOT NULL,
    software_id integer NOT NULL
);


ALTER TABLE dbms_project1.software_update OWNER TO postgres;

--
-- Name: softwareused; Type: TABLE; Schema: dbms_project1; Owner: postgres
--

CREATE TABLE dbms_project1.softwareused (
    software_id integer NOT NULL,
    server_id integer NOT NULL
);


ALTER TABLE dbms_project1.softwareused OWNER TO postgres;

--
-- Name: web_plan; Type: TABLE; Schema: dbms_project1; Owner: postgres
--

CREATE TABLE dbms_project1.web_plan (
    web_subscription_type character varying NOT NULL,
    web_user_id integer NOT NULL
);


ALTER TABLE dbms_project1.web_plan OWNER TO postgres;

--
-- Name: web_users; Type: TABLE; Schema: dbms_project1; Owner: postgres
--

CREATE TABLE dbms_project1.web_users (
    web_user_id integer NOT NULL,
    usernames character varying,
    last_active character varying,
    location character varying,
    service_id integer NOT NULL
);


ALTER TABLE dbms_project1.web_users OWNER TO postgres;

--
-- Name: access_to; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.access_to (
    server_id integer NOT NULL,
    employee_id integer NOT NULL
);


ALTER TABLE public.access_to OWNER TO postgres;

--
-- Name: charge; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.charge (
    price character varying NOT NULL,
    location character varying,
    service_id integer NOT NULL
);


ALTER TABLE public.charge OWNER TO postgres;

--
-- Name: cloud_plan; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cloud_plan (
    cloud_subscription_plan character varying NOT NULL,
    cloud_user_id integer NOT NULL
);


ALTER TABLE public.cloud_plan OWNER TO postgres;

--
-- Name: cloud_users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cloud_users (
    cloud_user_id integer NOT NULL,
    username character varying,
    last_modified character varying,
    storage_allocated integer NOT NULL,
    storage_used integer NOT NULL,
    location character varying,
    service_id integer NOT NULL
);


ALTER TABLE public.cloud_users OWNER TO postgres;

--
-- Name: department; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.department (
    department_id integer NOT NULL,
    name character varying,
    manager character varying,
    building character varying,
    employee_id integer NOT NULL
);


ALTER TABLE public.department OWNER TO postgres;

--
-- Name: department_info; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.department_info AS
 SELECT department.department_id,
    department.name,
    department.manager,
    department.building,
    department.employee_id
   FROM public.department
  WHERE ((department.building)::text = 'B1'::text);


ALTER TABLE public.department_info OWNER TO postgres;

--
-- Name: employee; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.employee (
    employee_id integer NOT NULL,
    f_name character varying,
    m_name character varying,
    l_name character varying,
    dob date,
    salary character varying,
    joining_date date,
    status character varying,
    gender character varying
);


ALTER TABLE public.employee OWNER TO postgres;

--
-- Name: employee_contact_info; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.employee_contact_info (
    contact_info character varying NOT NULL,
    employee_id integer NOT NULL
);


ALTER TABLE public.employee_contact_info OWNER TO postgres;

--
-- Name: employee_info; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.employee_info AS
 SELECT employee.f_name,
    employee.l_name,
    employee.salary,
    employee.joining_date,
    employee.gender
   FROM public.employee;


ALTER TABLE public.employee_info OWNER TO postgres;

--
-- Name: hardware; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hardware (
    hardware_id integer NOT NULL,
    date_of_purchase date,
    vendor character varying,
    storage_capacity integer NOT NULL,
    storage_type character varying,
    server_id integer
);


ALTER TABLE public.hardware OWNER TO postgres;

--
-- Name: processor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.processor (
    status character varying,
    speed character varying,
    processor_id integer NOT NULL,
    manufacturer character varying,
    memory integer NOT NULL
);


ALTER TABLE public.processor OWNER TO postgres;

--
-- Name: repair; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.repair (
    repair_id integer NOT NULL,
    type character varying,
    start_date date,
    end_date date
);


ALTER TABLE public.repair OWNER TO postgres;

--
-- Name: server; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.server (
    server_id integer NOT NULL,
    active_clients integer NOT NULL,
    status character varying,
    capacity integer NOT NULL,
    processor_id integer NOT NULL,
    service_id integer,
    repair_id integer NOT NULL
);


ALTER TABLE public.server OWNER TO postgres;

--
-- Name: service; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.service (
    service_id integer NOT NULL,
    type character varying
);


ALTER TABLE public.service OWNER TO postgres;

--
-- Name: software; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.software (
    memory integer NOT NULL,
    date_of_creation date,
    language_used character varying,
    software_id integer NOT NULL
);


ALTER TABLE public.software OWNER TO postgres;

--
-- Name: software_update; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.software_update (
    memory integer NOT NULL,
    update_date date,
    update_id integer NOT NULL,
    software_id integer NOT NULL
);


ALTER TABLE public.software_update OWNER TO postgres;

--
-- Name: softwareused; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.softwareused (
    software_id integer NOT NULL,
    server_id integer NOT NULL
);


ALTER TABLE public.softwareused OWNER TO postgres;

--
-- Name: web_plan; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.web_plan (
    web_subscription_type character varying NOT NULL,
    web_user_id integer NOT NULL
);


ALTER TABLE public.web_plan OWNER TO postgres;

--
-- Name: web_users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.web_users (
    web_user_id integer NOT NULL,
    usernames character varying,
    last_active character varying,
    location character varying,
    service_id integer NOT NULL
);


ALTER TABLE public.web_users OWNER TO postgres;

--
-- Name: coach_details; Type: TABLE; Schema: scm_db; Owner: postgres
--

CREATE TABLE scm_db.coach_details (
    c_id integer NOT NULL,
    c_name character varying,
    contact_no numeric(10,0),
    c_age integer,
    c_address character varying,
    salary integer,
    sports_belong_to integer,
    experience integer
);


ALTER TABLE scm_db.coach_details OWNER TO postgres;

--
-- Name: ground_information; Type: TABLE; Schema: scm_db; Owner: postgres
--

CREATE TABLE scm_db.ground_information (
    g_id integer NOT NULL,
    category character varying,
    sport_to_belong integer,
    ground_area integer,
    audience_capacity integer
);


ALTER TABLE scm_db.ground_information OWNER TO postgres;

--
-- Name: membership; Type: TABLE; Schema: scm_db; Owner: postgres
--

CREATE TABLE scm_db.membership (
    m_id integer NOT NULL,
    m_name character varying,
    m_time integer,
    m_amount integer
);


ALTER TABLE scm_db.membership OWNER TO postgres;

--
-- Name: player_detail; Type: TABLE; Schema: scm_db; Owner: postgres
--

CREATE TABLE scm_db.player_detail (
    p_id integer NOT NULL,
    p_name character varying,
    contact_no numeric(10,0),
    age integer,
    address character varying,
    m_joindate date,
    m_lastdate date,
    membership_to_belong integer,
    sports_to_belong integer
);


ALTER TABLE scm_db.player_detail OWNER TO postgres;

--
-- Name: sports_detail; Type: TABLE; Schema: scm_db; Owner: postgres
--

CREATE TABLE scm_db.sports_detail (
    s_id integer NOT NULL,
    s_name character varying,
    no_of_coach integer,
    equipment_availability character varying
);


ALTER TABLE scm_db.sports_detail OWNER TO postgres;

--
-- Name: v1; Type: VIEW; Schema: scm_db; Owner: postgres
--

CREATE VIEW scm_db.v1 AS
 SELECT coach_details.c_name,
    coach_details.sports_belong_to
   FROM scm_db.coach_details
  WHERE (((coach_details.c_address)::text ~~ '%a%'::text) AND (coach_details.experience <= 10));


ALTER TABLE scm_db.v1 OWNER TO postgres;

--
-- Name: v2; Type: VIEW; Schema: scm_db; Owner: postgres
--

CREATE VIEW scm_db.v2 AS
 SELECT sports_detail.s_name,
    sports_detail.s_id
   FROM scm_db.sports_detail
  WHERE ((sports_detail.no_of_coach = 2) AND ((sports_detail.equipment_availability)::text = 'Yes'::text));


ALTER TABLE scm_db.v2 OWNER TO postgres;

--
-- Name: access_to access_to_pkey; Type: CONSTRAINT; Schema: dbms_project1; Owner: postgres
--

ALTER TABLE ONLY dbms_project1.access_to
    ADD CONSTRAINT access_to_pkey PRIMARY KEY (server_id, employee_id);


--
-- Name: charge charge_pkey; Type: CONSTRAINT; Schema: dbms_project1; Owner: postgres
--

ALTER TABLE ONLY dbms_project1.charge
    ADD CONSTRAINT charge_pkey PRIMARY KEY (price, service_id);


--
-- Name: cloud_plan cloud_plan_pkey; Type: CONSTRAINT; Schema: dbms_project1; Owner: postgres
--

ALTER TABLE ONLY dbms_project1.cloud_plan
    ADD CONSTRAINT cloud_plan_pkey PRIMARY KEY (cloud_subscription_plan, cloud_user_id);


--
-- Name: cloud_users cloud_users_pkey; Type: CONSTRAINT; Schema: dbms_project1; Owner: postgres
--

ALTER TABLE ONLY dbms_project1.cloud_users
    ADD CONSTRAINT cloud_users_pkey PRIMARY KEY (cloud_user_id);


--
-- Name: department department_pkey; Type: CONSTRAINT; Schema: dbms_project1; Owner: postgres
--

ALTER TABLE ONLY dbms_project1.department
    ADD CONSTRAINT department_pkey PRIMARY KEY (department_id);


--
-- Name: employee_contact_info employee_contact_info_pkey; Type: CONSTRAINT; Schema: dbms_project1; Owner: postgres
--

ALTER TABLE ONLY dbms_project1.employee_contact_info
    ADD CONSTRAINT employee_contact_info_pkey PRIMARY KEY (contact_info, employee_id);


--
-- Name: employee employee_pkey; Type: CONSTRAINT; Schema: dbms_project1; Owner: postgres
--

ALTER TABLE ONLY dbms_project1.employee
    ADD CONSTRAINT employee_pkey PRIMARY KEY (employee_id);


--
-- Name: hardware hardware_pkey; Type: CONSTRAINT; Schema: dbms_project1; Owner: postgres
--

ALTER TABLE ONLY dbms_project1.hardware
    ADD CONSTRAINT hardware_pkey PRIMARY KEY (hardware_id);


--
-- Name: processor processor_pkey; Type: CONSTRAINT; Schema: dbms_project1; Owner: postgres
--

ALTER TABLE ONLY dbms_project1.processor
    ADD CONSTRAINT processor_pkey PRIMARY KEY (processor_id);


--
-- Name: repair repair_pkey; Type: CONSTRAINT; Schema: dbms_project1; Owner: postgres
--

ALTER TABLE ONLY dbms_project1.repair
    ADD CONSTRAINT repair_pkey PRIMARY KEY (repair_id);


--
-- Name: server server_pkey; Type: CONSTRAINT; Schema: dbms_project1; Owner: postgres
--

ALTER TABLE ONLY dbms_project1.server
    ADD CONSTRAINT server_pkey PRIMARY KEY (server_id);


--
-- Name: service service_pkey; Type: CONSTRAINT; Schema: dbms_project1; Owner: postgres
--

ALTER TABLE ONLY dbms_project1.service
    ADD CONSTRAINT service_pkey PRIMARY KEY (service_id);


--
-- Name: software software_pkey; Type: CONSTRAINT; Schema: dbms_project1; Owner: postgres
--

ALTER TABLE ONLY dbms_project1.software
    ADD CONSTRAINT software_pkey PRIMARY KEY (software_id);


--
-- Name: software_update software_update_pkey; Type: CONSTRAINT; Schema: dbms_project1; Owner: postgres
--

ALTER TABLE ONLY dbms_project1.software_update
    ADD CONSTRAINT software_update_pkey PRIMARY KEY (update_id);


--
-- Name: softwareused softwareused_pkey; Type: CONSTRAINT; Schema: dbms_project1; Owner: postgres
--

ALTER TABLE ONLY dbms_project1.softwareused
    ADD CONSTRAINT softwareused_pkey PRIMARY KEY (software_id, server_id);


--
-- Name: web_plan web_plan_pkey; Type: CONSTRAINT; Schema: dbms_project1; Owner: postgres
--

ALTER TABLE ONLY dbms_project1.web_plan
    ADD CONSTRAINT web_plan_pkey PRIMARY KEY (web_subscription_type, web_user_id);


--
-- Name: web_users web_users_pkey; Type: CONSTRAINT; Schema: dbms_project1; Owner: postgres
--

ALTER TABLE ONLY dbms_project1.web_users
    ADD CONSTRAINT web_users_pkey PRIMARY KEY (web_user_id);


--
-- Name: access_to access_to_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.access_to
    ADD CONSTRAINT access_to_pkey PRIMARY KEY (server_id, employee_id);


--
-- Name: charge charge_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.charge
    ADD CONSTRAINT charge_pkey PRIMARY KEY (price, service_id);


--
-- Name: cloud_plan cloud_plan_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cloud_plan
    ADD CONSTRAINT cloud_plan_pkey PRIMARY KEY (cloud_subscription_plan, cloud_user_id);


--
-- Name: cloud_users cloud_users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cloud_users
    ADD CONSTRAINT cloud_users_pkey PRIMARY KEY (cloud_user_id);


--
-- Name: department department_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department
    ADD CONSTRAINT department_pkey PRIMARY KEY (department_id);


--
-- Name: employee_contact_info employee_contact_info_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee_contact_info
    ADD CONSTRAINT employee_contact_info_pkey PRIMARY KEY (contact_info, employee_id);


--
-- Name: employee employee_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee
    ADD CONSTRAINT employee_pkey PRIMARY KEY (employee_id);


--
-- Name: hardware hardware_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hardware
    ADD CONSTRAINT hardware_pkey PRIMARY KEY (hardware_id);


--
-- Name: processor processor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.processor
    ADD CONSTRAINT processor_pkey PRIMARY KEY (processor_id);


--
-- Name: repair repair_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.repair
    ADD CONSTRAINT repair_pkey PRIMARY KEY (repair_id);


--
-- Name: server server_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.server
    ADD CONSTRAINT server_pkey PRIMARY KEY (server_id);


--
-- Name: service service_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.service
    ADD CONSTRAINT service_pkey PRIMARY KEY (service_id);


--
-- Name: software software_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.software
    ADD CONSTRAINT software_pkey PRIMARY KEY (software_id);


--
-- Name: software_update software_update_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.software_update
    ADD CONSTRAINT software_update_pkey PRIMARY KEY (update_id);


--
-- Name: softwareused softwareused_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.softwareused
    ADD CONSTRAINT softwareused_pkey PRIMARY KEY (software_id, server_id);


--
-- Name: web_plan web_plan_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_plan
    ADD CONSTRAINT web_plan_pkey PRIMARY KEY (web_subscription_type, web_user_id);


--
-- Name: web_users web_users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_users
    ADD CONSTRAINT web_users_pkey PRIMARY KEY (web_user_id);


--
-- Name: coach_details coach_details_pkey; Type: CONSTRAINT; Schema: scm_db; Owner: postgres
--

ALTER TABLE ONLY scm_db.coach_details
    ADD CONSTRAINT coach_details_pkey PRIMARY KEY (c_id);


--
-- Name: ground_information ground_information_pkey; Type: CONSTRAINT; Schema: scm_db; Owner: postgres
--

ALTER TABLE ONLY scm_db.ground_information
    ADD CONSTRAINT ground_information_pkey PRIMARY KEY (g_id);


--
-- Name: membership membership_pkey; Type: CONSTRAINT; Schema: scm_db; Owner: postgres
--

ALTER TABLE ONLY scm_db.membership
    ADD CONSTRAINT membership_pkey PRIMARY KEY (m_id);


--
-- Name: player_detail player_detail_pkey; Type: CONSTRAINT; Schema: scm_db; Owner: postgres
--

ALTER TABLE ONLY scm_db.player_detail
    ADD CONSTRAINT player_detail_pkey PRIMARY KEY (p_id);


--
-- Name: sports_detail sports_detail_pkey; Type: CONSTRAINT; Schema: scm_db; Owner: postgres
--

ALTER TABLE ONLY scm_db.sports_detail
    ADD CONSTRAINT sports_detail_pkey PRIMARY KEY (s_id);


--
-- Name: cloud_users Tfunc_1; Type: TRIGGER; Schema: dbms_project1; Owner: postgres
--

CREATE TRIGGER "Tfunc_1" AFTER INSERT ON dbms_project1.cloud_users FOR EACH ROW EXECUTE FUNCTION dbms_project1."Tfunc_1"();


--
-- Name: ground_information trig_1; Type: TRIGGER; Schema: scm_db; Owner: postgres
--

CREATE TRIGGER trig_1 BEFORE INSERT ON scm_db.ground_information FOR EACH ROW EXECUTE FUNCTION scm_db.check_g_id();


--
-- Name: membership trig_2; Type: TRIGGER; Schema: scm_db; Owner: postgres
--

CREATE TRIGGER trig_2 BEFORE INSERT ON scm_db.membership FOR EACH ROW EXECUTE FUNCTION scm_db."is_MID_NULL"();


--
-- Name: access_to access_to_employee_id_fkey; Type: FK CONSTRAINT; Schema: dbms_project1; Owner: postgres
--

ALTER TABLE ONLY dbms_project1.access_to
    ADD CONSTRAINT access_to_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES dbms_project1.employee(employee_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: access_to access_to_server_id_fkey; Type: FK CONSTRAINT; Schema: dbms_project1; Owner: postgres
--

ALTER TABLE ONLY dbms_project1.access_to
    ADD CONSTRAINT access_to_server_id_fkey FOREIGN KEY (server_id) REFERENCES dbms_project1.server(server_id);


--
-- Name: charge charge_service_id_fkey; Type: FK CONSTRAINT; Schema: dbms_project1; Owner: postgres
--

ALTER TABLE ONLY dbms_project1.charge
    ADD CONSTRAINT charge_service_id_fkey FOREIGN KEY (service_id) REFERENCES dbms_project1.service(service_id);


--
-- Name: cloud_plan cloud_plan_cloud_user_id_fkey; Type: FK CONSTRAINT; Schema: dbms_project1; Owner: postgres
--

ALTER TABLE ONLY dbms_project1.cloud_plan
    ADD CONSTRAINT cloud_plan_cloud_user_id_fkey FOREIGN KEY (cloud_user_id) REFERENCES dbms_project1.cloud_users(cloud_user_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: cloud_users cloud_users_service_id_fkey; Type: FK CONSTRAINT; Schema: dbms_project1; Owner: postgres
--

ALTER TABLE ONLY dbms_project1.cloud_users
    ADD CONSTRAINT cloud_users_service_id_fkey FOREIGN KEY (service_id) REFERENCES dbms_project1.service(service_id);


--
-- Name: department department_employee_id_fkey; Type: FK CONSTRAINT; Schema: dbms_project1; Owner: postgres
--

ALTER TABLE ONLY dbms_project1.department
    ADD CONSTRAINT department_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES dbms_project1.employee(employee_id);


--
-- Name: employee_contact_info employee_contact_info_employee_id_fkey; Type: FK CONSTRAINT; Schema: dbms_project1; Owner: postgres
--

ALTER TABLE ONLY dbms_project1.employee_contact_info
    ADD CONSTRAINT employee_contact_info_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES dbms_project1.employee(employee_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: hardware hardware_server_id_fkey; Type: FK CONSTRAINT; Schema: dbms_project1; Owner: postgres
--

ALTER TABLE ONLY dbms_project1.hardware
    ADD CONSTRAINT hardware_server_id_fkey FOREIGN KEY (server_id) REFERENCES dbms_project1.server(server_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: server server_processor_id_fkey; Type: FK CONSTRAINT; Schema: dbms_project1; Owner: postgres
--

ALTER TABLE ONLY dbms_project1.server
    ADD CONSTRAINT server_processor_id_fkey FOREIGN KEY (processor_id) REFERENCES dbms_project1.processor(processor_id);


--
-- Name: server server_repair_id_fkey; Type: FK CONSTRAINT; Schema: dbms_project1; Owner: postgres
--

ALTER TABLE ONLY dbms_project1.server
    ADD CONSTRAINT server_repair_id_fkey FOREIGN KEY (repair_id) REFERENCES dbms_project1.repair(repair_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: server server_service_id_fkey; Type: FK CONSTRAINT; Schema: dbms_project1; Owner: postgres
--

ALTER TABLE ONLY dbms_project1.server
    ADD CONSTRAINT server_service_id_fkey FOREIGN KEY (service_id) REFERENCES dbms_project1.service(service_id);


--
-- Name: software_update software_update_software_id_fkey; Type: FK CONSTRAINT; Schema: dbms_project1; Owner: postgres
--

ALTER TABLE ONLY dbms_project1.software_update
    ADD CONSTRAINT software_update_software_id_fkey FOREIGN KEY (software_id) REFERENCES dbms_project1.software(software_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: softwareused softwareused_server_id_fkey; Type: FK CONSTRAINT; Schema: dbms_project1; Owner: postgres
--

ALTER TABLE ONLY dbms_project1.softwareused
    ADD CONSTRAINT softwareused_server_id_fkey FOREIGN KEY (server_id) REFERENCES dbms_project1.server(server_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: softwareused softwareused_software_id_fkey; Type: FK CONSTRAINT; Schema: dbms_project1; Owner: postgres
--

ALTER TABLE ONLY dbms_project1.softwareused
    ADD CONSTRAINT softwareused_software_id_fkey FOREIGN KEY (software_id) REFERENCES dbms_project1.software(software_id);


--
-- Name: web_plan web_plan_web_user_id_fkey; Type: FK CONSTRAINT; Schema: dbms_project1; Owner: postgres
--

ALTER TABLE ONLY dbms_project1.web_plan
    ADD CONSTRAINT web_plan_web_user_id_fkey FOREIGN KEY (web_user_id) REFERENCES dbms_project1.web_users(web_user_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: web_users web_users_service_id_fkey; Type: FK CONSTRAINT; Schema: dbms_project1; Owner: postgres
--

ALTER TABLE ONLY dbms_project1.web_users
    ADD CONSTRAINT web_users_service_id_fkey FOREIGN KEY (service_id) REFERENCES dbms_project1.service(service_id);


--
-- Name: access_to access_to_employee_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.access_to
    ADD CONSTRAINT access_to_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES public.employee(employee_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: access_to access_to_server_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.access_to
    ADD CONSTRAINT access_to_server_id_fkey FOREIGN KEY (server_id) REFERENCES public.server(server_id);


--
-- Name: charge charge_service_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.charge
    ADD CONSTRAINT charge_service_id_fkey FOREIGN KEY (service_id) REFERENCES public.service(service_id);


--
-- Name: cloud_plan cloud_plan_cloud_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cloud_plan
    ADD CONSTRAINT cloud_plan_cloud_user_id_fkey FOREIGN KEY (cloud_user_id) REFERENCES public.cloud_users(cloud_user_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: cloud_users cloud_users_service_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cloud_users
    ADD CONSTRAINT cloud_users_service_id_fkey FOREIGN KEY (service_id) REFERENCES public.service(service_id);


--
-- Name: department department_employee_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department
    ADD CONSTRAINT department_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES public.employee(employee_id);


--
-- Name: employee_contact_info employee_contact_info_employee_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee_contact_info
    ADD CONSTRAINT employee_contact_info_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES public.employee(employee_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: hardware hardware_server_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hardware
    ADD CONSTRAINT hardware_server_id_fkey FOREIGN KEY (server_id) REFERENCES public.server(server_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: server server_processor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.server
    ADD CONSTRAINT server_processor_id_fkey FOREIGN KEY (processor_id) REFERENCES public.processor(processor_id);


--
-- Name: server server_repair_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.server
    ADD CONSTRAINT server_repair_id_fkey FOREIGN KEY (repair_id) REFERENCES public.repair(repair_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: server server_service_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.server
    ADD CONSTRAINT server_service_id_fkey FOREIGN KEY (service_id) REFERENCES public.service(service_id);


--
-- Name: software_update software_update_software_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.software_update
    ADD CONSTRAINT software_update_software_id_fkey FOREIGN KEY (software_id) REFERENCES public.software(software_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: softwareused softwareused_server_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.softwareused
    ADD CONSTRAINT softwareused_server_id_fkey FOREIGN KEY (server_id) REFERENCES public.server(server_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: softwareused softwareused_software_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.softwareused
    ADD CONSTRAINT softwareused_software_id_fkey FOREIGN KEY (software_id) REFERENCES public.software(software_id);


--
-- Name: web_plan web_plan_web_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_plan
    ADD CONSTRAINT web_plan_web_user_id_fkey FOREIGN KEY (web_user_id) REFERENCES public.web_users(web_user_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: web_users web_users_service_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_users
    ADD CONSTRAINT web_users_service_id_fkey FOREIGN KEY (service_id) REFERENCES public.service(service_id);


--
-- Name: player_detail player_detail_membership_to_belong_fkey; Type: FK CONSTRAINT; Schema: scm_db; Owner: postgres
--

ALTER TABLE ONLY scm_db.player_detail
    ADD CONSTRAINT player_detail_membership_to_belong_fkey FOREIGN KEY (membership_to_belong) REFERENCES scm_db.membership(m_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: ground_information sport_to_belong; Type: FK CONSTRAINT; Schema: scm_db; Owner: postgres
--

ALTER TABLE ONLY scm_db.ground_information
    ADD CONSTRAINT sport_to_belong FOREIGN KEY (sport_to_belong) REFERENCES scm_db.sports_detail(s_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: coach_details sports_belong_to; Type: FK CONSTRAINT; Schema: scm_db; Owner: postgres
--

ALTER TABLE ONLY scm_db.coach_details
    ADD CONSTRAINT sports_belong_to FOREIGN KEY (sports_belong_to) REFERENCES scm_db.sports_detail(s_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: player_detail sports_to_belong; Type: FK CONSTRAINT; Schema: scm_db; Owner: postgres
--

ALTER TABLE ONLY scm_db.player_detail
    ADD CONSTRAINT sports_to_belong FOREIGN KEY (sports_to_belong) REFERENCES scm_db.sports_detail(s_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

