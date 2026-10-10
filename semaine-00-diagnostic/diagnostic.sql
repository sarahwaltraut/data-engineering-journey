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