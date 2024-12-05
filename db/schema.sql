--
-- PostgreSQL database dump
--

-- Dumped from database version 17.0
-- Dumped by pg_dump version 17.0

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: coach_achievements; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.coach_achievements (
    name character varying(255) NOT NULL,
    coach_id bigint NOT NULL,
    ach_image text
);


ALTER TABLE public.coach_achievements OWNER TO postgres;

--
-- Name: coaches; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.coaches (
    coach_id integer NOT NULL,
    team_id bigint NOT NULL,
    name character varying(100) NOT NULL,
    nationality character varying(100) NOT NULL,
    coach_img text
);


ALTER TABLE public.coaches OWNER TO postgres;

--
-- Name: coaches_coach_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.coaches_coach_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.coaches_coach_id_seq OWNER TO postgres;

--
-- Name: coaches_coach_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.coaches_coach_id_seq OWNED BY public.coaches.coach_id;


--
-- Name: matches; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.matches (
    match_id integer NOT NULL,
    referee_id bigint NOT NULL,
    home_team_id bigint NOT NULL,
    away_team_id bigint NOT NULL,
    home_team_goals smallint DEFAULT 0,
    away_team_goals smallint DEFAULT 0,
    season character varying(20) NOT NULL,
    match_date date NOT NULL,
    status character varying(10) DEFAULT 'Pending'::character varying,
    CONSTRAINT matches_away_team_goals_check CHECK ((away_team_goals >= 0)),
    CONSTRAINT matches_check CHECK ((home_team_id <> away_team_id)),
    CONSTRAINT matches_home_team_goals_check CHECK ((home_team_goals >= 0)),
    CONSTRAINT matches_status_check CHECK (((status)::text = ANY ((ARRAY['Finished'::character varying, 'Pending'::character varying])::text[])))
);


ALTER TABLE public.matches OWNER TO postgres;

--
-- Name: matches_match_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.matches_match_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.matches_match_id_seq OWNER TO postgres;

--
-- Name: matches_match_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.matches_match_id_seq OWNED BY public.matches.match_id;


--
-- Name: player_achievements; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.player_achievements (
    name character varying(100) NOT NULL,
    player_id bigint NOT NULL,
    ach_image text
);


ALTER TABLE public.player_achievements OWNER TO postgres;

--
-- Name: player_match_performance; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.player_match_performance (
    match_id bigint NOT NULL,
    player_id bigint NOT NULL,
    rating numeric(3,1) DEFAULT 0,
    minutes_played smallint DEFAULT 0,
    goals smallint DEFAULT 0,
    assists smallint DEFAULT 0,
    yellow_cards smallint DEFAULT 0,
    red_cards boolean DEFAULT false,
    shots_on_target smallint DEFAULT 0,
    passes_completed smallint DEFAULT 0,
    CONSTRAINT player_match_performance_assists_check CHECK ((assists >= 0)),
    CONSTRAINT player_match_performance_goals_check CHECK ((goals >= 0)),
    CONSTRAINT player_match_performance_minutes_played_check CHECK (((minutes_played >= 0) AND (minutes_played <= 150))),
    CONSTRAINT player_match_performance_passes_completed_check CHECK ((passes_completed >= 0)),
    CONSTRAINT player_match_performance_rating_check CHECK (((rating >= (0)::numeric) AND (rating <= (10)::numeric))),
    CONSTRAINT player_match_performance_shots_on_target_check CHECK ((shots_on_target >= 0)),
    CONSTRAINT player_match_performance_yellow_cards_check CHECK (((yellow_cards >= 0) AND (yellow_cards < 3)))
);


ALTER TABLE public.player_match_performance OWNER TO postgres;

