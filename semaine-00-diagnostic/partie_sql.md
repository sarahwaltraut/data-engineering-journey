1- Différence entre where et having:

Le where filtre les lignes avant de faire les regroupements tant dis que having est utilisé après les groupe by.

2- Différence entre left join et inner join:

inner join fait une jointure en conservant uniquement les lignes qui ont une correspondance dans les deux tables tant dis que left join conserve toutes les lignes de la table gauche même si elles n'ont pas de correspondance dans la table de droite.

3- Une colonne contient 5 lignes, dont 2 valent NULL. Que renvoient COUNT(*) et COUNT(colonne) ?
COUNT(*) renvoie 5 et COUNT(colonne) 1.

4- Dans quel ordre la base de données exécute-t-elle réellement les clauses SELECT, FROM, WHERE, GROUP BY, HAVING et ORDER BY ?

FROM → WHERE → GROUP BY → HAVING → SELECT → ORDER BY

CREATE TABLE clients (
    id INTEGER PRIMARY KEY,
    nom TEXT,
    ville TEXT,
    date_inscription TEXT
);

CREATE TABLE produits (
    id INTEGER PRIMARY KEY,
    nom TEXT,
    categorie TEXT,
    prix REAL
);

CREATE TABLE commandes (
    id INTEGER PRIMARY KEY,
    client_id INTEGER,
    produit_id INTEGER,
    quantite INTEGER,
    date_commande TEXT
);

INSERT INTO clients VALUES
(1, 'Alice', 'Lyon', '2026-01-15'),
(2, 'Bruno', 'Paris', '2026-02-03'),
(3, 'Chloé', 'Limoges', '2026-02-20'),
(4, 'David', 'Limoges', '2026-03-11'),
(5, 'Emma', 'Paris', '2026-04-02'),
(6, 'Farid', 'Bordeaux', '2026-05-18');

INSERT INTO produits VALUES
(1, 'Clavier', 'Informatique', 45.00),
(2, 'Souris', 'Informatique', 20.00),
(3, 'Roman', 'Livres', 15.00),
(4, 'BD', 'Livres', 12.00),
(5, 'Casque', 'Audio', 80.00),
(6, 'Enceinte', 'Audio', 60.00);

INSERT INTO commandes VALUES
(1, 1, 1, 1, '2026-09-01'),
(2, 1, 2, 2, '2026-09-01'),
(3, 2, 5, 1, '2026-09-02'),
(4, 3, 3, 3, '2026-09-03'),
(5, 3, 4, 2, '2026-09-05'),
(6, 4, 2, 1, '2026-09-06'),
(7, 2, 3, 1, '2026-09-10'),
(8, 1, 5, 1, '2026-09-12'),
(9, 6, 4, 4, '2026-09-15'),
(10, 4, 1, 1, '2026-09-20');

Select * from commandes;

 -- Affiche le nom de tous les clients qui habitent à Limoges.
 Select nom from clients
 Where ville = 'Limoges';
 
-- Affiche le nom et le prix des produits qui coûtent plus de 30 €, du plus cher au moins cher.
select nom, prix from produits
where prix > 30 order by prix DESC;

-- Affiche le nombre de clients par ville.
select ville, COUNT(*) as nbre from clients
group by ville;

-- Pour chaque commande, affiche la date, le nom du client, le nom du produit et le montant (quantité × prix). Tu dois obtenir 10 lignes.
select commandes.date_commande, clients.nom as nom_client, produits.nom as nom_produit, commandes.quantite * produits.prix as montant
from commandes inner join clients on commandes.client_id = clients.id 
INNER JOIN produits on commandes.produit_id = produits.id;

-- Affiche le chiffre d’affaires total de chaque client, du plus grand au plus petit. Pour vérifier : la somme de tous ces CA doit faire 442.
SELECT c.nom, SUM(co.quantite * p.prix) AS chiffre_affaires
FROM commandes co
INNER JOIN clients c ON co.client_id = c.id
INNER JOIN produits p ON co.produit_id = p.id
GROUP BY c.id, c.nom
ORDER BY chiffre_affaires DESC;

-- Affiche les clients qui n’ont jamais passé de commande.
Select clients.* from clients left join commandes on clients.id = commandes.client_id
where commandes.client_id is null;

-- Affiche le CA par catégorie de produit, en ne gardant que les catégories dont le CA dépasse 140 €.
SELECT p.categorie, SUM(co.quantite * p.prix) AS ca
FROM produits p
INNER JOIN commandes co ON p.id = co.produit_id
GROUP BY p.categorie
HAVING SUM(co.quantite * p.prix) > 140;

-- Affiche les produits dont le prix est supérieur au prix moyen de tous les produits. 
select * from produits where prix > ( Select AVG(prix) from produits) ;

