#!/usr/bin/env bash

# Quelques variables afin d'éviter de "hardcoder" certaines valeurs
# susceptibles de changer
containerName="step_1" # Juste un nom qu'on souhaite donner à notre container
portNumber="80"        # Numéro du port qu'on souhaite utiliser p.ex. "81" si on veut http://127.0.0.1:81
versionPHP="8.1.5"     # Numéro de version de PHP à utiliser
# versionPHP="8.1.1" # Numéro de version de PHP à utiliser
# versionPHP="7.4.29" # Numéro de version de PHP à utiliser

clear

# Juste s'assurer que le container n'était pas déjà en cours d'utilisation
# et si c'est le cas, on l'arrête avant de l'exécuter à nouveau
if [[ $(docker ps -qa -f name="$containerName") ]]; then
    # Le container est déjà en cours d'utilisation
    docker stop $(docker ps -a -q --filter="name=$containerName") &>/dev/null

    # Et on va le supprimer afin de le créer à nouveau et avoir une situation propre
    docker rm $(docker ps -a -q --filter="name=$containerName") &>/dev/null
fi

# region - Explications des paramètres utilisés avec docker run
# -d informe Docker qu'on souhaite qu'il démarre en tâche de fond (background);
#       càd que Docker doit démarrer notre container et nous rendre la main
# -v $(pwd)/src:/var/www/html va permettre de synchroniser nos fichiers locaux
#       avec les fichiers dans le container Docker
#           $(pwd) sous Linux retourne le dossier courant (sous Windows, l'équivalent est %CD%)
#           $(pwd)/src correspond donc à notre sous-dossier /src
#           et /var/www/html (à droite du double-point) correspond au dossier /var/www/html du
#           container Docker
#       -v $(pwd)/src:/var/www/html nous permet donc de changer nos fichiers en local et que
#           le changement soit immédiatement reflété dans le container Docker
# -p $portNumber:80 va faire correspondre le port 80 (Apache) du container Docker avec le port
#       tel qu'initialisé (p.ex. 81) de notre ordinateur. Ainsi, on aura une URL telle que,
#       par exemple, http://127.0.0.1:81 (si $portNumber est initialisé à 81)
# --name "$containerName" est juste là pour donner un nom à notre container. Ce n'est pas
#       obligatoire; si on ne le fait pas, un nom aléatoire est généré (par exemple "beautiful_euclid")
# 1>/dev/null est juste là pour éviter que "docker run" affiche un long code (le ID du container créé)
# endregion
docker run -d -v $(pwd)/src:/var/www/html -p $portNumber:80 \
    -u $UID:$GID --name "$containerName" php:${versionPHP}-apache 1>/dev/null

echo "Veuillez maintenant lancer votre navigateur et visiter l'URL locale http://127.0.0.1:${portNumber}"
echo ""
echo "Si vous souhaitez ouvrir une session interactive dans le container, exécutez la ligne ci-dessous:"
echo ""
echo "docker exec -it step_1 /bin/bash"
echo ""
