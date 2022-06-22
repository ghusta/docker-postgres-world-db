# Changelog

## 2.6.4 (2022-06-22)
Upgrade to PostgreSQL 14.4.  
See https://www.postgresql.org/about/news/postgresql-144-released-2470/

## 2.6.3 (2022-06-21)
Upgrade to PostgreSQL 14.3.  
See https://www.postgresql.org/about/news/postgresql-143-137-1211-1116-and-1021-released-2449/

## 2.6 (2021-10-01)
Upgrade to PostgreSQL 14.  
See https://www.postgresql.org/about/news/postgresql-14-released-2318/

## 2.5 (2020-09-25)
Upgrade to PostgreSQL 13.  
See https://www.postgresql.org/about/news/2077/

## 2.4 (2019-10-03)
Upgrade to PostgreSQL 12.  
See https://www.postgresql.org/about/news/1976/

## 2.3 (2018-10-19)
Upgrade to PostgreSQL 11.  
See https://www.postgresql.org/about/news/1894/

## 2.2.1 (2018-08-13)
Add HEALTHCHECK in Dockerfile (#2).

## 2.2 (2017-10-06)
Upgrade to PostgreSQL 10.  
See https://www.postgresql.org/about/news/1786/ 

## 2.1.1 (2017-10-05)
Simplify Dockerfile (no need for zipped SQL scripts)

## 2.1 (2016-06-22)
Add _country_fk_ (city.country_code -> country.code)

## 2.0 (2016-05-17)
Upgrade to PostgreSQL 9.6.  
Normalization : change table and columns names to [snake case](https://en.wikipedia.org/wiki/Snake_case).  
See also this question on SO : [PostgreSQL naming conventions](http://stackoverflow.com/questions/2878248/postgresql-naming-conventions). 

## 1.0 (2016-05-16)
Initial release.  
Based on PostgreSQL 9.5.  
Source : [world-1.0](http://pgfoundry.org/frs/shownotes.php?release_id=366) database (2005-12-02).
