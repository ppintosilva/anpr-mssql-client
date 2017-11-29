# anpr-mssql-client
A command line interface for querying the anpr mssql database server

## Requirements

- python2.7
- pip
- docker
- User is part of the ```docker``` group

## Installation

Use the makefile for creating a virtual environment and installing python dependencies.
```
make install
source ENV/bin/activate
```

**Note:** Tested only on ubuntu server. Alternatively, create a virtual environment, activate it and run ```pip install -r requirements.txt```

## Usage

```
Usage: client.py [OPTIONS] COMMAND [ARGS]...

Options:
  --help  Show this message and exit.

Commands:
  pull-image
  query
```

Start by pulling the ```beeven/sqlcmd``` docker image using the ```pull-image``` command.

Then set the environment variable 'SQL_PASSWORD' and start querying away:

```
Usage: client.py query [OPTIONS]

  Query the anpr database server

Options:
  -p, --password TEXT      Database password. Read from the environment
                           variable 'SQL_PASSWORD'  [required]
  -q, --query-string TEXT  The sql query as a string
  -o, --output-file TEXT   Write results to output file
  --prune / --no-prune     Remove trailing whitespace, dash separator, etc.
  -i, --query-file TEXT    Read the query from file
  -t, --host TEXT          Database server IP address
  --help                   Show this message and exit.
  ```