--
-- Name: players; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.players (
    player_id integer NOT NULL,
    team_id bigint NOT NULL,
    name character varying(100) NOT NULL,
    salary double precision DEFAULT 0,
    nationality character varying(100) NOT NULL,
    "position" character varying(3) NOT NULL,
    shirt_number smallint NOT NULL,
    player_img text,
    CONSTRAINT players_position_check CHECK ((("position")::text = ANY ((ARRAY['GK'::character varying, 'CB'::character varying, 'LB'::character varying, 'RB'::character varying, 'LWB'::character varying, 'RWB'::character varying, 'SW'::character varying, 'CM'::character varying, 'DM'::character varying, 'AM'::character varying, 'LM'::character varying, 'RM'::character varying, 'ST'::character varying, 'CF'::character varying, 'SS'::character varying, 'WG'::character varying])::text[])))
);


ALTER TABLE public.players OWNER TO postgres;

--
-- Name: players_player_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.players_player_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.players_player_id_seq OWNER TO postgres;

--
-- Name: players_player_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.players_player_id_seq OWNED BY public.players.player_id;


--
-- Name: presidents; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.presidents (
    president_id integer NOT NULL,
    team_id bigint NOT NULL,
    name character varying(100) NOT NULL,
    nationality character varying(100) NOT NULL,
    pres_img text
);


ALTER TABLE public.presidents OWNER TO postgres;

--
-- Name: presidents_president_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.presidents_president_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.presidents_president_id_seq OWNER TO postgres;

--
-- Name: presidents_president_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.presidents_president_id_seq OWNED BY public.presidents.president_id;


--
-- Name: referees; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.referees (
    referee_id integer NOT NULL,
    name character varying(100) NOT NULL,
    nationality character varying(100) NOT NULL,
    ref_img text
);


ALTER TABLE public.referees OWNER TO postgres;

--
-- Name: referees_referee_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.referees_referee_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.referees_referee_id_seq OWNER TO postgres;

--
-- Name: referees_referee_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.referees_referee_id_seq OWNED BY public.referees.referee_id;


--
-- Name: stadiums; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.stadiums (
    stadium_id integer NOT NULL,
    team_id bigint NOT NULL,
    name character varying(100) NOT NULL,
    location character varying(100) NOT NULL,
    capacity bigint NOT NULL,
    std_img text
);


ALTER TABLE public.stadiums OWNER TO postgres;

--
-- Name: stadiums_stadium_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.stadiums_stadium_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.stadiums_stadium_id_seq OWNER TO postgres;

--
-- Name: stadiums_stadium_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.stadiums_stadium_id_seq OWNED BY public.stadiums.stadium_id;


--
-- Name: team_achievements; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.team_achievements (
    name character varying(100) NOT NULL,
    team_id bigint NOT NULL,
    ach_image text
);


ALTER TABLE public.team_achievements OWNER TO postgres;

--
-- Name: teams; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.teams (
    team_id integer NOT NULL,
    name character varying(100) NOT NULL,
    points smallint DEFAULT 0,
    captain character varying(100),
    home_kit_img text,
    away_kit_img text,
    badge_img text
);


ALTER TABLE public.teams OWNER TO postgres;

--
-- Name: teams_team_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.teams_team_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.teams_team_id_seq OWNER TO postgres;

--
-- Name: teams_team_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.teams_team_id_seq OWNED BY public.teams.team_id;


--
-- Name: coaches coach_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.coaches ALTER COLUMN coach_id SET DEFAULT nextval('public.coaches_coach_id_seq'::regclass);


--
-- Name: matches match_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.matches ALTER COLUMN match_id SET DEFAULT nextval('public.matches_match_id_seq'::regclass);


--
-- Name: players player_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.players ALTER COLUMN player_id SET DEFAULT nextval('public.players_player_id_seq'::regclass);


--
-- Name: presidents president_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.presidents ALTER COLUMN president_id SET DEFAULT nextval('public.presidents_president_id_seq'::regclass);


--
-- Name: referees referee_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.referees ALTER COLUMN referee_id SET DEFAULT nextval('public.referees_referee_id_seq'::regclass);


--
-- Name: stadiums stadium_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stadiums ALTER COLUMN stadium_id SET DEFAULT nextval('public.stadiums_stadium_id_seq'::regclass);


