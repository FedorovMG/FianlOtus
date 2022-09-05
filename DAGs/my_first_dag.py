from asyncio import tasks
from datetime import datetime, timedelta
from airflow import DAG
from airflow.operators.bash import BashOperator



with DAG (
    dag_id='FirstDAG',
    description='My first dag - Hello World',
    start_date=datetime(2022, 6, 30, 23),
    schedule_interval=timedelta(days=1),
) as dag:
    t1 = BashOperator(
        task_id='print_hello',
        bash_command='echo "Hello World"'
    )
    t2 = BashOperator(
        task_id='print_date',
        bash_command='date'
    )
    t1 >> t2
    