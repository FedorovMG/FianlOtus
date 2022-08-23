#! /bin/bash
export AIRFLOW__CORE__LOAD_EXAMPLES=False
export AIRFLOW_HOME=~/airflow
AIRFLOW_VERSION=2.3.3
PYTHON_VERSION="$(python3 --version | cut -d " " -f 2 | cut -d "." -f 1-2)"
CONSTRAINT_URL="https://raw.githubusercontent.com/apache/airflow/constraints-${AIRFLOW_VERSION}/constraints-${PYTHON_VERSION}.txt"
pip install "apache-airflow==${AIRFLOW_VERSION}" --constraint "${CONSTRAINT_URL}"
airflow db init
airflow users create --username fedorovmg --firstname Maksim --lastname Fedorov --role Admin --password fmg123 --email fedorovmg@hotmail.com
airflow webserver --port 8080 -D
airflow scheduler -D