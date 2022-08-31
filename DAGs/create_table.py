from clickhouse_driver import Client
import csv

client = Client('localhost')

client.execute(
    '''
    CREATE TABLE my_test.simpson_episode
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

