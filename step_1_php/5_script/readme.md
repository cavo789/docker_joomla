# Étape 1.5 - Extra - Utilisation d'un script Linux

> Ce chapitre, optionnel, propose un script Bash qui nécessite Linux pour s'exécuter. Si vous êtes sous Windows (MS DOS), vous ne pourrez pas l'utiliser. Mais bien si vous êtes sous WSL.

Au tout début du chapitre, nous avons vu la commande suivante :

```bash
docker run --detach --name step_1_1a -p 80:80 php:7.4.29-apache
```

Imaginons que nous souhaitons relancer la même commande, une seconde fois :

```text
docker: Error response from daemon: Conflict. The container name "/step_1_1a" is already in use by container "dbb03c847cf13f691f75207cb61f813d34a83b1f230bc0b3a15e93361d6ff484". You have to remove (or rename) that container to be able to reuse that name.
```

----

Docker nous dit que nous avons déjà un container nommé `step_1_1` précédemment créé. Si nous changeons le nom en, p. ex. `step_1_1_bis`, nous aurons un autre souci :

```text
docker: Error response from daemon: driver failed programming external connectivity on endpoint step_1_1_bis (31dfed5214c2ebea24e059f7d4ca65c717bd0373b88d2adc4d02b67923c481ed): Bind for 0.0.0.0:80 failed: port is already allocated.
```

En effet, nous disons que `step_1_1_bis` doit utiliser le port `80` mais ce dernier est déjà utilisé (par le container `step_1_1a`), il nous faudrait alors aussi changer le numéro du port (comme nous l'avons fait à chacune des étapes précédentes).

----

En ligne de commandes, pour stopper un container:

```bash
docker stop $(docker ps -a -q --filter="name=step_1_1a")
```

Puis, pour le supprimer:

```bash
 docker rm $(docker ps -a -q --filter="name=step_1_1a")
```

Un peu long...

----

<!-- .slide: data-background="./images/docker_desktop.png" data-background-size="cover" -->

Plus facile avec Docker Dekstop, on supprime le container.

----

Le script `docker-up.sh` proposé dans ce chapitre permet de vérifier si le container est déjà en cours d'exécution. Si c'est le cas, il sera d'abord arrêté proprement puis supprimé. Et seulement ensuite récréé.

Le script permet donc de simplifier l'exécution des commandes `docker run` comme vues lors des précédents chapitres de cette première étape de découverte de Docker.

----

<!-- .slide: data-background="./images/we-have-learned.jpg" data-background-size="cover" -->

À la fin de cette dernière étape du premier chapitre de découverte, nous avons appris, en plus, à utiliser un script qui va arrêter, supprimer et relancer un container. Facile et propre.

Le script permet aussi de spécifier certaines variables comme p. ex. la version de PHP à utiliser.
