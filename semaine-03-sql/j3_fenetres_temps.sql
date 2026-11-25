-------------- Exercice 1 : l'évolution jour par jour à Limoges ---------------
SELECT jour, ca, LAG(ca) OVER w as veille,
        ca - LAG(ca) OVER w as variation, ROUND(100.0 * ( ca - LAG(ca) OVER w)/LAG(ca) OVER w, 1) as evolution
FROM ventes_quotidiennes
WHERE magasin = 'Limoges'
WINDOW w as ( PARTITION by magasin ORDER by jour)
ORDER BY jour; 

-------------- Exercice 2 : le lendemain, à Lyon --------------------
SELECT jour, ca, LEAD(ca) OVER ( PARTITION by magasin ORDER by jour) as lendemain,
FROM ventes_quotidiennes
WHERE magasin = 'Lyon'
ORDER BY jour; 

------------- Exercice 3 : le CA cumulé de chaque magasin -----------
SELECT jour, magasin, ca, SUM(ca) OVER (PARTITION BY magasin ORDER BY jour) as ca_cumule
FROM ventes_quotidiennes
WHERE magasin = 'Limoges' or magasin = 'Lyon'
ORDER BY magasin; 

------------ Exercice 5 : la moyenne mobile sur 3 jours ----------------
SELECT jour, ca, ROUND(AVG(ca) OVER ( PARTITION BY magasin ORDER BY jour ROWS BETWEEN 2 PRECEDING AND CURRENT ROW ), 1) as moyenne_mobile_3j
FROM ventes_quotidiennes
WHERE magasin = 'Limoges'
ORDER BY jour; 

----------- Exercice 6 ------------------------
WITH ca_jour as (
    SELECT co.date_commande, SUM(co.quantite * p.prix) as ca
    FROM commandes co
    JOIN produits p ON p.id = co.produit_id
    GROUP BY co.date_commande
),

SELECT date_commande, ca, SUM(ca) OVER (ORDER by date_commande) as ca_cumule
FROM ca_jour
ORDER by date_commande;

--------------- Exercice 7 : détecter les chutes d'activité ---------------
WITH jour_veille AS (
    SELECT
        jour,
        magasin,
        ca,
        LAG(ca) OVER (PARTITION BY magasin ORDER BY jour) AS veille
    FROM ventes_quotidiennes
)
SELECT
    jour,
    magasin,
    veille,
    ca,
    ROUND(100.0 * (ca - veille) / veille, 1) AS evolution
FROM jour_veille
WHERE ca < veille * 0.8
ORDER BY magasin, jour;