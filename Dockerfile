FROM python:3.8-slim-buster

# Build dependencies
RUN apt-get update -y \
    && apt-get install -y --no-install-recommends \
        build-essential libpq-dev

# Pip dependencies
COPY ./requirements.txt ./requirements.txt
RUN pip install -r requirements.txt

ENV BACKEND_STORE_URI="postgresql://postgres:postgres@postgresql:5432/postgres"
ENV DEFAULT_ARTIFACT_ROOT="s3://teststest/"

# Port
EXPOSE 8080

CMD mlflow server --host 0.0.0.0 --port 8080 --backend-store-uri $BACKEND_STORE_URI --default-artifact-root $DEFAULT_ARTIFACT_ROOT
