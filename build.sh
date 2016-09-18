#!/bin/sh
#
# Script to build images
#

# break on error
set -e
set -x
set -a
: ${DOCKER_USE_HUB:="0"}

DATE=`date +%Y.%m.%d`
DOCKER_AWSCLI_VERSION=1.10.65


ci_docker_login() {
    docker login -e "${DOCKER_EMAIL}" -u ${DOCKER_USERNAME} --password="${DOCKER_PASSWORD}"
}


# warm up cache
docker pull muccg/awscli:latest || true

docker-compose build awscli
docker inspect muccg/awscli:latest

docker tag muccg/awscli:latest muccg/awscli:latest-${DATE}
docker tag muccg/awscli:latest muccg/awscli:${DOCKER_AWSCLI_VERSION}

if [ ${DOCKER_USE_HUB} = "1" ]; then
    ci_docker_login
    docker push muccg/awscli:latest
    docker push muccg/awscli:latest-${DATE}
    docker push muccg/awscli:${DOCKER_AWSCLI_VERSION}
fi
