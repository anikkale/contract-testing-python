FROM jenkins/jenkins:lts

# Python install
RUN apt-get update && apt-get install -y \
        software-properties-common 
RUN apt-get update && apt-get install -y python3.10
