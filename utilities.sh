#!/bin/bash

slackMsg() {
    local ENVIRONMENT=$1
    local SCHEMA_TYPE=$2
    local SCHEMA_VERSION=$3
    local SCHEMA_ID=$4

    if [[ $SLACK_WEBHOOK == "" ]];then
        echo "Slack token undefined"
        exit 1
    fi

    curl -s -X POST \
              https://hooks.slack.com/services/${SLACK_WEBHOOK} \
              -H 'Content-Type: application/json' \
              -H 'cache-control: no-cache' \
              -d '{
                    "attachments": [
                        {
                            "color": "#2eb886",
                            "author_name": "Schema Devops",
                            "title": "Publish to '$ENVIRONMENT'",
                            "text": "sample test",
                            "fields": [
                                        {
                                            "title": "Environent",
                                            "value": "'$ENVIRONMENT'"
                                        },{
                                            "title": "SCHEMA TYPE",
                                            "value": "'$SCHEMA_TYPE'"
                                        },{
                                            "title": "SCHEMA VERSION",
                                            "value": "'$SCHEMA_VERSION'"
                                        },{
                                            "title": "SCHEMA ID",
                                            "value": "'$SCHEMA_ID'"
                                        }

                                    ]
                                }
                            ]
                  }'
}
