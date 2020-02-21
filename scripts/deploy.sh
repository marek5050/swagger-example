#!/bin/bash
set -ev

# - CHANGED_FOLDER: Check if the CHANGED_FOLDER is test or final
#if [ -z "$CHANGED_FOLDER" ] && [ -z "$CHANGED_DOC" ] &&  [ -z "$CHANGED_FILE" ]
#then
#      echo "no changes in either docs-test or docs-final folders, nothing to deploy ";
#      exit
#fi

HEADER_CONTENT_TYPE="Content-Type: application/json"
HEADER_ACCEPT="Accept: application/json"

#local uri=$1
#local json=$2
#local certAtt=""

#if [[ -n "$CA_CERT_PATH" ]]; then
#   certAtt="--cacert $CA_CERT_PATH"
#fi
#

#echo "Calling URI (POST): " ${uri}

IBM_TOKEN=`curl --location --request POST 'https://iam.ng.bluemix.net/oidc/token' \
--header 'Content-Type: application/x-www-form-urlencoded' \
--header 'Accept: application/json' \
--data-raw 'grant_type=urn:ibm:params:oauth:grant-type:apikey&apikey=${KEY}'`

TRADELENS_TOKEN=`curl --location --request POST 'https://platform-dev.tradelens.com/onboarding/v1/iam/exchange_token/solution/gtd-dev/organization/${ORGID}' \
--header 'Content-Type: application/json' \
--header 'Accept: application/json' \
--data-raw "$IBM_TOKEN"`

TOKEN=`echo $TRADELENS_TOKEN | jq ".onboarding_token"`

AUTH_HEADER="Authorization: Bearer ${TOKEN}"
pwd
ls -l
ls ./docs-schema/BillOfLading.json
pwd

curl -X POST "https://platform-dev.tradelens.com/api/v1/documentSchema" -H "$AUTH_HEADER" -d @./docs-schema/BillOfLading.json