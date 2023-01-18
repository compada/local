#!/bin/bash

declare -a service_dirs=()

# Read the .env file
while read line; do
    # Echo the name of the variable
    echo ${line%%=*}

    # Change the current directory to the value of the variable
    cd ${line#*=}

    if [ -f "compose.yaml" ] || [ -f "compose.yml" ] || [ -f "docker-compose.yaml" ] || [ -f "docker-compose.yml" ]; then
        # Pass all arguments to compose
        docker compose "$@"
    else
        echo " ⠿ No compose file exists within $PWD."
    fi
    echo

    # Return to the original directory
    cd - > /dev/null
done < ./.env
