#!/bin/bash

BUCKET=$1
DAYS=${2:-2} # 2 days 
PROFILE=${3:-tmeintjes}

aws --profile=${PROFILE} s3 ls s3://${BUCKET} | awk '{print $4}' | xargs -L 1 aws s3api restore-object --restore-request Days=${DAYS} --bucket ${BUCKET} --key
