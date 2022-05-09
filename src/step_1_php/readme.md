# Étape 1 - Découvrons Docker grâce à PHP

Grâce à Docker, il n'est plus nécessaire d'installer PHP ou Apache pour faire tourner un site web.

On retrouve sur [Docker Hub](https://hub.docker.com) un très grand nombre "d'images" qui permettent d'exécuter des logiciels comme PHP, PHP+Apache,MySQL et bien, bien d'autre choses. 

----

Toutes ces images sont totalement gratuites; elles peuvent être publiques ou privées. On peut créer ses propres images et les stocker sur Docker Hub gratuitement. 

Nous allons utiliser une image PHP; disponible sur [https://hub.docker.com/_/php](https://hub.docker.com/_/php)

----

Durant cette première étape, de découverte, nous allons exécuter un simple script PHP, un "Hello World", pour montrer comment ... ne pas installer PHP et Apache. 

Nous changerons ensuite la version de PHP de `7.4` vers `8.1` en juste quelques ... touches enfoncées au clavier.

----

Nous avons besoin d'une seule image (PHP+Apache) pour faire tourner notre script. Nous utiliserons les instructions `docker run`.

*Dans la seconde étape, nous aurons besoin d'une image pour la base de données (MySQL ou Postgres). Nous aurons alors besoin d'un fichier `docker-compose.yml`.*
