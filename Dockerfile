FROM python:latest
USER root

RUN python --version

# RUN apt-get update && apt-get install -y --no-install-recommends \
#     python3.10 \
#     python3-pip \
#     && \
#     apt-get clean && \
#     rm -rf /var/lib/apt/lists/*

# RUN pip3 install nibabel pydicom matplotlib pillow
# RUN pip3 install med2image