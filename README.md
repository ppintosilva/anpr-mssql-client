# anpr-mssql-client

A command line interface for querying the [anpr-mssql-server](https://github.com/ppintosilva/anpr-mssql-server).

## Requirements

- Docker (and user added to `docker` group)
- Python 3 (`pipenv` recommended)
- An instance of the [anpr-mssql-server](https://github.com/ppintosilva/anpr-mssql-server) running on localhost or on other machine in the same network.

## Steps

- `$ pipenv install` + `$ pipenv shell` (or alternative virtualenv setup)
- ```$ python client.py pull-image```
- `$ export SQL_PASSWORD=YOUR_password_123`
- Query away from a string or a file: ```$ python client.py query -i select_pie.tsql```
