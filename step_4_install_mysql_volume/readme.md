# Étape 4 - Synchronisons MySQL avec notre ordinateur local

<!-- .slide: data-background="./images/background.jpg" data-background-size="cover" -->

----

Nous venons de voir comment conserver les fichiers de Joomla sur son disque dur. Ainsi, si on supprime le container Docker, on ne perds pas nos fichiers.

Oui mais ? On perds la base de données puisque nous n'avons pas utilisé de volume pour, la même raison, garder trace de notre base de données si on supprime le container.

Lire "Where to Store Data" sur [https://hub.docker.com/_/mysql](https://hub.docker.com/_/mysql)

----

Comme nous l'avions fait pour Joomla lorsqu'on a créé un dossier `site_joomla`, il nous faudra créer un dossier `db` manuellement afin qu'on n'ait pas de souci de droits d'accès.

Ceci fait, il faut adapter le fichier `docker-compose.yml` et, pour le service MySQL cette fois, d'ajouter la gestion des *volumes*. Ajoutons directement le bon utilisateur:

**D'abord, pour éviter tout problème de droits d'accès, veuillez créer le dossier `db` vous même.**

```bash
mkdir -p db
```

----

Adaptons le fichier `docker-compose.yml` et ajoutons: 

```yml
    user: "1000:1000"
    volumes:
      - ./db:/var/lib/mysql
```

Pourquoi le dossier `/var/lib/mysql` ? Car c'est celui qui est référencé par MySQL comme le lieu où sont sauvegardé les données.

----

Lançons la commande `docker compose up --detach`.

Maintenant, si nous allons dans le dossier `./db`, nous pouvons en effet voir un dossier qui correspond à notre base de données.

Ajoutons les données d'exemples et p.ex. un nouvel utilisateur puis, depuis Docker Desktop, supprimons le container comme nous l'avons fait pour les auttres exercices.

----

Cette fois, tuons le site web : allons dans Docker Desktop et supprimer le container qui contient notre site web. Nous n'allons pas seulement l'arrêter mais bien le supprimer. 

Si nous n'avions pas fait de synchronisation (utilisation de volumes en terme Docker), nous aurions tout perdu. Mais maintenant, qu'en est-il ? 

Relançons la commande `docker compose up --detach` et voyons ce qu'il se passe...

----

Nous récupérons notre site web, base de données comprises ! Notre site est de nouveau fonctionnel, les extensions que nous avions installés sont toujours présentes, nos articles, nos utilisateurs, ... tout est à nouveau là.

Ceci parce que nous avons, cette fois, créer un volume externe (et donc persistant) et pour le site et pour la base de données.


----

<!-- .slide: data-background="./images/we-have-learned.jpg" data-background-size="cover" -->

À la fin de ce dernier chapitre, nous avons appris :

* à manipuler Docker et créer des sites web PHP / Apache,
* à installer Joomla et de créer un site web "dockerisé" (=qui tourne sous forme de container dans Docker),
* à synchroniser les fichiers et la base de données de notre site.
