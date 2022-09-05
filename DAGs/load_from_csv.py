from asyncio import tasks
from airflow import DAG
from airflow.operators.python import PythonOperator
from datetime import date, datetime, timedelta
from clickhouse_driver import Client
import csv

client = Client('130.193.50.229')

def row_reader():
    with open('/home/ubuntu/csv/simpsons_episodes.csv') as simpsons_csv:
        reader = csv.DictReader(simpsons_csv)
        next(reader, None)
        for line in reader:
            yield {
                'id': int(line['id']),
                'title': str(line['title']),
                'original_air_date': datetime.strptime(line['original_air_date'], "%m/%d/%y"),
                'production_code': str(line['production_code']),
                'season': int(line['season']),
                'number_in_season': int(line['number_in_season']),
                'number_in_series': int(line['number_in_series']),
                'us_viewers_in_millions': float(line['us_viewers_in_millions']),
                'views': int(line['views']),
                'imdb_rating' : float(line['imdb_rating'])
            }


def CreateDatabase():
    client.execute(
    '''
    CREATE DATABASE SIMPSONS
    ''')

def CreateTable():
    client.execute(
    '''
    CREATE TABLE SIMPSONS.simpson_episode
        (
            id INT,
            title VARCHAR,
            original_air_date DATE32,
            production_code VARCHAR,
            season INT,
            number_in_season INT,
            number_in_series INT,
            us_viewers_in_millions FLOAT,
            views INT,
            imdb_rating FLOAT
        )
        ENGINE = MergeTree
        PRIMARY KEY(id)
    ''')

def LoadDateFromCSV():            
    client.execute("INSERT INTO SIMPSONS.simpson_episode VALUES", (line for line in row_reader()))




with DAG (
    dag_id='Load_CSV',
    description='Load data from csv file',
    start_date=datetime(2022, 9, 4, 23),
    schedule_interval=timedelta(days=1),
) as dag:
    t1 = PythonOperator(
        task_id='create_databse',
        python_callable=CreateDatabase,
        dag=dag
    )
    t2 = PythonOperator(
        task_id='create_table',
        python_callable=CreateTable,
        dag=dag
    )
    t3 = PythonOperator(
        task_id='load_data',
        python_callable=LoadDateFromCSV,
        dag=dag
    )
    t1 >> t2 >> t3
    