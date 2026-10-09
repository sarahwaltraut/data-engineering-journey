# fonction moyenne(liste) qui renvoie la moyenne d’une liste de nombres, et None si la liste est vide.

def moyenne (liste) :
    if not liste :
        return None
    return sum(liste) / len(liste)

print (moyenne([10, 20, 30]) )    

# fonction compter_mots(phrase) qui renvoie un dictionnaire {mot: nombre d'apparitions}, sans tenir compte des majuscules

def compter_mots(phrase) :
    phrase = phrase.lower()
    mots = phrase.split()
    dictionnaire = {}
    for mot in mots :
        dictionnaire[mot] = dictionnaire.get(mot, 0) + 1
    return dictionnaire

print(compter_mots("La data est la base de la data"))

# Avec le module csv (et non pandas, pour l’instant), lis ventes.csv et affiche le nombre de lignes de données.

import csv

with open("ventes.csv", encoding = 'utf-8', newline = "") as f:
    lecteur = csv.DictReader(f)
    liste = list(lecteur)

print(len(liste))
print(liste[0])