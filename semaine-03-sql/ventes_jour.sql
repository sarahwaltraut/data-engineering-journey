CREATE TABLE ventes_quotidiennes (
    jour DATE,
    magasin TEXT,
    ca DECIMAL(10, 2)
);

INSERT INTO ventes_quotidiennes VALUES
('2026-11-02', 'Limoges', 120), ('2026-11-02', 'Lyon', 300),
('2026-11-03', 'Limoges', 150), ('2026-11-03', 'Lyon', 280),
('2026-11-04', 'Limoges', 90),  ('2026-11-04', 'Lyon', 350),
('2026-11-05', 'Limoges', 200), ('2026-11-05', 'Lyon', 320),
('2026-11-06', 'Limoges', 180), ('2026-11-06', 'Lyon', 250),
('2026-11-07', 'Limoges', 60),  ('2026-11-07', 'Lyon', 400),
('2026-11-08', 'Limoges', 210), ('2026-11-08', 'Lyon', 380),
('2026-11-09', 'Limoges', 230), ('2026-11-09', 'Lyon', 300),
('2026-11-10', 'Limoges', 170), ('2026-11-10', 'Lyon', 420),
('2026-11-11', 'Limoges', 190), ('2026-11-11', 'Lyon', 390);