#!/bin/bash

# Log the execution
echo "Running keycloak entrypoint script..."

# Start Keycloak
echo "Starting Keycloak..."
exec /opt/keycloak/bin/kc.sh "$@"

# Check if the setup script executed successfully
if [ $? -ne 0 ]; then
  echo "Keycloak setup script failed. Exiting."
  exit 1
fi

# Run the custom realm setup script
/opt/keycloak/scripts/realm-setup.sh

if [ $? -ne 0 ]; then
  echo "Realm setup script failed. Exiting."
  exit 1
fi