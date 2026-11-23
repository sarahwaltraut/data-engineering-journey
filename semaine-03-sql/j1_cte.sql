---------- Exercice 1 ----------------
WITH ventes AS (
    -- Étape 1 : le montant de chaque commande
    SELECT co.client_id, co.quantite * p.prix AS montant
    FROM commandes co
    JOIN produits p ON p.id = co.produit_id
),
ca_client AS (
    -- Étape 2 : le CA de chaque client, calculé à partir de l'étape 1
    SELECT c.nom, SUM(v.montant) AS ca
    FROM ventes v
    JOIN clients c ON c.id = v.client_id
    GROUP BY c.id, c.nom
)
-- Requête finale : elle utilise l'étape 2
SELECT nom, ca
FROM ca_client
ORDER BY ca DESC;


----------- Exercice 2 : les clients au-dessus de la moyenne --------------
WITH ventes AS (
    SELECT co.client_id, co.quantite * p.prix AS montant
    FROM commandes co
    JOIN produits p ON p.id = co.produit_id
),
ca_client AS (
    SELECT c.nom, SUM(v.montant) AS ca
    FROM ventes v
    JOIN clients c ON c.id = v.client_id
    GROUP BY c.id, c.nom
),
moyenne AS ( 
    SELECT AVG(ca) as moy
    FROM ca_client
)

SELECT nom, ca_client
FROM ca_client, moyenne
WHERE ca > moy
ORDER BY ca DESC;

------------------ Exercice 3 ---------------

SELECT p.categorie, SUM(co.quantite * p.prix) as ca
FROM commandes co
JOIN produits p ON p.id = co.produit_id
GROUP BY p.categorie
HAVING ca > 140;

WITH chiffre_affaire as (
    SELECT p.categorie, SUM(co.quantite * p.prix) as ca
    FROM commandes co
    JOIN produits p ON p.id = co.produit_id
    GROUP BY p.categorie
)
SELECT categorie, ca
FROM chiffre_affaire
WHERE ca > 140;

----------- Exercice 4 : la part de chaque client dans le CA total --------------

WITH ventes AS (
    SELECT co.client_id, co.quantite * p.prix AS montant
    FROM commandes co
    JOIN produits p ON p.id = co.produit_id
),
ca_client AS (
    SELECT c.nom, SUM(v.montant) AS ca
    FROM ventes v
    JOIN clients c ON c.id = v.client_id
    GROUP BY c.id, c.nom
),
ca_total AS (
    SELECT sum(ca) as total
    FROM ca_client
)

SELECT DISTINCT cc.nom as nom, cc.ca as ca, ROUND(100.0 * cc.ca / ct.total, 1) as part
FROM ca_total ct, ca_client cc;

---------- Exercice 5 : les clients actifs par ville ---------------

WITH clients_actifs AS (
    SELECT DISTINCT client_id
    FROM commandes
)

SELECT c.ville, COUNT(ca.client_id) as nb_clients_actifs, COUNT(c.id) as nb_clients
FROM clients c
LEFT JOIN clients_actifs ca ON c.id = ca.client_id
GROUP BY c.ville
ORDER BY c.ville;

--------- Exercice 6 : le produit star de chaque catégorie -----------

WITH ca_produit as (
    SELECT p.categorie, p.nom, SUM(co.quantite * p.prix) as ca
    FROM commandes co
    JOIN produits p ON p.id = co.produit_id
    GROUP BY p.id, p.categorie, p.nom
),
max_categorie AS (
    SELECT max(ca) as maximum, categorie
    FROM ca_produit
    GROUP BY categorie
)

SELECT  cp.categorie, cp.nom, mc.maximum
FROM ca_produit cp 
JOIN max_categorie mc ON cp.categorie = mc.categorie AND cp.ca = mc.maximum;