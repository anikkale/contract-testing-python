#!/bin/bash

GREEN=$(tput setaf 2)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
NC=$(tput sgr0)
GIT_COMMIT_SHA=$(git rev-parse --short HEAD)


echo -e "\n${GREEN}=>=>=> Running the Pipeline for the Provider Product ${GIT_COMMIT_SHA} <=<=<=${NC}\n"

echo -e "\n${YELLOW}=>=>=> Installing Dependency <=<=<=${NC}\n"
make install

read -p "${RED}Do you want to continue: ${NC}" arg1
echo -e "\n${YELLOW}=>=>=> Verify Pact Contract <=<=<=${NC}\n"
version=${GIT_COMMIT_SHA} make verify_provider_contract

read -p "${RED}Do you want to continue: ${NC}" arg1
echo -e "\n${YELLOW}=>=>=> Check if we can Deploy to Dev  <=<=<=${NC}\n"
version=${GIT_COMMIT_SHA} env=test make can_i_deploy_product

read -p "${RED}Do you want to continue: ${NC}" arg1
echo -e "\n${YELLOW}=>=>=> Deploy to DEV, Mark PACT as deployed to dev <=<=<=${NC}\n"
version=${GIT_COMMIT_SHA} env=test make tag_provider_contract_as_deployed

read -p "${RED}Do you want to continue: ${NC}" arg1
echo -e "\n${YELLOW}=>=>=> Check if we can Deploy to PROD  <=<=<=${NC}\n"
version=${GIT_COMMIT_SHA} env=production make can_i_deploy_product

read -p "${RED}Do you want to continue: ${NC}" arg1
echo -e "\n${YELLOW}=>=>=> Deploy to PROD, Mark PACT as deployed to prod <=<=<=${NC}\n"
version=${GIT_COMMIT_SHA} env=prod make tag_provider_contract_as_deployed

