#!/bin/bash

HOST=$1
PORT=$2
PROJECTID="\"$3\""
BUCKETNAME="\"dd228c556b3b7a9\""
printf "\n"
echo "Host: ${HOST}"
echo "Port: ${PORT}"
echo "ProjectId: ${PROJECTID}"
echo "bucketName: ${BUCKETNAME}"

printf "\n"
echo "Wait 10s until adapter is initialized"
sleep 10s

printf "\ņ"
echo "Adapter address: ${HOST}:${PORT}"

printf "\n"
echo "Call createBucket() on Google Cloud Functions adapter"
out=$(curl ${HOST}:${PORT}/graphql -XPOST -H "Content-Type:application/graphql" --data "{createBucket(service:\"staticFunctionsService\", input:{projectID:${PROJECTID}, bucketName:${BUCKETNAME}}){requestId}}")
requestId=$( echo "$out" | grep "requestId")
requestId="$( sed 's/.*requestId\": \"\(.*\)\"/\1/' <<< $requestId)"
echo "  RequestId: $requestId"

printf "\n"
echo "createBucket() does not send any response (by purpose)"

printf "\n"
echo "Wait 10s"
sleep 10s

printf "\n"
echo "Call deployFunction() on Google Cloud Functions adapter"
out=$(curl ${HOST}:${PORT}/graphql -XPOST -H "Content-Type:application/graphql" --data "{deployFunction(service:\"staticFunctionsService\", input:{indexFile:\"\", packageJson:\"\", bucketName:${BUCKETNAME}, functionName:\"reverse\"}){requestId}}")
requestId=$( echo "$out" | grep "requestId")
requestId="$( sed 's/.*requestId\": \"\(.*\)\"/\1/' <<< $requestId)"
echo "  RequestId: $requestId"

printf "\n"
echo "Wait 120s"
sleep 120s

printf "\n"
echo "Call deployFunctionStatus() on Google Cloud Functions adapter"
out=$(curl ${HOST}:${PORT}/graphql -XPOST -H "Content-Type:application/graphql" --data "{deployFunctionStatus(input:{requestId:\"${requestId}\"}){status,result{return}}}")
echo "  Result:"
echo "  $out"


printf "\n"
echo "Wait 5s"
sleep 5s

printf "\n"
echo "Call viewLogs() on Google Cloud Functions adapter"
out=$(curl ${HOST}:${PORT}/graphql -XPOST -H "Content-Type:application/graphql" --data "{viewLogs(service:\"staticFunctionsService\", input:{functionName:\"reverse\"}){requestId}}")
requestId=$( echo "$out" | grep "requestId")
requestId="$( sed 's/.*requestId\": \"\(.*\)\"/\1/' <<< $requestId)"
echo "  RequestId: $requestId"

printf "\n"
echo "Wait 5s"
sleep 5s

printf "\n"
echo "Call viewLogsStatus() on Google Cloud Functions adapter"
out=$(curl ${HOST}:${PORT}/graphql -XPOST -H "Content-Type:application/graphql" --data "{viewLogsStatus(input:{requestId:\"${requestId}\"}){status,result{return}}}")
echo "  Result:"
echo "  $out"
