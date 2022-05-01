Nous venons d'installer Joomla, on a pu installer l'une ou l'autre version de Joomla mais on constate que nous n'avons rien en local : si on supprime le container, on perds tout.

Bien sûr, on peut installer une extension de sauvegarde comme Akeeba et s'amuser à prendre un backup; comme on le fait traditionnellement.

On peut aussi veiller à synchroniser notre container (la partie Joomla ainsi que la partie base de données) avec notre disque dur. Cette synchronisation fait appel à ce qu'on nomme dans le monde Docker : un volume.

Un volume peut être "interne" ou "externe". Interne veut dire que c'est Docker qui va le gérer et que si on tue le container, on va également perdre nos données ce qui n'est pas ce que l'on souhaite.

On va vouloir "mapper" le site Joomla à notre disque dur. Quand nous avions lancé une session interactive (grâce à `docker exec -it step_2_install_joomla_joomla_1 /bin/bash`), nous avions constaté que le dossier du site était `/var/www/html`. Ce dossier est le `WORKDIR` (répertoire de travail) de l'image Joomla. On peut retrouver cette information dans la documentation de l'image, après avoir lancé une session interactive ou encore lorsqu'on fait un `docker inspect joomla | grep --ignore-case "workingdir"`.


Il suffit d'adapter le fichier `docker-compose.yml` et, pour le service Joomla, d'ajouter la gestion des *volumes*. 

```yml
    volumes:
      - ./site_joomla:/var/www/html
```

**Pour éviter tout problème de droits d'accès, veuillez créer le dossier site_joomla vous même.**

La lecture est peut-être plus aisée de droite à gauche : on va faire correspondre le dossier `/var/www/html` qui se trouve dans le container Docker avec le dossier `site_joomla` se trouvant dans notre répertoire actuel; sur notre machine (=sur notre host).

Si on relance le script `docker-up.sh`; on pourra constater qu'on aura bien, lors de la création de l'image, les fichiers de Joomla qui seront synchronisés avec notre disque dur.

## Droits d'accès sous Linux

Sous Linux, si on fait un `ls -al`, on verra que le propriétaire des fichiers est `www-data` qui est l'utilisateur utilisé par le container. Il nous faut changer cela pour utiliser notre utilisateur local.

On peut lancer la ligne de commande:

```bash
sudo chown -R christophe:christophe ./site_web
```

Maintenant, on peut modifier aisément les fichiers depuis son ordinateur en utilisant un IDE ou un éditeur tel que vscode. Si on modifie le fichier `configuration.php` pour mettre le site hors ligne ou encore modifier la variable `$debug`, c'est bien plus facile qu'aupavarant.

### Utilisation de l'utilisateur actif

Sous Linux, on peut retrouver l'ID de son utilisateur et de son groupe comme ceci: `echo "Votre UID est $UID et votre GID est $GID"`. On peut donc modifier le fichier `docker-compose.yml` et, pour le service Joomla, définir les données pour l'utilisateur à utiliser: 

```yml
    user: "1000:1000"
```

Ainsi, un fichier qui sera créé depuis Joomla utilisera le même utilisateur que si vous l'aviez créé depuis votre host.

## Ajout d'une image

Si l'on ajoute une image depuis le gestionnaire des médias, on constatera que l'image s'ajoute bien dans le dossier `./site_web/media`, comme attendu.

## Installation d'Akeeba backup et sauvegarde

L'installation d'une extension ainsi que son utilisation n'est en rien différente. On peut installer Akeeba depuis le web puis lancer une sauvegarde. Si on utilise le profil par défaut, le `jpa` est sauvé dans le dossier `./site_joomla/administrator/com_akeebabackup/backup`; rien ne change.
