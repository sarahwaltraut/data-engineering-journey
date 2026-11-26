------- Exercice 1 : classer les commandes par taille -------------
WITH montants AS (
    SELECT co.id, c.nom, p.categorie, co.quantite * p.prix AS montant
    FROM commandes co
    JOIN clients c ON c.id = co.client_id
    JOIN produits p ON p.id = co.produit_id
),

cte_taille AS (
    SELECT CASE WHEN montant < 30 THEN 'petite'
                WHEN montant < 80 THEN 'moyenne'
                ELSE 'grande'
            END AS taille, id, montant
    FROM montants
)
SELECT taille, COUNT(id) AS nb_commandes, SUM(montant) as ca
FROM  cte_taille
GROUP BY taille
ORDER BY taille desc;

------------------------ Exercice 2 ---------------------------------
WITH montants AS (
    SELECT co.id, c.nom, p.categorie, co.quantite * p.prix AS montant
    FROM commandes co
    JOIN clients c ON c.id = co.client_id
    JOIN produits p ON p.id = co.produit_id
)

SELECT nom, SUM(CASE WHEN categorie = 'Audio' THEN montant ELSE 0 END) AS audio,
       SUM(CASE WHEN categorie = 'Informatique' THEN montant ELSE 0 END) AS informatique,
       SUM(CASE WHEN categorie = 'Livres' THEN montant ELSE 0 END) AS livres,
       SUM(montant)
FROM montants
GROUP BY nom
ORDER BY nom;

------------------ Exercice 3 : le CA par semaine ------------------
SELECT DATE_TRUNC('week', jour)::DATE as semaine, magasin, sum(ca) as ca
FROM ventes_quotidiennes
GROUP BY DATE_TRUNC('week', jour)::DATE, magasin
ORDER BY magasin, semaine;

------------------- Exercice 4 : le délai de chaque livraison ---------

SELECT
    id,
    COALESCE(transporteur, 'Inconnu') AS transporteur,
    date_livraison - date_expedition AS delai_jours
FROM livraisons
ORDER BY id;

-------------------- Exercice 5 : les statistiques par transporteur----------
SELECT
    COALESCE(transporteur, 'Inconnu') AS transporteur,
    COUNT(*) AS nb_colis,
    COUNT(date_livraison) AS nb_livres,
    ROUND(AVG(date_livraison - date_expedition), 1) AS delai_moyen
FROM livraisons
GROUP BY COALESCE(transporteur, 'Inconnu')
ORDER BY transporteur;

----------------- Exercice 6 : le statut de chaque livraison ----------------
SELECT
    id,
    COALESCE(transporteur, 'Inconnu') AS transporteur,
    CASE
        WHEN date_livraison IS NULL THEN 'en transit'
        WHEN date_livraison - date_expedition > 3 THEN 'en retard'
        ELSE 'à l''heure'
    END AS statut
FROM livraisons
ORDER BY id;

---------- Exercice 7 : le taux de retard par transporteur ----------
WITH statuts AS (
    SELECT
        COALESCE(transporteur, 'Inconnu') AS transporteur,
        CASE
            WHEN date_livraison IS NULL THEN 'en transit'
            WHEN date_livraison - date_expedition > 3 THEN 'en retard'
            ELSE 'à l''heure'
        END AS statut
    FROM livraisons
),
compteurs AS (
    SELECT
        transporteur,
        COUNT(*) FILTER (WHERE statut <> 'en transit') AS nb_livres,
        COUNT(*) FILTER (WHERE statut = 'en retard') AS nb_retards
    FROM statuts
    GROUP BY transporteur
)
SELECT
    transporteur,
    nb_livres,
    nb_retards,
    ROUND(100.0 * nb_retards / NULLIF(nb_livres, 0), 1) AS taux_retard
FROM compteurs
ORDER BY transporteur;