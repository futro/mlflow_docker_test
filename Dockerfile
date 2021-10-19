FROM python:3.8-slim-buster

# Build dependencies
RUN apt-get update -y \
    && apt-get install -y --no-install-recommends \
        build-essential libpq-dev

# Pip dependencies
COPY ./requirements.txt ./requirements.txt
RUN pip install -r requirements.txt

RUN mkdir /mlflow/

ENV BACKEND_STORE_URI=""
ENV DEFAULT_ARTIFACT_ROOT="/opt/artifact"

# Port
EXPOSE 8080

CMD mlflow server --host 0.0.0.0 --port 8080 --default-artifact-root /mlflow #--backend-store-uri $BACKEND_STORE_URI  --default-artifact-root $DEFAULT_ARTIFACT_ROOT
