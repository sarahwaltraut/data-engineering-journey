CREATE TABLE livraisons (
    id INTEGER,
    commande_id INTEGER,
    date_expedition DATE,
    date_livraison DATE,
    transporteur TEXT
);

INSERT INTO livraisons VALUES
(1, 1, '2026-09-01', '2026-09-03', 'Colissimo'),
(2, 2, '2026-09-02', '2026-09-03', 'Chronopost'),
(3, 3, '2026-09-02', '2026-09-08', 'Colissimo'),
(4, 4, '2026-09-04', '2026-09-06', NULL),
(5, 5, '2026-09-05', NULL, 'Chronopost'),
(6, 6, '2026-09-07', '2026-09-12', 'Colissimo'),
(7, 7, '2026-09-10', '2026-09-11', 'Chronopost'),
(8, 8, '2026-09-12', NULL, 'Colissimo'),
(9, 9, '2026-09-15', '2026-09-17', NULL),
(10, 10, '2026-09-21', '2026-09-26', 'Chronopost');