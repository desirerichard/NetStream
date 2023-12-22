### Dictionnaire de données

- [ ] Dictionnaire réalisé
---

### MERISE

- [ ] MCD
- [ ] MLD
- [ ] MPD

#### Structure de la base de donnée :

- [ ] Les films :

> Un film comporte un titre, un ou plusieurs acteurs, un réalisateur, une durée et l'année de sa sortie.

- [ ] Les acteurs, actrices :

> Nom, prénom, rôle et date de naissance.

- [ ] Les réalisateurs :

> Nom et prénom.

- [ ] Les utilisateurs :

> Nom, prénom, email, mot de passe, rôle et liste des films préférés.
---

### Environnement docker

- [ ] Fichier docker_compose.yml
- [ ] Un fichier permettant de générer la bdd (incluant quelques données)
- [ ] Déploiement de l'image docker
- [ ] Connection à la base de donnée avec un Client SQL
- [ ] Datas dans la database à la connection
---

### Contraintes

- [ ] Un trigger doit être mis en place, également appelé déclencheur
- [ ] Seul l'administrateur de la BDD pourra ajouter, modifier ou supprimer des données.
- [ ] Pour chaque entrée dans la base de données, il y aura la date de création et de modification.
---

### Les requêtes (A placer dans le README.md):

- [ ] Les titres et dates de sortie des films du plus récent au plus ancien
- [ ] Les noms, prénoms et âges des acteurs/actrices de plus de 30 ans dans l'ordre alphabétique
- [ ] La liste des acteurs/actrices principaux pour un film donné
- [ ] La liste des films pour un acteur/actrice donné
- [ ] Ajouter un film
- [ ] Ajouter un acteur/actrice
- [ ] Modifier un film
- [ ] Supprimer un acteur/actrice
- [ ] Afficher les 3 derniers acteurs/actrices ajouté(e)s
---

### Nous avons aussi besoin de manipulations avancées:

- [ ] Lister grâce à une procédure stockée les films d'un réalisateur donné en paramètre
- [ ] Garder grâce à un trigger une trace de toutes les modifications apportées à la table des utilisateurs. Ainsi, une table d'archive conservera la date de la mise à jour, l'identifiant de l'utilisateur concerné, l'ancienne valeur ainsi que la nouvelle.
---

### Repo Github

- [ ] MCD
- [ ] MLD
- [ ] MPD
- [ ] Dictionnaire de données
- [ ] docker_compose.yml
- [ ] script.sql
- [ ] README.md
- [ ] Les requêtes dans le README.md