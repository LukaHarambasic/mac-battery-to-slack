#!/bin/bash

MESSAGES=("Pleeeassseeeee charge me!" "You know what I'm going to tell you..." "Come on, again?" "You are looking sharp today, but have you thought about charging me?" "Want to embarrass yourself during a meeting again?" "Should Luka get you a charger? Again?" " I won't say anything.")
BATTERY_LEVEL=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)

if (($BATTERY_LEVEL < 25))
then
    MESSAGE_MAIN=${MESSAGES[RANDOM%${#MESSAGES[@]}]}
    MESSAGE_LEVEL=":low_battery: ${BATTERY_LEVEL}%"

    DATA_RAW='{ "blocks": [ { "type": "section", "text": { "type": "mrkdwn", "text": "%s" } }, { "type": "context", "elements": [ { "type": "plain_text", "text": "%s", "emoji": true } ] } ] }'
    DATA=$(printf "$DATA_RAW" "$MESSAGE_MAIN" "$MESSAGE_LEVEL")

    curl -X POST -H 'Content-type: application/json' --data "${DATA}" $1

    echo "It is done!"
else
    echo "Not now!"
fi


