FROM python:3.9-bullseye AS build

RUN apt-get update
RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

COPY deployment/requirements.txt .
RUN pip install -r requirements.txt

FROM python:3.9-bullseye

RUN \ 
# apt-get update && apt-get upgrade && \
# apt-get install -y python3-launchpadlib && \
# apt-get install -y software-properties-common && \
# add-apt-repository ppa:openjdk-r/ppa && \ 
apt-get update --fix-missing && \
  apt-get install -y  \
    openjdk-11-jre-headless && \
  apt-get autoremove -yqq --purge && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-arm64

COPY --from=build /opt/venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

COPY . /data_pipeline
WORKDIR /data_pipeline
