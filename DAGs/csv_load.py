from datetime import date, datetime
from clickhouse_driver import Client
import csv

client = Client('localhost')

def row_reader():
    with open('/home/admin-f/MyProjects/FinalOtus/CSV_Data/simpsons_episodes.csv') as simpsons_csv:
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
            
client.execute("INSERT INTO my_test.simpson_episode VALUES", (line for line in row_reader()))

