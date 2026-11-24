CREATE TABLE commandes_brutes (
    id INTEGER,
    statut TEXT,
    montant DECIMAL(10, 2),
    charge_le TIMESTAMP
);

INSERT INTO commandes_brutes VALUES
(1, 'en_cours', 45.00, '2026-09-01 08:00:00'),
(1, 'livree', 45.00, '2026-09-03 08:00:00'),
(2, 'en_cours', 40.00, '2026-09-01 08:00:00'),
(3, 'en_cours', 80.00, '2026-09-02 08:00:00'),
(3, 'livree', 80.00, '2026-09-04 08:00:00'),
(3, 'livree', 80.00, '2026-09-04 08:00:00'),
(4, 'annulee', 45.00, '2026-09-03 08:00:00');