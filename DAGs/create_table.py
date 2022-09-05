from clickhouse_driver import Client
import csv

client = Client('62.84.114.40')

client.execute(
    '''
    CREATE DATABASE SIMPSONS
    '''
)


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

