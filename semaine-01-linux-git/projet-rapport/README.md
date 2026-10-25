
----------------- BUT DU PROJET --------------------------------
Ecrire un script en Linux Bash qui analyse des fichiers de commandes et produit un rapport d’activité et de qualité.

--------------- COMMENT LE LANCER ------------------------------
./rapport_commandes.sh data/commandes.csv

--------------- EXEMPLE DE RAPPORT -----------------------------

===== RAPPORT DES COMMANDES =====
Fichier analysé : data/commandes.csv
Date du rapport : 2026-10-25

--- Volumes ---
Lignes (en-tête compris) : 21
Commandes : 20
Clients distincts : 10

--- Commandes par statut ---
     14 livree
      3 en_cours
      3 annulee

--- Commandes par ville ---
      6 Lyon
      5 Paris
      5 Limoges
      3 Bordeaux
      1 limoges

--- Contrôles qualité ---
ALERTE : identifiants en double : 110
ALERTE : 1 ville(s) écrite(s) en minuscules
--- Chiffre d'affaire ---
2143

-------------- SES LIMITES -----------------------------------

Le script utilise pour certaines tâches la virgule comme séparateur de colonnes. Si une virgule se situe par exemple dans un nom de client, la commande cut se trompe. Le calcul du chiffre d'affaire est également trompeur car il ignore les doublons et le statut des commandes.