# Étape 3 - Synchronisons Joomla avec notre ordinateur local

<!-- .slide: data-background="./images/background.jpg" data-background-size="cover" -->

----

> Soyez certain d'être dans le sous-dossier step_3_install_joomla_volume pour exécuter les exemples fournis.

Nous venons d'installer Joomla, on a pu installer l'une ou l'autre version de Joomla mais on constate que nous n'avons rien en local : si on supprime le container, on perd tout.

----

<!-- .slide: data-background="./images/kill_container.png" data-background-size="cover" -->

Retournons dans Docker Desktop et supprimons le container. Affichons à nouveau le site `http://127.0.0.1:80/`, nous avons tout perdu !

----

Bien sûr, on peut installer une extension de sauvegarde comme Akeeba et s'amuser à prendre un backup; comme on le fait traditionnellement.

On peut aussi veiller à synchroniser notre container (la partie Joomla ainsi que la partie base de données) avec notre disque dur. Cette synchronisation fait appel à ce qu'on nomme dans le monde Docker : **un volume**.

----

Un volume peut être "interne" ou "externe". Interne veut dire que c'est Docker qui va le gérer.

On pourra supprimer le container Joomla mais tant qu'on ne supprime pas le volume interne, il reste en mémoire et Docker peut le réutiliser.

Si on supprime et le container et le volume alors on perd tout.

----

On va donc utiliser un volume externe.

On va *mapper* le site Joomla à notre disque dur. Quand nous avions lancé une session interactive (grâce à `docker exec -it 1_installation-joomla-1 /bin/bash`), nous avions constaté que le dossier du site était `/var/www/html`. Ce dossier est le `WORKDIR` (répertoire de travail) de l'image Joomla. On peut retrouver cette information dans la documentation de l'image, après avoir lancé une session interactive ou encore lorsqu'on fait un `docker inspect joomla | grep --ignore-case "workingdir"`.

----

Il faut adapter le fichier `docker-compose.yml` et, pour le service Joomla, d'ajouter la gestion des *volumes*. Nous allons faire correspondre le dossier `site_joomla` de notre ordinateur avec le site Joomla.

**D'abord, pour éviter tout problème de droits d'accès, veuillez créer le dossier `site_joomla` vous-même.**

```bash
mkdir -p site_joomla
```

Adaptons le fichier `docker-compose.yml` et ajoutons:

```yaml
    volumes:
      - ./site_joomla:/var/www/html
```

----

La lecture est peut-être plus aisée de droite à gauche : on va faire correspondre le dossier `/var/www/html` qui se trouve dans le container Docker avec le dossier `site_joomla` se trouvant dans notre répertoire actuel; sur notre machine (=sur notre host).

----

Retournons dans Docker Desktop et supprimons notre container Joomla en cours d'exécution.

Puis relançons la commande `docker compose up --detach`; on pourra constater qu'on aura bien, lors de la création de l'image, les fichiers de Joomla qui seront synchronisés avec notre disque dur.

Allez voir le contenu du dossier `site_joomla` sur votre ordinateur : nous avons l'intégralité des fichiers du site; nous avons donc synchronisé le container et notre machine.

## Étape 3.1 - Droits d'accès sous Linux

Tout comme nous l'avons vu précédemment, les fichiers / dossiers créés depuis Docker ne le sont pas avec notre utilisateur actif mais celui défini dans l'image. Pour PHP, nous l'avons vu, c'était l'utilisateur `root`.

Pour Joomla, c'est `www-data` et on le voit lorsqu'on fait un `ls -al`. Il nous faut, ici aussi, changer cela pour utiliser notre utilisateur local.

Tout d'abord, supprimons le précédent dossier `site_joomla` puis recréons-le (afin d'avoir les bonnes permissions):

```bash
sudo rm -rf site_joomla
mkdir -p site_joomla
```

----

Adaptons le fichier `docker-compose.yml` et pour y ajouter la notion de l'utilisateur, mais pour cela il nous faudra deux valeurs, le `user id` et le `group id`.

Sous Linux, on peut retrouver l'ID de son utilisateur et de son groupe comme ceci:

```bash
echo "Votre UID est $UID et votre GID est $GID"
```

Nous avons nos valeurs. Adaptons le fichier:

```yaml
    user: "1000:1000"
```

----

Retournons dans Docker Desktop et supprimons notre container Joomla en cours d'exécution.

Relançons `docker compose up --detach` et, maintenant, les fichiers dans le dossier `site_joomla` ont les bonnes permissions; celles de votre utilisateur local.

## Étape 3.2 - Ajout d'une image

Pour l'exemple, si on se rend dans le gestionnaire des médias de Joomla et qu'on ajoute une image, nous verrons bien cette image apparaître sur notre machine dans le dossier `./site_web/media`.

Notre synchronisation fonctionne parfaitement (et dans les deux sens bien sûr).

## Étape 3.3 - Installation d'Akeeba backup et sauvegarde

L'installation d'une extension ainsi que son utilisation n'est en rien différente. 

Depuis l'interface d'administration de Joomla, on peut installer Akeeba *depuis le web* et exécuter ensuite une sauvegarde. 

Si on utilise le profil par défaut, le `jpa` est sauvé, sur notre machine, dans le dossier `./site_joomla/administrator/com_akeebabackup/backup`; rien ne change.


## Étape 3.4 - Notre service Joomla final

Notre service `joomla` au complet dans le fichier `docker-compose.yml`.

```yaml
  joomla:
    image: joomla
    restart: always
    links:
      - joomladb:mysql
    ports:
      - 80:80
    environment:
      JOOMLA_DB_HOST: joomladb
      JOOMLA_DB_PASSWORD: example
    volumes:
      - ./site_joomla:/var/www/html
    user: "1000:1000"
```

----

<!-- .slide: data-background="./images/we-have-learned.jpg" data-background-size="cover" -->

À la fin de ce chapitre, nous avons appris :

* synchroniser les fichiers de Joomla avec notre disque dur.

Si nous supprimons le container Joomla, nous n'allons plus perdre les fichiers de notre site web. Mais nous perdrons bien la base de données puisqu'elle n'est pas encore synchronisée localement. C'est ce que nous allons apprendre dans le prochain et dernier chapitre.
