/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    name varchar(100)
);

postgres=# CREATE DATABASE vet_clinic;
CREATE DATABASE
postgres=# \c vet_clinic

vet_clinic=# CREATE TABLE animals(
vet_clinic(# id         INT GENERATED ALWAYS AS IDENTITY,
vet_clinic(# name       varchar(100),
vet_clinic(# date_of_birth      date,
vet_clinic(# escape_attempts    INT,
vet_clinic(# neutered           bool,
vet_clinic(# weight_kg          decimal(5,2)
vet_clinic(# ,
vet_clinic(# PRIMARY KEY(id)
vet_clinic(# );

vet_clinic=# ALTER TABLE animals
vet_clinic-# ADD species        varchar(50);