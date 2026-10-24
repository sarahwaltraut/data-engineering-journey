#!/usr/bin/env bash
# Génère un rapport d'activité et de qualité à partir d'un CSV de commandes.
# Usage : ./rapport_commandes.sh chemin/vers/commandes.csv

set -euo pipefail

# ---------- 1. Vérifier l'argument ----------
if [ $# -ne 1 ]; then
    echo "Usage : $0 chemin/vers/commandes.csv"
    exit 1
fi

FICHIER="$1"

# TODO : si "$FICHIER" n'existe pas, afficher une erreur et sortir avec le code 1


# ---------- 2. Calculs ----------
DATE_DU_JOUR=$(date +%F)
NB_LIGNES=$(wc -l < "$FICHIER")
NB_COMMANDES= tail n +2 "$FICHIER" | wc -l      # TODO : le nombre de commandes, sans l'en-tête
NB_CLIENTS= cut -d ',' -f3 "$FICHIER" |  sort | uniq | wc -l       # TODO : le nombre de clients distincts (colonne 3)
IDS_EN_DOUBLE=  cut -d ',' -f1 "$FICHIER" | uniq -d     # TODO : les identifiants en double (colonne 1)
VILLES_MINUSCULES= cut -d ',' -f4 "$FICHIER" | grep -c '^[a-z]' || true # TODO : le nombre de villes qui commencent par une minuscule (colonne 4)
                     #        indice : grep -c '^[a-z]'  (^ = début de ligne), sans oublier || true

# ---------- 3. Rapport ----------
echo "===== RAPPORT DES COMMANDES ====="
echo "Fichier analysé : $FICHIER"
echo "Date du rapport : $DATE_DU_JOUR"
echo ""
echo "--- Volumes ---"
echo "Lignes (en-tête compris) : $NB_LIGNES"
echo "Commandes : $NB_COMMANDES"
echo "Clients distincts : $NB_CLIENTS"
echo ""
echo "--- Commandes par statut ---"
# TODO : le nombre de commandes par statut (colonne 9), du plus fréquent au moins fréquent

echo ""
echo "--- Commandes par ville ---"
# TODO : le nombre de commandes par ville (colonne 4), de la plus fréquente à la moins fréquente

echo ""
echo "--- Contrôles qualité ---"
# TODO : si IDS_EN_DOUBLE est vide, afficher « OK : aucun identifiant en double »,
#        sinon « ALERTE : identifiants en double : » suivi des identifiants

# TODO : si VILLES_MINUSCULES vaut 0, afficher « OK : toutes les villes commencent par une majuscule »,
#        sinon « ALERTE : N ville(s) écrite(s) en minuscules »