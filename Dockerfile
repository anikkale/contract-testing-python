FROM jenkins/jenkins:lts

USER root

ENV HOME="/root"
WORKDIR ${HOME}
RUN apt-get install && apt-get install -y \
        git
        build-essential
RUN git clone --depth=1 https://github.com/pyenv/pyenv.git .pyenv
ENV PYENV_ROOT="${HOME}/.pyenv"
ENV PATH="${PYENV_ROOT}/shims:${PYENV_ROOT}/bin:${PATH}"

ENV PYTHON_VERSION=3.10
RUN pyenv install ${PYTHON_VERSION}
RUN pyenv global ${PYTHON_VERSION}

# Python install
# RUN apt-get update && apt-get install -y \
#         software-properties-common

# RUN apt-get update && apt-get install -y python3.10
