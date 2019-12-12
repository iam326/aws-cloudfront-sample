#!/bin/bash

set -euo pipefail

readonly PROJECT_NAME="aws-cloudfront-sample"
readonly STACK_NAME="${PROJECT_NAME}-stack"
readonly TEMPLATE_FILE="$(pwd)/template.yaml"
readonly WEB_HOSTING_BUCKET_NAME="${PROJECT_NAME}-bucket"

aws cloudformation validate-template \
  --template-body "file://${TEMPLATE_FILE}"

aws cloudformation deploy \
  --stack-name ${STACK_NAME} \
  --template-file ${TEMPLATE_FILE} \
  --capabilities CAPABILITY_NAMED_IAM \
  --parameter-overrides \
    WebHostingBucketName=${WEB_HOSTING_BUCKET_NAME} \
  && :

aws s3 cp ./src/index.html s3://${WEB_HOSTING_BUCKET_NAME}/index.html
