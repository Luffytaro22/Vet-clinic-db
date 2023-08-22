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


* Who was the last animal seen by William Tatcher?
	vet_clinic=# SELECT vets.name, animals.name, visits.visit_date
	vet_clinic-# FROM animals
	vet_clinic-# INNER JOIN visits
	vet_clinic-# ON animals.id = visits.animals_id
	vet_clinic-# INNER JOIN vets
	vet_clinic-# ON vets.id = visits.vets_id
	vet_clinic-# WHERE vets.name = 'William Tatcher'
	vet_clinic-# ORDER BY visits.visit_date DESC
	vet_clinic-# LIMIT 1;

* How many different animals did Stephanie Mendez see?
	vet_clinic=# SELECT vets.name, COUNT(visits.animals_id) AS count_animals
	vet_clinic-# FROM visits
	vet_clinic-# INNER JOIN vets
	vet_clinic-# ON vets.id = visits.vets_id
	vet_clinic-# WHERE vets.name = 'Stephanie Mendez'
	vet_clinic-# GROUP BY vets.name;

* List all vets and their specialties, including vets with no specialties.
	vet_clinic=# SELECT vets.name, species.name AS specialization
	vet_clinic-# FROM specializations
	vet_clinic-# FULL OUTER JOIN vets
	vet_clinic-# ON vets.id = specializations.vets_id
	vet_clinic-# FULL OUTER JOIN species
	vet_clinic-# ON species.id = specializations.species_id;

* List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
	vet_clinic=# SELECT vets.name, animals.name AS animals, visits.visit_date
	vet_clinic-# FROM visits
	vet_clinic-# INNER JOIN vets
	vet_clinic-# ON vets.id = visits.vets_id
	vet_clinic-# INNER JOIN animals
	vet_clinic-# ON animals.id = visits.animals_id
	vet_clinic-# WHERE vets.name = 'Stephanie Mendez' AND visits.visit_date BETWEEN '2020-04-1' AND '2020-08-30';

* What animal has the most visits to vets?
	vet_clinic=# SELECT animals.name AS animals, COUNT(visits.animals_id) AS count_visits
	vet_clinic-# FROM visits
	vet_clinic-# INNER JOIN animals
	vet_clinic-# ON animals.id = visits.animals_id
	vet_clinic-# GROUP BY animals.name
	vet_clinic-# ORDER BY count_visits DESC
	vet_clinic-# LIMIT 1;

* Who was Maisy Smith's first visit?
	vet_clinic=# SELECT vets.name AS vet, animals.name AS animal, visits.visit_date
	vet_clinic-# FROM visits
	vet_clinic-# INNER JOIN vets
	vet_clinic-# ON vets.id = visits.vets_id
	vet_clinic-# INNER JOIN animals
	vet_clinic-# ON animals.id = visits.animals_id
	vet_clinic-# WHERE vets.name = 'Maisy Smith'
	vet_clinic-# ORDER BY visits.visit_date ASC
	vet_clinic-# LIMIT 1;

* Details for most recent visit: animal information, vet information, and date of visit.
	vet_clinic=# SELECT animals.name AS animal, vets.name AS vet, visits.visit_date
	vet_clinic-# FROM visits
	vet_clinic-# INNER JOIN vets
	vet_clinic-# ON vets.id = visits.vets_id
	vet_clinic-# INNER JOIN animals
	vet_clinic-# ON animals.id = visits.animals_id
	vet_clinic-# ORDER BY visits.visit_date DESC
	vet_clinic-# LIMIT 1;

* How many visits were with a vet that did not specialize in that animal's species?
	vet_clinic=# SELECT COUNT(*) AS visits
	vet_clinic-# FROM visits
	vet_clinic-# JOIN vets
	vet_clinic-# ON vets.id = visits.vets_id
	vet_clinic-# JOIN animals
	vet_clinic-# ON animals.id = visits.animals_id
	vet_clinic-# WHERE NOT EXISTS (
	vet_clinic(# SELECT 1
	vet_clinic(# FROM specializations
	vet_clinic(# WHERE specializations.vets_id = vets.id AND specializations.species_id = animals.species_id
	vet_clinic(# );

* What specialty should Maisy Smith consider getting? Look for the species she gets the most.
	vet_clinic=# SELECT vets.name AS vet, species.name AS specie, COUNT(*) AS species_count
	vet_clinic-# FROM visits
	vet_clinic-# JOIN vets
	vet_clinic-# ON visits.vets_id = vets.id
	vet_clinic-# JOIN animals
	vet_clinic-# ON visits.animals_id = animals.id
	vet_clinic-# JOIN species
	vet_clinic-# ON animals.species_id = species.id
	vet_clinic-# WHERE vets.name = 'Maisy Smith'
	vet_clinic-# GROUP BY vets.name, species.name;