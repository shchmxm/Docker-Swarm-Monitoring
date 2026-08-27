#!/usr/bin/env bash

# Runs newman and executes tests for microservice-app

TESTFILE='./app_src/postman_tests/application_tests.postman_collection.json'

docker run \
       -v "$TESTFILE:/tests.json" \
       --name microservice_tests \
       --hostname microservice_tests \
       --network=host \
       -ti --rm \
       postman/newman:6.1.3-alpine \
       run "/tests.json"
