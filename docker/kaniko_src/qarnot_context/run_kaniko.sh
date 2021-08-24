#!/bin/bash

D_REPO=$1
D_TAG=$2
D_USER=$3
D_PWD=$4

echo Updating the docker auths to push the image ...
# Update the docker auths to push the image to the docker repo
DOCKER_AUTH="$(echo -n $D_USER:$D_PWD | base64)"
sed -i -e "s/DOCKER_AUTH/$DOCKER_AUTH/g" /opt/config.json
mv /opt/config.json /kaniko/.docker/config.json

# Launch the docker build
echo Running /kaniko/executor ...
    /kaniko/executor --dockerfile="/kaniko/.docker/Dockerfile" \
                     --context="/kaniko/.docker/" \
                     --destination="$D_REPO":"$D_TAG"
