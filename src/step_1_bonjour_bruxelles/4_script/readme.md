# Utilisation d'un script Linux

> Ce chapitre, optionnel, propose un script Bash qui nécessite Linux pour s'exécuter. Si vous êtes sous Windows (MS DOS), vous ne pourrez pas l'utiliser. Mais bien si vous êtes sous WSL.

Au tout début du chapitre, nous avons vu la commande suivante :

```bash
docker run --detach --name step_1_1 -p 80:80 php:7.4.29-apache
```

Imaginons que nous souhaitons relancer la commande, une seconde fois :

```text
docker: Error response from daemon: Conflict. The container name "/step_1_1" is already in use by container "dbb03c847cf13f691f75207cb61f813d34a83b1f230bc0b3a15e93361d6ff484". You have to remove (or rename) that container to be able to reuse that name.
```

----

Docker nous dit que nous avons déjà un container nommé `step_1_1` précédement créé. Si nous changeons le nom en, p.ex. `step_1_1_2`, nous aurons un autre souci :

```text
docker: Error response from daemon: driver failed programming external connectivity on endpoint step_1_1_2 (8e97c936fecd27c4f40c7c8c1781cdafe8ab9627fc380ac8dddf72921ffe8673): Bind for 0.0.0.0:80 failed: port is already allocated.
```

En effet, nous disons que `step_1_1_2` doit utiliser le port `80` mais ce dernier est déjà utilisé (par le container `step_1_1`), il nous faudrait alors aussi changer le numéro du port (comme nous l'avons fait à chacune des étapes précédentes).

----

Le script `docker-up.sh` proposé dans ce chapitre permet de vérifier si le container est déjà en cours d'exécution. Si c'est le cas, il sera d'abord arrêté proprement puis supprimé. Et seulement ensuite récréé.

Le script `docker-up.sh` permet donc de simplifier l'exécution des commandes `docker run` comme vues lors des précédents chapitres.

À la fin de ce dernier chapitre, nous avons appris, en plus, à utiliser un script qui va arrêter, supprimer et relancer un container.

Le script permet aussi de spécifier certaines variables comme p.ex. la version de PHP à utiliser.
