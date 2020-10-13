#!/bin/bash

docker exec -ti pinot_app_ira bash -c "apt-get update"

docker exec -ti pinot_app_ira bash -c "curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash"

docker exec -ti pinot_app_ira bash -c "apt-get install git-lfs"

docker exec -ti pinot_app_ira bash -c "git clone https://github.com/kbastani/russian-troll-tweets.git"

# Imports data into Apache Pinot
docker exec -ti pinot_app_ira bash -c "sh ./import/import-russian-troll-tweets.sh"

# Initializes the Superset application and imports datasources and dashboards
docker exec -ti -u root superset_app_ira bash -c "sh ./docker-init.sh"

# Open the browser for Pinot and Superset
open http://localhost:9000
open http://localhost:8088

echo "Success! Login to Superset using the credentials admin/admin"
