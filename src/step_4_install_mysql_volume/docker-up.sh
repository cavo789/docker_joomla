#!/usr/bin/env bash

# Quelques variables afin d'éviter de "hardcoder" certaines valeurs
# susceptibles de changer
# Il s'agit du nom de notre dossier (on peut aussi utiliser containerName="$(basename $(pwd))"
containerJoomlaName="step_4_install_mysql_volume"
portNumber="80" # Numéro du port qu'on souhaite utiliser p.ex. "81" si on veut http://127.0.0.1:81

clear

# Juste s'assurer que le container n'était pas déjà en cours d'utilisation
# et si c'est le cas, on l'arrête avant de l'exécuter à nouveau
if [[ $(docker ps -qa -f name="$containerName") ]]; then
    # Le container est déjà en cours d'utilisation
    docker stop $(docker ps -a -q --filter="name=$containerName") &>/dev/null

    # Et on va le supprimer afin de le créer à nouveau et avoir une situation propre
    docker rm $(docker ps -a -q --filter="name=$containerName") &>/dev/null
fi

docker compose up --detach

echo "Veuillez maintenant lancer votre navigateur et visiter l'URL locale http://127.0.0.1:${portNumber}"
echo ""
echo "Si vous souhaitez ouvrir une session interactive dans le container, exécutez la ligne ci-dessous:"
echo ""
echo "docker exec -it step_4_install_mysql_volume /bin/bash"
echo ""
