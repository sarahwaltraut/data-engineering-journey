----------------- Exercice 1 --------------

SELECT
    c.nom,
    co.date_commande,
    p.nom AS produit,
    ROW_NUMBER() OVER (PARTITION BY c.id ORDER BY co.date_commande, co.id) AS numero
FROM commandes co
JOIN clients c ON c.id = co.client_id
JOIN produits p ON p.id = co.produit_id
ORDER BY c.nom, numero;

-------------------- Exercice 2 : la première commande de chaque client -------

WITH commande AS (
    SELECT
    c.nom,
    co.date_commande,
    p.nom AS produit,
    ROW_NUMBER() OVER (PARTITION BY c.id ORDER BY co.date_commande, co.id) AS numero
    FROM commandes co
    JOIN clients c ON c.id = co.client_id
    JOIN produits p ON p.id = co.produit_id
)

SELECT *
FROM commande
WHERE numero = 1
ORDER BY nom, numero;

-------------------- Exercice 3 : comparer les trois classements ---------------

WITH ca_produit AS (
    SELECT p.categorie, p.nom, COALESCE(SUM(co.quantite * p.prix), 0) as ca
    FROM produits p
    LEFT JOIN commandes co ON p.id = co.produit_id
    GROUP BY p.id, p.categorie, p.nom
)

SELECT
    nom,
    ca,
    ROW_NUMBER() OVER (ORDER BY ca DESC, nom) AS row_number,
    RANK()       OVER (ORDER BY ca DESC)      AS rank,
    DENSE_RANK() OVER (ORDER BY ca DESC)      AS dense_rank
FROM ca_produit
ORDER BY ca DESC, nom;


------------------- Exercice 4 : le produit star de chaque catégorie, version fenêtre ----------------

WITH ca_produit as (
    SELECT p.categorie, p.nom, SUM(co.quantite * p.prix) as ca
    FROM commandes co
    JOIN produits p ON p.id = co.produit_id
    GROUP BY p.id, p.categorie, p.nom
),

num_produit as (
    SELECT nom, categorie, ca, ROW_NUMBER() OVER (PARTITION by categorie order by ca DESC) as numero
    FROM ca_produit
)

SELECT *
FROM num_produit
WHERE numero = 1;

--------------- Exercice 5 : le poids de chaque client dans sa ville ----------------

WITH ca_client AS (
    SELECT c.nom, c.ville, SUM(co.quantite * p.prix) AS ca
    FROM commandes co
    JOIN clients c ON c.id = co.client_id
    JOIN produits p ON p.id = co.produit_id
    GROUP BY c.id, c.nom, c.ville
)
SELECT
    nom,
    ville,
    ca,
    SUM(ca) OVER (PARTITION BY ville)                     AS ca_ville,
    ROUND(100.0 * ca / SUM(ca) OVER (PARTITION BY ville), 1) AS part_ville,
    ROUND(100.0 * ca / SUM(ca) OVER (), 1)                 AS part_totale
FROM ca_client
ORDER BY ville, ca DESC;

----------------- EXercice6: dédoublonner une table ---------------

WITH versions AS (
    SELECT
        id, statut, montant, charge_le,
        ROW_NUMBER() OVER (PARTITION BY id ORDER BY charge_le DESC) AS numero
    FROM commandes_brutes
)
SELECT id, statut, montant, charge_le
FROM versions
WHERE numero = 1
ORDER BY id;

SELECT id, statut, montant, charge_le
FROM commandes_brutes
QUALIFY ROW_NUMBER() OVER (PARTITION BY id ORDER BY charge_le DESC) = 1
ORDER BY id;