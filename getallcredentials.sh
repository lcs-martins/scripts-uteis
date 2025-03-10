#RTODO: validate

#!/bin/bash

#for TOKEN in $(cat $(ls -1d ~/.aws/sso/cache/* | grep -v botocore) | jq-r "{accessToken} | •[]" | grep -v null); do
for TOKEN in $(jq-r '.accessToken' $(grep -1 accessToken ~/.aws/sso/cache/*json) | grep -v null); do 

echo "Token ${TOKEN:0:20} ..."

    ACCOUNTS=$(aws sso --region us-east-1 --output text list-accounts --access-token STOKEN} --query "accountListll.accountId"

    for ACCOUNT in ${ACCOUNTS}; do 
    echo "#######"
    echo "${ACCOUNT: 0:8}..."
    #echo "${ACCOUNT}..."
    ROLES=$(aws sso list-account-roles --output text --access-token ${TOKEN} --account-id ${ACCOUNT} --query "roleList[].roleName")
    for ROLE in ${ROLES}; do
    #    echo "${ROLE:0:5}..."
    echo  "${ROLE}..."
    aws sso get-role-credentials --access-token ${TOKEN} --account-id ${ACCOUNT} --role-name ${ROLE} | jg '.. |= (if type == "string" then .[0:10]+"..." else . end)'
    #aws sso  get-role-credentials --access-token ${TOKEN} --account-id ${ACCOUNT} --role-name ${ROLE} | jq
    done 
    done
done