--
-- Name: teams team_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teams ALTER COLUMN team_id SET DEFAULT nextval('public.teams_team_id_seq'::regclass);


--
-- Name: coach_achievements coach_achievements_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.coach_achievements
    ADD CONSTRAINT coach_achievements_pkey PRIMARY KEY (name);


--
-- Name: coaches coaches_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.coaches
    ADD CONSTRAINT coaches_pkey PRIMARY KEY (coach_id);


--
-- Name: matches matches_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.matches
    ADD CONSTRAINT matches_pkey PRIMARY KEY (match_id);


--
-- Name: player_achievements player_achievements_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.player_achievements
    ADD CONSTRAINT player_achievements_pkey PRIMARY KEY (name);


--
-- Name: player_match_performance player_match_performance_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.player_match_performance
    ADD CONSTRAINT player_match_performance_pkey PRIMARY KEY (match_id, player_id);


--
-- Name: players players_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.players
    ADD CONSTRAINT players_pkey PRIMARY KEY (player_id);


--
-- Name: presidents presidents_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.presidents
    ADD CONSTRAINT presidents_pkey PRIMARY KEY (president_id);


--
-- Name: referees referees_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.referees
    ADD CONSTRAINT referees_pkey PRIMARY KEY (referee_id);


--
-- Name: stadiums stadiums_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stadiums
    ADD CONSTRAINT stadiums_pkey PRIMARY KEY (stadium_id);


--
-- Name: team_achievements team_achievements_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.team_achievements
    ADD CONSTRAINT team_achievements_pkey PRIMARY KEY (name);


--
-- Name: teams teams_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teams
    ADD CONSTRAINT teams_pkey PRIMARY KEY (team_id);


--
-- Name: coach_achievements coach_achievements_coach_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.coach_achievements
    ADD CONSTRAINT coach_achievements_coach_id_fkey FOREIGN KEY (coach_id) REFERENCES public.coaches(coach_id);


--
-- Name: coaches coaches_team_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.coaches
    ADD CONSTRAINT coaches_team_id_fkey FOREIGN KEY (team_id) REFERENCES public.teams(team_id);


--
-- Name: matches matches_away_team_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.matches
    ADD CONSTRAINT matches_away_team_id_fkey FOREIGN KEY (away_team_id) REFERENCES public.teams(team_id);


--
-- Name: matches matches_home_team_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.matches
    ADD CONSTRAINT matches_home_team_id_fkey FOREIGN KEY (home_team_id) REFERENCES public.teams(team_id);


--
-- Name: matches matches_referee_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.matches
    ADD CONSTRAINT matches_referee_id_fkey FOREIGN KEY (referee_id) REFERENCES public.referees(referee_id);


--
-- Name: player_achievements player_achievements_player_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.player_achievements
    ADD CONSTRAINT player_achievements_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.players(player_id);


--
-- Name: player_match_performance player_match_performance_match_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.player_match_performance
    ADD CONSTRAINT player_match_performance_match_id_fkey FOREIGN KEY (match_id) REFERENCES public.matches(match_id);


--
-- Name: player_match_performance player_match_performance_player_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.player_match_performance
    ADD CONSTRAINT player_match_performance_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.players(player_id);


--
-- Name: players players_team_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.players
    ADD CONSTRAINT players_team_id_fkey FOREIGN KEY (team_id) REFERENCES public.teams(team_id);


--
-- Name: presidents presidents_team_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.presidents
    ADD CONSTRAINT presidents_team_id_fkey FOREIGN KEY (team_id) REFERENCES public.teams(team_id);


--
-- Name: stadiums stadiums_team_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stadiums
    ADD CONSTRAINT stadiums_team_id_fkey FOREIGN KEY (team_id) REFERENCES public.teams(team_id);


--
-- Name: team_achievements team_achievements_team_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.team_achievements
    ADD CONSTRAINT team_achievements_team_id_fkey FOREIGN KEY (team_id) REFERENCES public.teams(team_id);


--
-- PostgreSQL database dump complete
--

