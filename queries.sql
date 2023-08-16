/*Queries that provide answers to the questions from all projects.*/

SELECT * from animals WHERE name = 'Luna';

vet_clinic=# SELECT * FROM animals WHERE name LIKE '%mon';
vet_clinic=# SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
vet_clinic=# SELECT name fROM animals WHERE neutered = true AND escape_attempts < 3;
vet_clinic=# SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
vet_clinic=# SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
vet_clinic=# SELECT * FROM animals WHERE neutered = true;
vet_clinic=# SELECT * FROM animals WHERE NOT name = 'Gabumon';
vet_clinic=# SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

* Update species column with unspecified and roll back to the previous state:
vet_clinic=# BEGIN;
BEGIN
vet_clinic=*# UPDATE animals
vet_clinic-*# SET species = 'unspecified';
UPDATE 11
vet_clinic=*# ROLLBACK;
ROLLBACK

* Update the species column with 'digimon' or 'pokemon' and make a commit.
vet_clinic=# BEGIN;
BEGIN
vet_clinic=*# UPDATE animals
vet_clinic-*# SET species = 'digimon'
vet_clinic-*# WHERE name LIKE '%mon';
UPDATE 6
vet_clinic=*# UPDATE animals
vet_clinic-*# SET species = 'pokemon'
vet_clinic-*# WHERE species IS NULL;
UPDATE 5
vet_clinic=*# COMMIT;
COMMIT

* Delete all the records and rollback
vet_clinic=# BEGIN;
BEGIN
vet_clinic=*# DELETE FROM animals;
DELETE 11
vet_clinic=*# ROLLBACK;
ROLLBACK

*Inside a transaction:
- Delete all animals born after Jan 1st, 2022.
- Create a savepoint for the transaction.
- Update all animals' weight to be their weight multiplied by -1.
- Rollback to the savepoint
- Update all animals' weights that are negative to be their weight multiplied by -1.
- Commit transaction
vet_clinic=# BEGIN;
BEGIN
vet_clinic=*# DELETE FROM animals
vet_clinic-*# WHERE date_of_birth > '2022-01-01';
DELETE 1
vet_clinic=*# SAVEPOINT SP1;
SAVEPOINT
vet_clinic=*# UPDATE animals
vet_clinic-*# SET weight_kg = weight_kg * -1;
UPDATE 10
vet_clinic=*# ROLLBACK TO SP1;
ROLLBACK
vet_clinic=*# UPDATE animals
vet_clinic-*# SET weight_kg = weight_kg * -1
vet_clinic-*# WHERE weight_kg < 0;
UPDATE 4
vet_clinic=*# COMMIT;
COMMIT

* Write queries to answer the following questions:
- How many animals are there?
	vet_clinic=# SELECT COUNT(id)
	vet_clinic-# FROM animals;

- How many animals have never tried to escape?
	vet_clinic=# SELECT COUNT(id)
	vet_clinic-# FROM animals
	vet_clinic-# WHERE escape_attempts = 0;

- What is the average weight of animals?
	vet_clinic=# SELECT AVG(weight_kg)
	vet_clinic-# FROM animals;

- Who escapes the most, neutered or not neutered animals?
	vet_clinic=# SELECT neutered, COUNT(neutered)
	vet_clinic-# FROM animals
	vet_clinic-# GROUP BY neutered;

- What is the minimum and maximum weight of each type of animal?
	vet_clinic=# SELECT species, MIN(weight_kg), MAX(weight_kg)
	vet_clinic-# FROM animals
	vet_clinic-# GROUP BY species;

- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
	vet_clinic=# SELECT species, AVG(escape_attempts)
	vet_clinic-# FROM animals
	vet_clinic-# WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
	vet_clinic-# GROUP BY species;

* Write queries (using JOIN) to answer the following questions:
- What animals belong to Melody Pond?
	vet_clinic=# SELECT animals.name, animals.owner_id, owners.full_name, owners.id
	vet_clinic-# FROM animals
	vet_clinic-# INNER JOIN owners
	vet_clinic-# ON owners.id = animals.owner_id
	vet_clinic-# WHERE owners.full_name = 'Melody Pond';
- List of all animals that are pokemon (their type is Pokemon).
	vet_clinic=# SELECT animals.name, animals.species_id, species.id, species.name
	vet_clinic-# FROM animals
	vet_clinic-# INNER JOIN species
	vet_clinic-# ON species.id = animals.species_id
	vet_clinic-# WHERE species.name = 'Pokemon';
- List all owners and their animals, remember to include those that don't own any animal.
	vet_clinic=# SELECT animals.name, owners.full_name, animals.owner_id, owners.id
	vet_clinic-# FROM animals
	vet_clinic-# FULL OUTER JOIN owners
	vet_clinic-# ON animals.owner_id = owners.id;
- How many animals are there per species?
	vet_clinic=# SELECT species.name, COUNT(animals.species_id)
	vet_clinic-# FROM animals
	vet_clinic-# INNER JOIN species
	vet_clinic-# ON animals.species_id = species.id
	vet_clinic-# GROUP BY species.name;
- List all Digimon owned by Jennifer Orwell.
	vet_clinic=# SELECT animals.name, owners.full_name
	vet_clinic-# FROM animals
	vet_clinic-# INNER JOIN owners
	vet_clinic-# ON owners.id = animals.owner_id
	vet_clinic-# INNER JOIN species
	vet_clinic-# ON species.id = animals.species_id
	vet_clinic-# WHERE owners.full_name = 'Jennifer Orwell' AND species.name = 'Digimon';
- List all animals owned by Dean Winchester that haven't tried to escape.
	vet_clinic=# SELECT animals.name, owners.full_name
	vet_clinic-# FROM animals
	vet_clinic-# INNER JOIN owners
	vet_clinic-# ON owners.id = animals.owner_id
	vet_clinic-# WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;
- Who owns the most animals?
	vet_clinic=# SELECT owners.full_name, COUNT(animals.owner_id) AS animal_count
	vet_clinic-# FROM animals
	vet_clinic-# FULL OUTER JOIN owners
	vet_clinic-# ON animals.owner_id = owners.id
	vet_clinic-# GROUP BY owners.full_name
	vet_clinic-# ORDER BY animal_count DESC
	vet_clinic-# LIMIT 1;
