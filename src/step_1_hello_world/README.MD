L'idée est d'illustrer le fait que, lorsqu'il faut utiliser juste une image (php avec apache), on peut utiliser directement une commande `docker run`. Lorqu'il faudra utiliser plusieurs images (PHP et MySQL p.ex.), là, il faudra utiliser un fichier `docker-compose.yml`.

Avec juste deux / trois lignes de commandes on peut lancer une interface web avec un port spécifique et on peut partager le code source (sous forme d'un volume).

On peut changer très aisément la version de PHP.
