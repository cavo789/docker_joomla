# Étape 5 - Docker dans le monde réel

<!-- .slide: data-background="./images/background.jpg" data-background-size="cover" -->

Repensez à notre dernier chapitre, le dossier `step_4_install_mysql_volume`.

N'est-il pas un bon candidat pour être votre base de travail ? Copiez ce dossier autant de fois que nécessaire et nommez les dossiers *client_1*, *client_2*, *client_3*, *client_4*, ...

Vous êtes occupés à créer des ... containers où les clients seront isolés les uns des autres.

----

<!-- .slide: data-background="./images/containers.jpg" data-background-size="cover" -->

Lorsque vous travaillerez pour votre client 1, rendez-vous dans le dossier du client et lancer la commande `docker compose up --detach` et hop, votre site `http://127.0.0.1` local est celui de ce client.

Faites de même pour le client 2, rendez-vous dans le dossier du client concerné, exécutez la même commande et hop, cette fois, c'est son site.

----

<!-- .slide: data-background="./images/step_5_real_world/images/containers.jpg" data-background-size="cover" -->

Pour utiliser des ports différents, adaptez le fichier `docker-compose.yml` et changez la ligne suivante:

```yaml
ports:
      - 80:80
```

en, par exemple,

```yaml
ports:
      - 81:80
```

Pour ce client-là, l'URL deviendra alors `http://127.0.0.1:81`.

----

Vous n'auriez plus de souci d'URL, d'alias, de conflits (le client 1 est toujours sous PHP `7.x` mais le client 2 sous PHP `8.x`).

Plus de risque non plus que la base de données de l'un n'écrase celle de l'autre.

Et vous pourriez même créer une image Docker (avec la commande `docker build`), l'héberger sur votre Docker Hub privé (`docker push`) et lui dire qu'il peut la récupérer (`docker pull`) pour installer le site en local chez lui.

Et comme tout est en local, <mark>il est très facile également d'utiliser des outils de versionning type GitHub</mark> pour conserver trace des changements ainsi que simplifier le travail collaboratif.
