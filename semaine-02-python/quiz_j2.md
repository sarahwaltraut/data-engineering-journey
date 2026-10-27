Une ligne lue avec DictReader contient "quantite": "2". Que vaut ligne["quantite"] + ligne["quantite"] ? 22
Qu’affiche print(json.dumps({"a": None, "b": True})) ? [{"a": null, "b": true}]
Que vaut json.loads('{"prix": 12.5, "tags": ["promo"]}')["tags"][0] ? Et de quel type est la valeur associée à "prix" ? ["promo"] et prix est de type float.
Le fichier rapport.csv existe et contient 100 lignes. Que se passe-t-il si tu l’ouvres avec open("rapport.csv", "w") ? Il écrase toutes les lignes du fichier.
Tu enregistres {"coords": (1, 2)} en JSON, puis tu le relis. Obtiens-tu exactement le même objet ? Pourquoi ? Oui car le json gère les liste imbriquées dans les dictionnaires.
Pourquoi Path(__file__).parent / "data" est-il plus fiable que "data" tout court ? Parce que avec "data" on est conditionné à n'exécuter le code que dans le dossier des données sinon python ne trouvera pas le chemin.
