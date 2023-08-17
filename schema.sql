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

* Create a table named owners:
vet_clinic=# CREATE TABLE owners(
vet_clinic(# id         INT  GENERATED ALWAYS AS IDENTITY,
vet_clinic(# full_name  varchar(100),
vet_clinic(# age        INT,
vet_clinic(# PRIMARY KEY(id)
vet_clinic(# );
CREATE TABLE

* Create a table named species:
vet_clinic=# CREATE TABLE species(
vet_clinic(# id         INT  GENERATED ALWAYS AS IDENTITY,
vet_clinic(# name       varchar(50),
vet_clinic(# PRIMARY KEY(id)
vet_clinic(# );
CREATE TABLE

* Modify animals table:

- Remove column species:
vet_clinic=# ALTER TABLE animals
vet_clinic-# DROP COLUMN species;
ALTER TABLE

-Add column species_id which is a foreign key referencing species table:
vet_clinic=# ALTER TABLE animals
vet_clinic-# ADD species_id INT REFERENCES species(id);
ALTER TABLE

-Add column owner_id which is a foreign key referencing the owners table:
vet_clinic=# ALTER TABLE animals
vet_clinic-# ADD owner_id INT REFERENCES owners(id);
ALTER TABLE

* Create a vets table:
vet_clinic=# CREATE TABLE vets(
vet_clinic(# id         INT GENERATED ALWAYS AS IDENTITY,
vet_clinic(# name       varchar(50),
vet_clinic(# age        INT,
vet_clinic(# date_of_graduation         date,
vet_clinic(# PRIMARY KEY(id)
vet_clinic(# );
CREATE TABLE

* Create specializations join table:
vet_clinic=# CREATE TABLE specializations(
vet_clinic(# species_id         INT REFERENCES species(id),
vet_clinic(# vets_id            INT REFERENCES vets(id),
vet_clinic(# PRIMARY KEY(species_id, vets_id)
vet_clinic(# );
CREATE TABLE