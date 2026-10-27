import copy

def normaliser_ville(ville):
    if ville is None or not ville.strip():
        return None
    return ville.strip().title()

assert normaliser_ville("  limoges ") == "Limoges"
assert normaliser_ville("LYON") == "Lyon"
assert normaliser_ville("saint-etienne") == "Saint-Etienne"
assert normaliser_ville("") is None
assert normaliser_ville("   ") is None
assert normaliser_ville(None) is None


# ------------------------------------------------------------

def calculer_montant(quantite, prix):
    return round(int(quantite) * float(prix), 2)


assert calculer_montant("3", "12.5") == 37.5
assert calculer_montant("3", "0.1") == 0.3

# ------------------------------------------------------------
def annuler_commandes(commandes, ids_a_annuler):
    copie = copy.deepcopy(commandes)
    for commande in copie:
        if commande["id"] in ids_a_annuler:
            commande["statut"] = "annulee"
    return copie

commandes = [{"id": 101, "statut": "livree"}, {"id": 102, "statut": "livree"}]
resultat = annuler_commandes(commandes, [102])
assert resultat[1]["statut"] == "annulee"
assert resultat[0]["statut"] == "livree"
assert commandes[1]["statut"] == "livree", "La liste d'origine a été modifiée !"

# ------------------------------------------------------------
def compter_par_ville(villes):
    compteur = {}
    for ville in villes:
        ville_propre = normaliser_ville(ville)
        if ville_propre is None :
            continue
        compteur[ville_propre] = compteur.get(ville_propre, 0 ) + 1 # 3. sinon, ajouter 1 dans le compteur (le motif .get(cle, 0) + 1 que tu connais)
    return compteur

assert compter_par_ville(["Lyon", "limoges", "Limoges ", " paris", None, ""]) == {"Lyon": 1, "Limoges": 2, "Paris": 1}

print("Tous les tests passent ")