-- 1 - Afficher toute la table


SELECT *
FROM `fr_carburants.fr_carburants`;


-- 2 - Afficher seulement quelques colonnes de la table


SELECT 
  id, 
  adresse,
  code_postal, 
  ville, 
  code_departement,
  departement, 
  latitude, 
  longitude, 
  code_region,
  region, 
  prix_sp95, 
  carburants_disponibles
FROM 
  `fr_carburants.fr_carburants`;


-- 3 - Trouver le prix min/max du SP95


SELECT 
  MIN(prix_sp95) AS prix_min_sp95,
  MAX(prix_sp95) AS prix_max_sp95
FROM
  `fr_carburants.fr_carburants`;


-- 4 - Afficher les stations essence du département: 83


SELECT
  id, 
  adresse,
  code_postal, 
  ville, 
  code_departement,
  departement, 
  latitude, 
  longitude, 
  code_region,
  region, 
  prix_sp95, 
  carburants_disponibles
FROM
  `fr_carburants.fr_carburants`
WHERE
  code_departement = '83';


-- 5 - Compter les stations essence du département: 83


SELECT
  COUNT(id) AS nbr_stations_dep83
FROM
  `fr_carburants.fr_carburants`
WHERE
  code_departement = '83';


-- 6 - Afficher les stations essence du département: 83 qui ont du SP95


SELECT
  COUNT(id) AS nbr_stations_dep83
FROM
  `fr_carburants.fr_carburants`
WHERE
  code_departement = '83'
  AND prix_sp95 IS NOT NULL;


-- 7 - Trouver la station la moins chère pour le SP95 du département: 83


SELECT
  id, 
  adresse,
  code_postal, 
  ville, 
  code_departement,
  departement, 
  latitude, 
  longitude, 
  code_region,
  region, 
  prix_sp95, 
  carburants_disponibles
FROM
  `fr_carburants.fr_carburants`
WHERE
  code_departement = '83'
  AND prix_sp95 IS NOT NULL
ORDER BY
  prix_sp95 ASC
LIMIT
  1;


-- 8 - Calculer la distance entre les stations essences et une adresse définie (exemple : 543 chemin des bonnettes, 83220 Le Pradet, France => latitude 43.101974, longitude => 6.017188)


SELECT
  id, 
  adresse,
  code_postal, 
  ville, 
  code_departement,
  departement, 
  ROUND(ST_DISTANCE(ST_GEOGPOINT(6.017188, 43.101974), ST_GEOGPOINT(longitude, latitude))/1000, 2) AS distance_kms,
  latitude, 
  longitude, 
  code_region,
  region, 
  prix_sp95, 
  carburants_disponibles
FROM
  `fr_carburants.fr_carburants`
WHERE
  code_departement = '83'
  AND prix_sp95 IS NOT NULL;


-- 9 - Requête pour Dashboard


SELECT
  adresse,
  ville,
  CONCAT(adresse, " ", code_postal, " ", ville) AS adresse_complete,
  ROUND(prix_sp95, 2) AS prix_sp95,
  ROUND(ST_DISTANCE(ST_GEOGPOINT(6.017188, 43.101974), ST_GEOGPOINT(longitude, latitude))/1000, 2) AS distance_kms
FROM
  `fr_carburants.fr_carburants`
WHERE
  code_departement = '83'
  AND prix_sp95 IS NOT NULL
ORDER BY
  distance_kms;
