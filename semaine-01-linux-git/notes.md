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