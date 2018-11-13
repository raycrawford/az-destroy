#!/bin/bash

if [ -z "$1" ] || [ ! -z "$2" ]
then
    if [ -z "$1" ]
    then
        echo "No argument passed."
    fi
    if [ ! -z "$2" ]
    then
        echo "There are two arguments; I don't understand the input"
    fi
    echo "Please pass only the base name of the resource groups you'd like to delete as the only argument."
    exit
fi

. ./secrets.bash
resourceGroupName=$1
echo "Looking for resource groups starting with ${resourceGroupName}"
az login --service-principal -t ${TENANT} -u http://${APP_USERNAME} -p ${APP_PASSWORD} > /dev/null

echo "RESOURCES TO DELETE:"
for subscription in ${subscriptions[*]}; do
    az account set --subscription ${subscription}
    echo "=> ${subscription}"
    RESOURCEGROUPS=`az group list --query "[?starts_with(name, '${resourceGroupName}')]" | jq -r ".[].name"`
    for i in ${RESOURCEGROUPS}; do
        echo "==>  ${i}"
    done
done

confirmation='unknown'
until [[ ${confirmation} == "y" ]] || [[ ${confirmation} == "n" ]]; do
    echo "IS THIS OKAY?  DO YOU WANT TO CONTINUE? (y/n)"
    read confirmation
    if [[ ${confirmation} == "n" ]]
    then
        exit
    fi
done

for subscription in ${subscriptions[*]}; do
    az account set --subscription ${subscription}

    RESOURCEGROUPS=`az group list --query "[?starts_with(name, '${resourceGroupName}')]" | jq -r ".[].name"`
    for i in ${RESOURCEGROUPS}; do
        az group delete --resource-group ${i} --yes --no-wait
    done

done
