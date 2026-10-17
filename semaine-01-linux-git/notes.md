# JOUR 1

![alt text](image.png)
Commande       |	Ce qu’elle fait	| Moyen de s’en souvenir
pwd	           | affiche où je suis	| print working directory
ls	           | liste le contenu du dossier | list
ls -l	       | liste en détail (taille, date, droits)	| long
ls -a	       | liste aussi les fichiers cachés (ceux qui commencent par un point)	|all
cd             | dossier	entre dans un dossier	| change directory
cd ..	       | remonte d’un niveau	
cd ~ ou cd     |	retourne dans ton dossier personnel	
cd -	       | retourne dans le dossier précédent	comme le bouton « retour »
mkdir -p a/b/c |	crée des dossiers, y compris les intermédiaires	| make directory, parents
clear	       |efface l’écran	

---------------------------------------------------------------------------------------------

Tu es dans /home/sarah/formation/semaine1/notes. 

- Après cd .., que renvoie pwd ?: /home/sarah/formation/semaine1
- Depuis notes, après cd ../../semaine2, où es-tu ? /home/sarah/formation/semaine2
- Quelle est la différence entre cd ~ et cd / ? cd~ me ramène dans mon dossier personnel or cd/ dans le dossier racine.
- Lesquels de ces chemins sont absolus, lesquels relatifs : /home/stevi/formation : absolu, semaine1/notes: relatif, ../semaine2: relatif, ~/formation: absolu ?
- Ton dépôt Git contient un dossier .git et un fichier .gitignore. Pourquoi ne les vois-tu pas avec un simple ls ? Parce que ls ne permet pas d'afficher des fichiers cachés. Il faudrait plutôt ls -a.
- Pourquoi rien ne s’affiche quand tu tapes ton mot de passe avec sudo ? c'est une mesure de sécurité linux.
 --------------------------------------------------------------------------------------------

# JOUR 2

Exercice 4 : écrire dans des fichiers
Dans ~/formation/semaine1/notes, crée un journal avec echo :
bash
   echo "# Journal semaine 1" > journal.md
   echo "Jour 1 : installation de WSL, navigation avec cd et ls" >> journal.md
   echo "Jour 2 : cp, mv, rm, head, tail" >> journal.md
   cat journal.md
Ajoute une 4ᵉ ligne avec nano : la phrase que tu retiens le plus de la journée.
Expérience volontaire : tape echo "oups" > journal.md, puis cat journal.md. Que s’est-il passé ?: tout le texte qui était écrit dans le journal est écrasé par "oups".

-------------------------------------------------------------------------------------------

Exercice 5 : head et tail sur un plus gros fichier
bash
cd ~/formation
seq 1 100 > nombres.txt

seq 1 100 génère les nombres de 1 à 100, un par ligne, et > les écrit dans un fichier.

Affiche les 5 premières lignes, puis les 5 dernières. head / tail -n 5 nombres.txt
Défi : affiche uniquement les lignes 51 à 55. Tu as droit à head, tail et >, mais à rien d’autre. Indice : tu peux passer par un fichier temporaire. N’oublie pas de supprimer ce fichier temporaire ensuite.
Je crée le fichier temporaire qui contient les 50 dernières lignes du fichier nombre.txt et en ensuite j'affiche les 5 premières lignes de ce fichier temporaire avec Head -n 5.

4. Le quiz : prédire sans exécuter (15 min)
Que fait mv rapport.txt rapport_2026.txt ? Renomme rapport.txt en rapport_2026.txt .
Quelle différence y a-t-il entre cp brut/ventes.csv propre/ et mv brut/ventes.csv propre/ ? Laquelle respecte la règle d’or du data lake ? cp copie et mv déplace. C'est cp qui respecte la règle d'or.
Pourquoi rm mon_dossier échoue-t-il, alors que rm -r mon_dossier fonctionne ? Parce qu'il faut le -r pour indiquer que c'est un dossier. rm tout court c'est pour les fichiers.
Qu’affiche ce qui suit ? Et que changerait le remplacement du deuxième > par >> ? ca affiche b et si on change > par >>, ça affiche a b.
bash
   echo "a" > f.txt
   echo "b" > f.txt
   cat f.txt
