#!/bin/bash
set -ev

if [[ -z $1 ]]; then
    echo "Commit range cannot be empty"
    exit 1
fi

par="--name-only"
echo "par = $par"
echo "Before Git diff command : git diff $par $1 | sort -u | uniq | grep "docs" "
CHANGED_FILE=$(git diff $par $1 | sort -u | uniq | grep "docs")
echo "CHANGED_FILE is $CHANGED_FILE";

if [[ -z $CHANGED_FILE ]]; then
    echo "No Schema document changed"
fi

if [[ "$TRAVIS_BRANCH" == "develop" ]]; then

   if [[ "$CHANGED_FILE" == *"docs-test"* ]]; then
     echo "Changes done on docs-test folder";
     export CHANGED_FOLDER=$DEV_TEST_TARGET;

   elif [[ "$CHANGED_FILE" == *"docs-final"* ]]; then
     echo "Changes done on docs-final folder";
     export CHANGED_FOLDER=$DEV_FINAL_TARGET;

   fi
fi

if [[ "$CHANGED_FILE" = *"BillOfLading"* ]]
then
  echo "BillOfLading document schema has been changed";
  export CHANGED_DOC="BillOfLading";

elif [[ "$CHANGED_FILE" = *SeaWaybill* ]]
then
  echo "SeaWaybill document schema has been changed";
  export CHANGED_DOC="SeaWaybill";

elif [[ "$CHANGED_FILE" = *VerifyCopy* ]]
then
  echo "VerifyCopy document schema has been changed";
  export CHANGED_DOC="VerifyCopy";

elif [[ "$CHANGED_FILE" = *ShippingInstructions* ]]
then
  echo "ShippingInstructions document schema has been changed";
  export CHANGED_DOC="ShippingInstructions";
fi;