# Gestion des permissions - Linux

> Ce chapitre ne s'applique pas aux utilisateurs qui travaillent sous Windows (mais bien si vous travaillez sous WSL).

Les fichiers qui sont créés depuis Docker sont des fichiers créés par le système d'exploitation Linux.

Contrairement à Windows, le système des permissions Linux est plus strict avec une notion de groupe-utilisateur-reste_du_monde (le fameux `chmod`).

Imaginons le script PHP ci-dessous qui crée un fichier dans le dossier courant :

```php
$fileName=__DIR__."/maintenant.txt";
if (file_put_contents($fileName, "Nous sommes le $date" . PHP_EOL) !== false) {
    echo "Le fichier $fileName a été créé";
} else {
    echo "Erreur";
}
```

----

Exécutons un nouveau container avec l'instruction ci-dessous : 

```bash
docker run --detach --name step_1_3_1 -p 82:80 -v $(pwd):/var/www/html php:7.4.29-apache
```

Accédons maintenant à l'URL [http://127.0.0.1:82/](http://127.0.0.1:82/). Nous verrons que nous avons une erreur.

![Un warning s'affiche lors de la création du fichier](./images/localhost_step_1_3_0.png)

Docker (utilisateur `root:root`) n'a donc pas réussi à créer un fichier sur notre disque dur; il faut donc lui indiquer qu'il faut utiliser notre utilisateur local.

----

Modifions notre instruction et analysons les changements : 

```bash
docker run --detach --name step_1_3_2 -p 83:80 -u $UID:$GID -v $(pwd):/var/www/html php:7.4.29-apache
```

* `--name step_1_3` : comme d'habitude, utilisons un nom précis,
* `-p 83:80` : cette fois-ci, ce sera le port `83`,
* `-u $UID:$GID` : ce paramètre est le plus important ici, on indique à Docker qu'on veut que les fichiers / dossiers qui seraient créés depuis le container n'utilisent par `root:root` mais notre utilisateur actif ainsi que son groupe d'appartenance (p.ex. `christophe:christophe`)

----

Cette fois-ci notre fichier est créé sans souci.

![Le fichier est créé](./images/localhost_step_1_3_0.png)

On peut voir le fichier `maintenant.txt` dans notre dossier.

Si on tape l'instruction `ls -l` dans notre console Linux, on constate qu'en effet le fichier `maintenant.txt`, qui a été créé par Docker, utilise bien notre utilisateur local; exactement ce qu'on souhaitait.

```text
drwxr-xr-x 2 christophe christophe 4096 May  7 22:06 images
-rw-r--r-- 1 christophe christophe 1112 May  7 21:53 index.php
-rw-r--r-- 1 christophe christophe   33 May  7 22:05 maintenant.txt
-rw-r--r-- 1 christophe christophe 1843 May  7 22:05 readme.md
```

----

À la fin de ce chapitre, nous avons appris

* à utiliser Docker,
* à définir la version de PHP que nous souhaitons utiliser
* à synchroniser un dossier (et ses sous-dossiers) 
* et à spécifier les permissions à utiliser.

Un petit extra pour la route, utilisation d'un script Bash. Rendez-vous au prochain, et dernier, chapitre.