Qu’est-ce que head -n 1 ventes.csv affiche, et pourquoi est-ce utile ? ça affiche la 1èere ligne c'est à dire l'en-tête du fichier avec les noms de colonne. Ca permet de savoir la structure du fichier sans avoir à afficher tout le fichier, ce qui peut être embêtant quand le fichier est volumineux.
Ton collègue tape rm -rf ~ /formation/data/brut. Que se passe-t-il exactement ? Ca supprime tous les dossiers du chemin sans demander une vérification.
Que liste ls data/*/*.csv ? ça liste tous les fichiers du dossier data qui ont l'extension .csv.

---------------------------------------------------------------------------------------------
# JOUR 3

Niveau 1 : compter et chercher
Combien de lignes le fichier commandes.csv contient-il au total ? Combien de commandes, c’est-à-dire sans l’en-tête ? wc -l commandes.csv puis tail -n +2 commandes.csv | wc -l
Affiche toutes les commandes annulées, puis compte-les. tail -n +2 commandes.csv | grep annulee puis tail -n +2 commandes.csv | grep -ci annulee
Combien de commandes viennent de Limoges ? Essaie avec grep -c Limoges, puis avec grep -ci limoges. Pourquoi les résultats diffèrent-ils ? Les résultats sont différents parce que la première commande est sensible à la casse donc les lignes où limoges est écrit avec L majuscule ne sont pas comptées.
Combien de commandes ne sont pas livrées ? tail -n +2 commandes.csv | grep -cvi livree


Niveau 2 : découper et trier
Affiche la liste des villes distinctes, sans l’en-tête. Que remarques-tu ? cut -d',' -f4 commandes.csv | tail -n +2 | sort | uniq . Je remarque que Limoges apparait deux fois à cause de la casse.
Affiche le nombre de commandes par ville, du plus grand au plus petit. cut -d',' -f4 commandes.csv | tail -n +2 | sort | uniq -c | sort -rn
Combien de clients différents ont passé commande ? cut -d',' -f3 commandes.csv | tail -n +2 | sort | uniq -c | wc -l
Affiche les 3 commandes avec les plus grosses quantités. Regarde bien le résultat : quel problème vois-tu ? tail -n +2 commandes.csv | sort -t',' -k7 -rn | head -n 3 . Le problème est qu'on a la même commande deux fois.


Niveau 3 : le détective
Trouve la (ou les) lignes en double dans commandes.csv. tail -n +2 commandes.csv | sort -t ',' -k1 -n | uniq -d
Dans pipeline.log : combien y a-t-il d’erreurs (ERROR), et à quelles lignes ?  grep -c ERROR pipeline.log puis  grep -n ERROR pipeline.log
Affiche toutes les lignes du log qui ne sont pas des INFO, c’est-à-dire les alertes et les erreurs. grep -v INFO pipeline.log
Enregistre les erreurs dans un fichier erreurs.txt, puis ajoute les avertissements (WARNING) à ce même fichier, sans effacer les erreurs. Vérifie avec cat. grep ERROR pipeline.log > erreurs.txt puis grep WARNING pipeline.log >> erreurs.txt

Reprends le défi d’hier, les lignes 51 à 55 de ~/formation/nombres.txt, mais cette fois en une seule ligne et sans fichier temporaire.

5. La réflexion (10 min)

Réponds en quelques phrases :

Quels sont les deux problèmes de qualité que tu as trouvés dans commandes.csv ? Pour chacun, quelle conséquence aurait-il sur un rapport envoyé à un directeur ? L'id de la commande n'était pas unique car il y avait un doublon. Le format de la ville n'était pas forcément le même, on avait un Limoges complètement en minuscule, ce qui n'est pas en accord avec les formats des autres villes. Il pourrait y avoir des erreurs de calculs. 

Le log contient la ligne WARNING Doublon détecté : commande 110. Fais le lien avec ce que tu as trouvé à la question 9. À ton avis, à quelle étape d’un pipeline faudrait-il régler ce problème ? On devrait régler ce problème lors de la transformation des données ( T pour transform)Dépôt déplacé dans WSL le 2026-10-17
