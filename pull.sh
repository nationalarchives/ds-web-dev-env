#!/bin/bash

set -e

# Get the list of services
source services.sh

# Pull the latest changes for each service if the main branch is checked out
for service in "${services[@]}"
do
    echo "Pulling latest changes for $service..."
    cd "services/$service"
    BRANCH="$(git rev-parse --abbrev-ref HEAD)"
    if [[ "$BRANCH" == "main" ]]; then
        git pull origin main && echo "✅ Pulled latest changes for $service" || echo "❌ Failed to pull latest changes for $service"
    else
        echo "⚠️ You are on the $BRANCH branch. Please switch to the main branch to pull the latest changes."
    fi
    echo
    cd "../.."
done
