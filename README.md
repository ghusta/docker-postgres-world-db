# postgres-world-db

[![Build Status](https://travis-ci.org/ghusta/docker-postgres-world-db.svg?branch=master)](https://travis-ci.org/ghusta/docker-postgres-world-db)
[![Docker Pulls](https://img.shields.io/docker/pulls/ghusta/postgres-world-db.svg)](https://hub.docker.com/r/ghusta/postgres-world-db)
![GitHub tag](https://img.shields.io/github/tag/ghusta/docker-postgres-world-db.svg)

Example Database for [PostgreSQL](https://www.postgresql.org/) : World DB

Database script downloaded at : http://pgfoundry.org/frs/?group_id=1000150&release_id=366#world-world-1.0-title-content

See also PostgreSQL [Sample Databases](https://wiki.postgresql.org/wiki/Sample_Databases).

# Database details

**Important note** : from version 2.0, tables and columns names use [_snake case_](https://en.wikipedia.org/wiki/Snake_case).
 This version is incompatible with version 1.x.

## Default parameters

- database : world-db
- user : world
- password : world123

## Schema

- public

## Tables
This database contains 3 tables :

- city
- country
- country_language

## Relationships

- country_language -> country (country_language_country_code_fkey)
- city -> country (country_fk)
- country -> city (country_capital_fkey)

# Run a Docker container

You can run a Docker container with this command (replace _xxxx_ by your local port) :

`docker run -d -p xxxx:5432 ghusta/postgres-world-db:2.6`

# PostgreSQL configuration

If you need to inspect the PostgreSQL server configuration, you can read this file : `/var/lib/posgtresql/data/postgresql.conf`.

All settings are documented here : https://www.postgresql.org/docs/current/runtime-config.html

With Docker, you can run :

`docker exec <my-container-name> cat /var/lib/postgresql/data/postgresql.conf`

## Log all statements

To log all statements, you can activate this line in the configuration :

`log_min_duration_statement = 0`

## Log categories of statements

You can also log only some categories of statements with `log_statement`.

Valid values are `none, ddl, mod, all`. Default is `none`.

See details : https://www.postgresql.org/docs/current/runtime-config-logging.html

# Test it

## With Java

### Plain Java with JDBC

First add the [PostgreSQL JDBC Driver](https://jdbc.postgresql.org/), with Maven for example : [org.postgresql » postgresql](https://mvnrepository.com/artifact/org.postgresql/postgresql).

Then execute a test query with :

```java
package org.example;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class JdbcDemo {

    public static void main(String[] args) {
        String jdbcUrl = "jdbc:postgresql://localhost:5432/world-db";
        String user = "world";
        String password = "world123";

        try (Connection conn = DriverManager.getConnection(jdbcUrl, user, password)) {
            String query = "select count(*) from city";
            try (Statement stmt = conn.createStatement()) {
                ResultSet rs = stmt.executeQuery(query);
                while (rs.next()) {
                    int count = rs.getInt(1);
                    System.out.println("Count = " + count);
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

}
```

### Spring Boot

Initialize a [Spring Boot project](https://start.spring.io/) with dependencies _PostgreSQL Driver_ and [_Spring Data JPA_](https://spring.io/projects/spring-data-jpa) (or [_Spring Data JDBC_](https://spring.io/projects/spring-data-jdbc) if you want to keep simple).

Add these properties in _application.properties_ :

- `spring.datasource.url=jdbc:postgresql://localhost:5432/world-db`
- `spring.datasource.username=world`
- `spring.datasource.password=world123`

Then just add JPA entities for each table (City, Country), and interfaces for each DAO which extends `JpaRepository`.

## With Python

Install [psycopg](https://pypi.org/project/psycopg/), a PostgreSQL database adapter for Python.

> pip install psycopg

Then create a connection...

```python
import psycopg

DB_HOST = "localhost"
DB_PORT = "5432"
DB_NAME = "world-db"
DB_USER = "world"
DB_PASS = "world123"

with  psycopg.connect(dbname=DB_NAME, user=DB_USER, password=DB_PASS, host=DB_HOST, port=DB_PORT) as conn:

    with conn.cursor() as cur:
        cur.execute("select count(*) from city")
        row = cur.fetchone()
        print('Count = ', row[0])

```

# Alternatives

You can find alternative DBMS or databases examples [at this page](ALTERNATIVES.md).
