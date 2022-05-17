# Étape 3 - Synchronisons Joomla avec notre ordinateur local

<!-- .slide: data-background="./images/background.jpg" data-background-size="cover" -->

----

Nous venons d'installer Joomla, on a pu installer l'une ou l'autre version de Joomla mais on constate que nous n'avons rien en local : si on supprime le container, on perds tout.

Bien sûr, on peut installer une extension de sauvegarde comme Akeeba et s'amuser à prendre un backup; comme on le fait traditionnellement.

On peut aussi veiller à synchroniser notre container (la partie Joomla ainsi que la partie base de données) avec notre disque dur. Cette synchronisation fait appel à ce qu'on nomme dans le monde Docker : **un volume**.

----

Un volume peut être "interne" ou "externe". Interne veut dire que c'est Docker qui va le gérer et que si on supprime le container, on va également perdre nos données ce qui n'est pas ce que l'on souhaite.

On va vouloir "mapper" le site Joomla à notre disque dur. Quand nous avions lancé une session interactive (grâce à `docker exec -it step_2_install_joomla-joomla-1 /bin/bash`), nous avions constaté que le dossier du site était `/var/www/html`. Ce dossier est le `WORKDIR` (répertoire de travail) de l'image Joomla. On peut retrouver cette information dans la documentation de l'image, après avoir lancé une session interactive ou encore lorsqu'on fait un `docker inspect joomla | grep --ignore-case "workingdir"`.

----

Il suffit d'adapter le fichier `docker-compose.yml` et, pour le service Joomla, d'ajouter la gestion des *volumes*. Nous allons faire correspondre le dossier `site_joomla` de notre ordinateur avec le site Joomla.

**D'abord, pour éviter tout problème de droits d'accès, veuillez créer le dossier `site_joomla` vous même.**

```bash
mkdir -p site_joomla
```

Adaptons le fichier `docker-compose.yml` et ajoutons: 

```yml
    volumes:
      - ./site_joomla:/var/www/html
```

----

La lecture est peut-être plus aisée de droite à gauche : on va faire correspondre le dossier `/var/www/html` qui se trouve dans le container Docker avec le dossier `site_joomla` se trouvant dans notre répertoire actuel; sur notre machine (=sur notre host).

Si on relance la commande `docker compose up --detach`; on pourra constater qu'on aura bien, lors de la création de l'image, les fichiers de Joomla qui seront synchronisés avec notre disque dur.

## Étape 3.1 - Droits d'accès sous Linux

Tout comme nous l'avons vu précédement, les fichiers / dossiers créés depuis Docker ne le sont pas avec notre utilisateur actif mais celui définit dans l'image. Pour PHP, nous l'avons vu, c'était l'utilisateur `root`.

Pour Joomla, c'est `www-data` et on le voit lorsqu'on fait un `ls -al`. Il nous faut, ici aussi, changer cela pour utiliser notre utilisateur local.

Tout d'abord supprimons le précédent dossier `site_joomla` puis recréons-le (afin d'avoir les bonnes permissions):

```bash
sudo rm -rf site_joomla
mkdir -p site_joomla
```

----

Adaptons le fichier `docker-compose.yml` et pour y ajouter la notion de l'utilisateur mais pour cela il nous faudra deux valeurs, le `user id` et le `group id`.

Sous Linux, on peut retrouver l'ID de son utilisateur et de son groupe comme ceci: `echo "Votre UID est $UID et votre GID est $GID"`. Nous avons nos valeurs. Adaptons le fichier:

```yml
    user: "1000:1000"
```

Relançons `docker compose up --detach` et, maintenant, les fichiers dans le dossier `site_joomla` ont les bonnes permissions; celles de votre utilisateur local.

## Étape 3.2 - Ajout d'une image

Si l'on ajoute une image depuis le gestionnaire des médias, on constatera que l'image s'ajoute bien dans le dossier `./site_web/media`, comme attendu.

## Étape 3.3 - Installation d'Akeeba backup et sauvegarde

L'installation d'une extension ainsi que son utilisation n'est en rien différente. On peut installer Akeeba depuis le web puis lancer une sauvegarde. Si on utilise le profil par défaut, le `jpa` est sauvé dans le dossier `./site_joomla/administrator/com_akeebabackup/backup`; rien ne change.

----

<!-- .slide: data-background="./images/we-have-learned.jpg" data-background-size="cover" -->

À la fin de ce chapitre, nous avons appris :

* synchroniser les fichiers de Joomla avec notre dique dur.

Si nous supprimons le container Joomla, nous n'allons plus perdre les fichiers de notre site web. Mais nous perdrons bien la base de données puisqu'elle n'est pas encore synchronisée localement. C'est ce que nous allons apprendre dans le prochain et dernier chapitre.
