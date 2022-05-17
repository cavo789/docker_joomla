# Étape 2.2 - Session interactive

Si on lance `Docker Desktop` et qu'on se rends dans la liste des containers puis qu'on déplie le container en cours, on peut voir que le nom du service Apache est `step_2_install_joomla-joomla-1` (c'est-à-dire le nom du dossier en cours suivi du nom du service suivi du chiffre `1`).

On retrouve aussi le nom avec la ligne de commande `docker container list`.

Du coup `docker exec -it step_2_install_joomla-joomla-1 /bin/bash` permet de lancer une console dans le container et de se promener dans l'arborescence du l'installation Joomla.

----

Si on fait un `cat configuration.php`, on peut donc voir le fichier de configuration du site. Puisqu'il n'y a pas d'éditeur de texte dans l'image Joomla, utilisons `sed` pour remplacer la valeur offline de `false` vers `true` :

```bash
sed -i 's/public $offline = false/public $offline = true/g' configuration.php
```

Si on rafraîchit le navigateur, on voit bien qu'on a mis le site hors ligne. Ce qu'on voit dans la session interactive correspond bien à ce qu'on a sur la page du navigateur; nous sommes bien occupés à modifier le site Joomla.

----

<!-- .slide: data-background="./images/we-have-learned.jpg" data-background-size="cover" -->

À la fin de ce chapitre d'installation de Joomla, nous avons appris, en plus :

* à adapter un fichier de Joomla en démarrant le container de façon interactive.

Lors du troisième chapitre, nous verrons comment synchroniser les fichiers entre le container et notre disque dur.
