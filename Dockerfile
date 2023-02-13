FROM python:3.10.10-slim-buster
FROM jenkins/jenkins


ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"

ARG GIT_COMMIT=unspecified
LABEL git_commit=$GIT_COMMIT
# Run this command to find git commit:-
#docker inspect quay.io/shazchaudhry/docker-jenkins | jq '.[].ContainerConfig.Labels'

# Once jenkins is running and configured, run the following command to find the list of plugins installed:
##  curl -s -k "http://admin:admin@localhost:8080/pluginManager/api/json?depth=1" | jq -r '.plugins[].shortName' | tee plugins.txt
RUN jenkins-plugin-cli \
    --plugins \
  ace-editor \
  ant \
  antisamy-markup-formatter \
  authentication-tokens \
	blueocean \
  blueocean-autofavorite \
  blueocean-commons \
  blueocean-config \
  blueocean-dashboard \
  blueocean-display-url \
  blueocean-events \
  blueocean-github-pipeline \
  blueocean-git-pipeline \
  blueocean-i18n \
  blueocean-jwt \
  blueocean-personalization \
  blueocean-pipeline-api-impl \
  blueocean-pipeline-editor \
  blueocean-pipeline-scm-api \
  blueocean-rest \
  blueocean-rest-impl \
  blueocean-web \
  bouncycastle-api \
  branch-api \
  build-timeout \
  cloudbees-folder \
  credentials \
  credentials-binding \
  display-url-api \
  docker-commons \
  docker-workflow \
  durable-task \
  email-ext \
  external-monitor-job \
  favorite \
  git \
  git-client \
  github \
  github-api \
  github-branch-source \
  gitlab-plugin \
  git-server \
  global-build-stats \
  gradle \
  handlebars \
  icon-shim \
  jackson2-api \
  jquery-detached \
  junit \
  keycloak \
  ldap \
  mailer \
  mapdb-api \
  matrix-auth \
  matrix-project \
  metrics \
  momentjs \
  pam-auth \
  pipeline-build-step \
  pipeline-github-lib \
  pipeline-graph-analysis \
  pipeline-input-step \
  pipeline-milestone-step \
  pipeline-model-api \
  pipeline-model-declarative-agent \
  pipeline-model-definition \
  pipeline-model-extensions \
  pipeline-rest-api \
  pipeline-stage-step \
  pipeline-stage-tags-metadata \
  pipeline-stage-view \
  plain-credentials \
  pubsub-light \
  purge-job-history \
  resource-disposer \
  role-strategy \
  scm-api \
  script-security \
  sse-gateway \
  ssh-credentials \
  ssh-slaves \
  structs \
  subversion \
  timestamper \
  token-macro \
  variant \
  windows-slaves \
  workflow-aggregator \
  workflow-api \
  workflow-basic-steps \
  workflow-cps \
  workflow-cps-global-lib \
  workflow-durable-task-step \
  workflow-job \
  workflow-multibranch \
  workflow-scm-step \
  workflow-step-api \
  workflow-support \
  ws-cleanup

USER root
COPY --from=0 /usr/local  /usr/local
RUN python3 --version
USER jenkins

# ENV HOME="/root"
# WORKDIR ${HOME}
# RUN apt-get update && apt-get install -y \
#         git \
#         build-essential \
#         python-setuptools 
# RUN git clone --depth=1 https://github.com/pyenv/pyenv.git .pyenv
# ENV PYENV_ROOT="${HOME}/.pyenv"
# ENV PATH="${PYENV_ROOT}/shims:${PYENV_ROOT}/bin:${PATH}"

# ENV PYTHON_VERSION=3.10.9
# RUN pyenv install ${PYTHON_VERSION}
# RUN pyenv global ${PYTHON_VERSION}

# Python install
# RUN apt-get update
# RUN apt-get install -y \
#         software-properties-common

# # RUN add-apt-repository ppa:deadsnakes/ppa

# RUN apt-get update && apt-get install -y python3.10

