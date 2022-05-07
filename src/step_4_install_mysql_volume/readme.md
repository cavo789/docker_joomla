# Étape 4 - Synchronisons MySQL avec notre ordinateur local

Nous venons de voir comment conserver les fichiers de Joomla sur son disque dur. Ainsi, si on supprime le container Docker, on ne perds pas nos fichiers.

Oui mais ? On perds la base de données puisque nous n'avons pas utilisé de volume pour, la même raison, garder trace de notre base de données si on supprime le container.

Lire "Where to Store Data" sur [https://hub.docker.com/_/mysql](https://hub.docker.com/_/mysql)

Comme nous l'avions fait pour Joomla lorsqu'on a créé un dossier `site_joomla`, il nous faudra créer un dossier `db` manuellement afin qu'on n'ait pas de souci de droits d'accès.

Ceci fait, il faut adapter le fichier `docker-compose.yml` et, pour le service MySQL cette fois, d'ajouter la gestion des *volumes*. Ajoutons directement le bon utilisateur:

```yml
    user: "1000:1000"
    volumes:
      - ./db:/var/lib/mysql
```

Pourquoi le dossier `/var/lib/mysql`? Car c'est celui qui est référencé comme là où sont stockés les données.

Relançons le script `./docker-up.sh`.

Maintenant, si nous allons dans le dossier `./db`, nous pouvons en effet voir un dossier qui correspond à notre base de données.

Ajoutons les données d'exemples et p.ex. un nouvel utilisateur puis, depuis Docker Desktop, supprimons le container comme nous l'avons fait pour les auttres exercices.

Relançons le script `./docker-up.sh`

Contrairement à ce qu'on a toujours eu càd qu'il nous fallait réinstaller Joomla; cette fois, nous avons retrouvé notre site ! Notre site est de nouveau fonctionnel, les extensions que nous avions installés sont toujours présentes, nos articles, nos utilisateurs, ... tout est à nouveau là.

Ceci parce que nous avons, cette fois, créer un volume externe (et donc persistant) et pour le site et pour la base de données.


----

À la fin de ce dernier chapitre, nous avons appris :

* à installer la version que nous voulions de Joomla et de créer notre site web,
* synchroniser les fichiers de Joomla avec notre dique dur,
* synchroniser la base de données du site avec notre disque dur.
