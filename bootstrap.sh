#!/bin/bash

# Imports data into Apache Pinot
docker exec -ti pinot_app_ira bash -c "sh ./import/import-russian-troll-tweets.sh"

# Initializes the Superset application and imports datasources and dashboards
docker exec -ti -u root superset_app_ira bash -c "sh ./docker-init.sh"

# Open the browser for Pinot and Superset
open http://localhost:9000
open http://localhost:8088

echo "Success! Login to Superset using the credentials admin/admin"
