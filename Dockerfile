FROM python:3.7-slim


ENV PYTHONUNBUFFERED 1 \
  PIP_NO_CACHE_DIR=off \
  PIP_DISABLE_PIP_VERSION_CHECK=1


ARG ENVIRONMENT=default

RUN apt-get update \
    && apt-get install -y netcat postgresql-client \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /app

COPY Pipfile*  /app/
RUN pip install pipenv && \
    pipenv install --system --deploy --ignore-pipfile

COPY docker-entrypoint.sh /app/
RUN chmod +x docker-entrypoint.sh

COPY . /app/

CMD ["sh", "/app/docker-entrypoint.sh"]
