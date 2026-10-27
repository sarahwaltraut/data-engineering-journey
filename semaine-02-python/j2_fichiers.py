import csv
import json
from pathlib import Path
from j1_fondamentaux import normaliser_ville

DOSSIER_DATA = Path(__file__).parent / "data"

def lire_csv(chemin):
    with open ( chemin, encoding="utf-8", newline="") as f:
        lecteur = csv.DictReader(f)
        return list(lecteur)
    

print(lire_csv(DOSSIER_DATA / "commandes.csv")[0])

def ecrire_csv(lignes, chemin):
    with open ( chemin, "w" , encoding="utf-8", newline = "") as f:
        writer = csv.DictWriter(f, fieldnames = list(lignes[0].keys()))
        writer.writeheader()
        writer.writerows(lignes)

lignes = lire_csv(DOSSIER_DATA / "commandes.csv")
ecrire_csv(lignes, DOSSIER_DATA/"question2.csv")

def ecrire_json(donnees, chemin) :
    with open ( chemin, "w", encoding="utf-8", newline ="") as f:
        json.dump(donnees, f, indent= 2, ensure_ascii= False)

def lire_json(chemin) :
    with open ( chemin, encoding="utf-8", newline ="") as f:
        return json.load(f)

ecrire_json(lignes, DOSSIER_DATA / "commandes.json")
assert lire_json(DOSSIER_DATA / "commandes.json") == lignes 

def typer_commande(ligne) :
    return{
        "id": int(ligne["id"]), 
         "date" : ligne["date"],
         "client" : ligne["client"],
         "ville": normaliser_ville(ligne["ville"]),
         "produit": ligne["produit"],
         "categorie": ligne["categorie"],
         "quantite": int(ligne["quantite"]),
         "prix": float(ligne["prix"]),
         "statut": ligne["statut"]
    }

lignes = lire_csv(DOSSIER_DATA / "commandes.csv")
print(typer_commande(lignes[10]))

def ca_par_ville(commandes):
    resultat = {}
    for commande in commandes:
        ville = commande["ville"]                   # la ville de cette commande
        montant = commande["quantite"] * commande["prix"]                  # sa quantité multipliée par son prix
        resultat[ville] = resultat.get(ville, 0) + montant

    for ville in resultat :
        resultat[ville] = round(resultat[ville], 2)
    return resultat

commandes = [typer_commande(ligne) for ligne in lignes]
print(ca_par_ville(commandes))

# ---------- Mini-pipeline ----------

# 1. Extraire
lignes = lire_csv(DOSSIER_DATA / "commandes.csv")

# 2. Transformer
commandes = [typer_commande(ligne) for ligne in lignes]

# 3. Charger
ecrire_json(commandes, DOSSIER_DATA / "commandes.json")

# 4. Résumer
resume = {
    "nb_commandes": len(commandes),          
    "ca_par_ville": ca_par_ville(commandes),           
}
ecrire_json(resume, DOSSIER_DATA / "resume.json")

print("Pipeline terminé ")