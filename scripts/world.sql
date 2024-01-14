--
-- PostgreSQL port of the MySQL "World" database.
--
-- The sample data used in the world database is Copyright Statistics 
-- Finland, http://www.stat.fi/worldinfigures.
--

BEGIN;

SET client_encoding TO 'UTF8';

CREATE TABLE city (
    id integer NOT NULL,
    name text NOT NULL,
    country_code character(3) NOT NULL,
    district text NOT NULL,
    population integer NOT NULL,
    local_name text NULL
);

COMMENT ON COLUMN city.local_name IS 'City local name';

CREATE TABLE country (
    code character(3) NOT NULL,
    name text NOT NULL,
    continent text NOT NULL,
    region text NOT NULL,
    surface_area real NOT NULL,
    indep_year smallint,
    population integer NOT NULL,
    life_expectancy real,
    gnp numeric(10,2),
    gnp_old numeric(10,2),
    local_name text NOT NULL,
    government_form text NOT NULL,
    head_of_state text,
    capital integer,
    code2 character(2) NOT NULL,
    CONSTRAINT country_continent_check CHECK ((((((((continent = 'Asia'::text) OR (continent = 'Europe'::text)) OR (continent = 'North America'::text)) OR (continent = 'Africa'::text)) OR (continent = 'Oceania'::text)) OR (continent = 'Antarctica'::text)) OR (continent = 'South America'::text)))
);

COMMENT ON COLUMN country.gnp IS 'GNP is Gross national product';
COMMENT ON COLUMN country.code2 IS 'Following ISO 3166-1 alpha-2 code';

CREATE TABLE country_language (
    country_code character(3) NOT NULL,
    "language" text NOT NULL,
    is_official boolean NOT NULL,
    percentage real NOT NULL
);

CREATE TABLE country_flag (
    code2 character(2) NOT NULL,
    emoji text NOT NULL,
    unicode text
);

COMMENT ON COLUMN country_flag.code2 IS 'Following ISO 3166-1 alpha-2 code';
COMMENT ON COLUMN country_flag.emoji IS 'Source: Emoji flag symbols (https://apps.timwhitlock.info/emoji/tables/iso3166)';

COPY city (id, name, country_code, district, population, local_name)
FROM '/docker-entrypoint-initdb.d/city_utf8.csv'
DELIMITER ','
CSV HEADER;

COPY country (code, name, continent, region, surface_area, indep_year, population, life_expectancy, gnp, gnp_old, local_name, government_form, head_of_state, capital, code2)
FROM '/docker-entrypoint-initdb.d/country_utf8.csv'
DELIMITER ','
CSV HEADER;

COPY country_language (country_code, "language", is_official, percentage)
FROM '/docker-entrypoint-initdb.d/country_language_utf8.csv'
DELIMITER ','
CSV HEADER;

COPY country_flag (code2, emoji, unicode)
FROM '/docker-entrypoint-initdb.d/country_flag_utf8.csv'
DELIMITER ','
CSV HEADER;

ALTER TABLE ONLY city
    ADD CONSTRAINT city_pkey PRIMARY KEY (id);

ALTER TABLE ONLY country
    ADD CONSTRAINT country_pkey PRIMARY KEY (code);

ALTER TABLE ONLY country_language
    ADD CONSTRAINT country_language_pkey PRIMARY KEY (country_code, "language");

ALTER TABLE ONLY country
    ADD CONSTRAINT country_capital_fkey FOREIGN KEY (capital) REFERENCES city(id);

ALTER TABLE ONLY country_language
    ADD CONSTRAINT country_language_country_code_fkey FOREIGN KEY (country_code) REFERENCES country(code);

ALTER TABLE ONLY country_flag
    ADD CONSTRAINT country_flag_pkey PRIMARY KEY (code2);

-- Added in 2.1
ALTER TABLE city
    ADD CONSTRAINT country_fk
    FOREIGN KEY (country_code) REFERENCES country (code);

COMMIT;

ANALYZE city;
ANALYZE country;
ANALYZE country_language;
ANALYZE country_flag;

