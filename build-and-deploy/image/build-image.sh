#!/bin/bash

echo ' Move to the base directory '
cd ../../
pwd

echo 'Retrieve the current application version ...'
APP_VERSION=$(mvn org.apache.maven.plugins:maven-help-plugin:2.1.1:evaluate -Dexpression=project.version|grep -Ev '(^\[|Download\w+:)')
echo "Version =  $APP_VERSION ..."

# Run the packaging
echo '#############################'
echo '#  APPLICATION PACKAGING    #'
echo '#############################'
mvn -Pprod package

echo '##########################'
echo '#  DOCKER IMAGE BUILD    #'
echo '##########################'
# Build Docker versionned image
docker build --tag bewilcox/dockland:$APP_VERSION --rm=true .
# Build Docker image for the latest version
docker build --tag bewilcox/dockland --rm=true .
