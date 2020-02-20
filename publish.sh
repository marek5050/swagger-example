source utilities.sh

trap 'slackMsgFail "${LAST_STATUS}" $?' EXIT
##Requires bootstrap script to pull in ci proj
LAST_STATUS="Just finishd develop"

slackMsg  "Dev" "SeaWayBill" "Version-1" "DocumentID12345"
