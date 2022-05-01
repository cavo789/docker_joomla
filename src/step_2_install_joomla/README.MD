Lancer la commande `docker compose up --detach` et montrer qu'ensuite, directement, on peut accéder à l'URL http://127.0.0.1:80 et qu'on a l'interface d'administration.

Pourquoi le port `80`?  Expliquer la notion de port du fichier `docker-compose.yml`.

Pourquoi est-ce la version de Joomla 4.x.x ? Car il s'agit de la version qu'on a précisée (tag) pour l'image Joomla dans le fichier `docker-compose.yml`. Expliquer comment retrouver une version depuis la page [https://hub.docker.com/_/joomla?tab=tags](https://hub.docker.com/_/joomla?tab=tags) et comment installer telle ou telle version.

Ecran de configuration de la base de données : le nom du hôte n'est pas `localhost` mais `joomladb` qui est le nom qu'on a donné au service base de données dans le fichier `docker-compose.yml`. Le nom de l'utilisateur est celui par défaut `root` tandis que le mot de passe est `example` (comme défini dans le fichier `docker-compose.yml`).

Une fois le site up and running, montrer le dossier courant : nous n'avons aucun des fichiers de Joomla sur notre machine; rien du tout et expliquer que tout est resté dans le container. Montrer comment supprimer le container depuis p.ex. `Docker Desktop` 

    => supprimer le container et montrer que le site n'est plus up and running
    => démarrer à nouveau `./docker-up.sh` et montrer que nous avons en réalité perdu tout ce que nous avions fait préalablement.

Parce que nous n'avons rien synchronisé avec notre host; tout ce qu'on fait reste dans le container de Docker; rien sur notre ordinateur. Tant qu'on ne supprime pas le container; tout va bien. On peut stopper le container et le redémarrer mais si on le supprime; on perds tout.

## Session interactive

Si on lance Docker Desktop et qu'on se rends dans la liste des containers puis qu'on déplie le container en cours, on peut voir que le nom du service Apache est `step_2_install_joomla_joomla_1` (c'est-à-dire le nom du dossier en cours suivi du nom du service suivi du chiffre `1`).

On retrouve aussi le nom avec la ligne de commande `docker container list`.

Du coup `docker exec -it step_2_install_joomla_joomla_1 /bin/bash` permet de lancer une console dans le container et de se promener dans l'arborescence du l'installation Joomla.

Si on fait un `cat configuration.php`, on peut donc voir le fichier de configuration du site. Puisqu'il n'y a pas d'éditeur de texte dans l'image Joomla, utilisons `sed` pour remplacer la valeur offline de "false" vers "true" :

```bash
sed -i 's/public $offline = false/public $offline = true/g' configuration.php
```

Si on rafraîchit le navigateur, on voit bien qu'on a mis le site hors ligne. Ce qu'on voit dans la session interactive correspond bien à ce qu'on a sur la page du navigateur; nous sommes bien occupés à modifier le site Joomla.
