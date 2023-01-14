#!/bin/bash

# Get the compose files from the environment variables

declare -a service_dirs=()

# Read the .env file
while read line; do
    # Echo the name of the variable
    echo ${line%%=*}

    # Change the current directory to the value of the variable
    cd ${line#*=}

    if [ -f "compose.yaml" ] || [ -f "compose.yml" ] || [ -f "docker-compose.yaml" ] || [ -f "docker-compose.yml" ]; then
        # Start the compose file in detached mode
        docker compose "$@"
    else
        echo " ⠿ No compose file exists within $PWD."
    fi
    echo

    # Return to the original directory
    cd - > /dev/null
done < ./.env
