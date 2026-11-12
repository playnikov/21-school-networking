#!/bin/bash

STAGE_TYPE=$1

source /home/nataliam/config.conf
if [ "$CI_JOB_STATUS" = "success" ]; then
    MESSAGE="Stage $STAGE_TYPE $CI_JOB_NAME completed✅%0AURL:+$CI_PROJECT_URL/pipelines/$CI_PIPELINE_ID"
else
    MESSAGE="Stage $STAGE_TYPE $CI_JOB_NAME failed⛔️%0AURL:+$CI_PROJECT_URL/pipelines/$CI_PIPELINE_ID"
fi

ssh "$USER"@"$SERVER" "curl -s -X POST $API_URL -d chat_id=$CHAT_ID -d text=\"$MESSAGE\"" > "/dev/null"