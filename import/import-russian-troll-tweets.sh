#!/bin/bash

echo "Adding 'russianTrollTweets' table to Pinot..."

# Adds a new Pinot table for the NOAA storm event data
/opt/pinot/bin/pinot-admin.sh AddTable -tableConfigFile /opt/pinot/import/russian-troll-tweets-table-config.json -schemaFile /opt/pinot/import/russian-troll-tweets-schema.json -exec
/opt/pinot/bin/pinot-admin.sh AddTable -tableConfigFile /opt/pinot/import/tweet-text-entities-table-config.json -schemaFile /opt/pinot/import/tweet-text-entities-schema.json -exec

echo "Downloading CSV files from GitHub..."

git clone https://github.com/kbastani/russian-troll-tweets.git

FILES=./russian-troll-tweets/*.csv

# Move downloaded CSV files to subdirectory
mkdir /opt/pinot/import/rawdata
mv $FILES /opt/pinot/import/rawdata

echo "Russian troll tweets downloaded!"
echo "Launching Pinot data ingestion job from raw CSV files..."

# Launch batch ingestion job from raw CSV files into Pinot
/opt/pinot/bin/pinot-admin.sh LaunchDataIngestionJob -jobSpecFile /opt/pinot/import/russian-troll-tweets-job-spec.yml
/opt/pinot/bin/pinot-admin.sh LaunchDataIngestionJob -jobSpecFile /opt/pinot/import/tweet-text-entities-job-spec.yml
