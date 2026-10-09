# fonction moyenne(liste) qui renvoie la moyenne d’une liste de nombres, et None si la liste est vide.

def moyenne (liste) :
    if liste != [] :
        somme = 0
        for nbre in liste :
            somme = somme + nbre
        moy = somme / len(liste)
    else :
        moy = "None"  
    return moy

print (moyenne([10, 20, 30]) )    

# fonction compter_mots(phrase) qui renvoie un dictionnaire {mot: nombre d'apparitions}, sans tenir compte des majuscules

def compter_mots(phrase) :
    phrase = phrase.lower()
    mots = phrase.split(' ')
    dictionnaire = dict()
    for mot in mots :
        dictionnaire[mot] = dictionnaire.get(mot, 0) + 1
    return dictionnaire

print(compter_mots("La data est la base de la data"))

# Avec le module csv (et non pandas, pour l’instant), lis ventes.csv et affiche le nombre de lignes de données.

fichier = open("ventes.csv")
print(fichier)