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

## Template queries and usage examples

You can use Jinja2 templates with your tsql queries. Define the template keys in your `.sql` query file and then pass the values on the terminal using the `-k key value` option. See examples in the queries folder.


**Get table names, number of rows and columns**

```bash
python client.py query -i queries/tables.sql
```

**Get all table names for a given table owner**

```bash
python client.py query -i queries/tables_by_owner.sql -k owner data
```

**Get column names for a given table**

```bash
python client.py query -i queries/columns.sql -k table Cameras
```

**Get data from table 'Cameras'**

```bash
python client.py query -i queries/cameras.sql
```

**Get number of observations per month and year**

```bash
python client.py query -i queries/npdata_rows_per_month.sql
```

**Get raw number plate data for a given time interval**

```bash
python client.py query -i queries/raw_npdata.sql -k start 2019-01-01 -k end 2019-02-01
```
