import csv
import json
from datetime import datetime
from pathlib import Path
from j1_fondamentaux import normaliser_ville
from j2_fichiers import lire_csv, ecrire_json

DOSSIER_DATA = Path(__file__).parent / "data"
STATUTS_VALIDES = {"livree", "en_cours", "annulee"}

def convertir_entier(valeur):
    try:
        return int(valeur)
    except(ValueError, TypeError):
        return None

# print(convertir_entier(None))

def convertir_decimal(valeur):
    try:
        return float(valeur.replace(",", "."))
    except (ValueError, AttributeError):
        return None

# print(convertir_decimal("18,3"))

def date_valide(texte):
    try:
        datetime.strptime(texte, "%Y-%m-%d")
        return True
    except (ValueError, TypeError):
        return False

# print(date_valide("20264-05-26"))

def valider_commande(ligne):
    id_commande = convertir_entier(ligne["id"])
    if id_commande is None:
        return None, "id invalide"

    if not date_valide(ligne["date"]):
        return None, "date invalide"

    quantite = convertir_entier(ligne["quantite"])
    if quantite is None or quantite <= 0:
        return None, "quantite invalide"

    # Règle 4 : le prix (inspire-toi de la règle 3)
    prix = convertir_decimal(ligne["prix"])
    if prix is None or prix <= 0:
        return None, "prix invalide"

    # Règle 5 : la ville
    ville = normaliser_ville(ligne["ville"])
    if ville is None:
        return None, "ville manquante"

    # Règle 6 : le statut (indice : le mot-clé « not in »)
    if ligne["statut"] not in STATUTS_VALIDES:
        return None, "statut inconnu"

    # Tout est valide : on construit la commande typée
    commande = {
        "id": id_commande,
        "date": ligne["date"],
        "client" : ligne["client"],
        "ville": ville,
        "produit": ligne["produit"],
        "categorie": ligne["categorie"],
        "quantite": quantite,
        "prix": prix,
        "statut": ligne["statut"]
    }
    return commande, None

def nettoyer(lignes):
    valides = []
    rejets = []
    ids_vus = set()                 # les identifiants des commandes déjà acceptées

    for ligne in lignes:
        commande, raison = valider_commande(ligne)

        # Si la ligne est valide mais que son id a déjà été vu, c'est un doublon
        if raison is None and commande["id"] in ids_vus:
            raison = "doublon"

        if raison is not None:
            rejets.append({"ligne": ligne, "raison": raison})
            continue

        ids_vus.add(commande["id"])             # on retient l'id de la commande acceptée
        valides.append(commande)

    return valides, rejets

def ca_livre(commandes):
    total = 0
    for commande in commandes:
        if commande["statut"] == "livree":
            total += commande["quantite"] * commande["prix"]
    return round(total, 2)

# ---------- Pipeline de nettoyage ----------
chemin_source = DOSSIER_DATA / "commandes_sales.csv"
if not chemin_source.exists():
    raise FileNotFoundError(f"Fichier source introuvable : {chemin_source}")

lignes = lire_csv(chemin_source)
valides, rejets = nettoyer(lignes)

ecrire_json(valides, DOSSIER_DATA / "commandes_propres.json")
ecrire_json(rejets, DOSSIER_DATA / "rejets.json")

print(f"{len(lignes)} lignes lues : {len(valides)} valides, {len(rejets)} rejetées")
print(f"CA des commandes livrées : {ca_livre(valides)} €")

# ---------- Tests ----------
assert convertir_entier("3") == 3
assert convertir_entier(" 4 ") == 4
assert convertir_entier("") is None
assert convertir_entier("abc") is None
assert convertir_entier("2.5") is None
assert convertir_entier(None) is None

assert convertir_decimal("12.5") == 12.5
assert convertir_decimal("79,90") == 79.9
assert convertir_decimal("") is None
assert convertir_decimal("abc") is None
assert convertir_decimal(None) is None

assert date_valide("2026-10-01") is True
assert date_valide("2026-13-05") is False
assert date_valide("2026-02-30") is False
assert date_valide("17/10/2026") is False
assert date_valide("") is False

lignes = lire_csv(DOSSIER_DATA / "commandes_sales.csv")
assert len(lignes) == 14

commande, raison = valider_commande(lignes[1])
assert raison is None
assert commande["ville"] == "Paris"
assert commande["prix"] == 79.9

assert valider_commande(lignes[2]) == (None, "quantite invalide")

valides, rejets = nettoyer(lignes)
assert [c["id"] for c in valides] == [201, 202, 209, 210, 213]
assert len(rejets) == 9
assert [r["raison"] for r in rejets] == [
    "quantite invalide", "prix invalide", "date invalide", "ville manquante",
    "quantite invalide", "statut inconnu", "doublon", "id invalide", "date invalide",
]

print("Tous les tests du jour 3 passent ✅")