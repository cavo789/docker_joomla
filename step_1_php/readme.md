# Étape 1 - Au Début était Docker ...

Prenons le temps de découvrir Docker... Grâce à lui, il n'est plus nécessaire d'installer PHP ou Apache pour faire tourner un site web.

On retrouve sur [Docker Hub](https://hub.docker.com) un très grand nombre "d'images" qui permettent d'exécuter des logiciels comme PHP, PHP+Apache, MySQL et bien, bien d'autre choses. 

----

Toutes ces images sont totalement gratuites; elles peuvent être publiques ou privées. On peut créer ses propres images et les stocker sur [Docker Hub](https://hub.docker.com) gratuitement. 

Nous allons utiliser les images PHP disponibles sur [https://hub.docker.com/_/php](https://hub.docker.com/_/php)

----

Durant cette première étape, de découverte, nous allons exécuter un simple script PHP afin de montrer comment ... ne pas installer PHP et Apache. 

Nous changerons ensuite la version de PHP de `7.4` vers `8.1` en juste quelques ... touches enfoncées au clavier.

----

<!-- .slide: data-background="./images/background.png" data-background-size="cover" -->

Nous aurons besoin d'une image Docker qui inclus PHP et Apache pour faire tourner notre script. Par chance, une telle image existe :-)

Nous utiliserons les instructions `docker run`.

----

<!-- .slide: data-background="./images/attention.jpg" data-background-size="cover" -->

Durant ce chapitre, lors de notre découverte de Docker, nous utiliserons des numéros de port à chaque fois différents pour accéder à notre site local. Nous verrons plus tard comment réutiliser le même numéro de port.
