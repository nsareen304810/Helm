FROM python:3.10-slim
ENV AIRFLOW_HOME=/opt/airflow
WORKDIR $AIRFLOW_HOME

RUN apt-get update && apt-get install -y build-essential libpq-dev curl

ARG AIRFLOW_VERSION=2.9.0
ARG CONSTRAINT_URL="https://raw.githubusercontent.com/apache/airflow/constraints-${AIRFLOW_VERSION}/constraints-3.10.txt"
RUN pip install apache-airflow==${AIRFLOW_VERSION} --constraint ${CONSTRAINT_URL}
RUN pip install apache-airflow-providers-postgres apache-airflow-providers-redis apache-airflow-providers-cncf-kubernetes

COPY dags/ dags/
COPY plugins/ plugins/
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

USER 1000
ENTRYPOINT ["/entrypoint.sh"]
