#!/usr/bin/env python
# -*- coding: utf-8 -*-
import click
import docker
import os
import sys

###############################################
#
#
#   Global Variables / Config
#
#
###############################################

image_name = "beeven/docker-sqlcmd"

###############################################
#
#
#   Helpers
#
#
###############################################


###############################################

@click.group()
def sqlcmd(help="A command line interface for querying the anpr mssql database server"):
    pass

@sqlcmd.command('pull-image', help="Pull the sqlcmd docker image")
def pull():
    client = docker.from_env()
    if not client.images.list(name = image_name):
        click.echo("Pulling " + image_name + " docker image, this may take a while...")
        client.images.pull(image_name, tag = "latest")
        click.echo("Done")
    else:
        click.echo("Skipped: image exists")

@sqlcmd.command('query', help="Query the anpr database server")
@click.option('--password', '-p',
	     type = str,
	     envvar = 'SQL_PASSWORD',
	     required = True,
             help="Database password. Read from the environment variable 'SQL_PASSWORD'")
@click.option('--query-string', '-q', type = str, default = None, required = False, help="The sql query as a string")
@click.option('--output-file', '-o', type = str, default = None, required = False, help="Write results to output file")
@click.option('--prune/--no-prune', default=True, required = False, help="Remove trailing whitespace, dash separator, etc.")
@click.option('--query-file', '-i', type = str, default = None, required = False, help="Read the query from file")
@click.option('--host', '-t', type = str, default = '127.0.0.1', required = False, help="Database server IP address")
def query_anpr(query_string, output_file, query_file, password, prune, host):
    client = docker.from_env()
    try:
        client.images.get(image_name)
    except docker.errors.ImageNotFound as e1:
        click.echo(e1)
        sys.exit(1)
    except docker.errors.APIError as e2:
        click.echo(e2)
        sys.exit(2)

    if query_string:
        query = query_string
    elif query_file:
        if not os.path.isfile(query_file):
            click.echo("Input file does not exist")
            sys.exit(1)
        with open(query_file, "r") as ifile:
            query = ifile.read()
    else:
        click.echo("You must specify a query either through " +
                    "the -q option or by passing the path to a " +
                    "file containing a sql query (see directory queries). " +
                    "Run again with --help for usage.")
        return
    try:
        prune_options = ["-W", "-s", ",", "-m", "1"]
        command = ["-U", "sa", "-P", password,
                   "-S", ",".join([host, "1433"]),
                   "-Q", query]
        if prune:
            command.extend(prune_options)
        logs = client.containers.run(remove = True,
                                     image = image_name,
                                     network_mode = "host",
                                     command = command)
	# Remove dashed line - 2nd line
        if prune:
            lines = logs.split("\n")
            del lines[1]
            lines = filter(None, lines)
            logs = "\n".join(lines)
        if output_file:
            with open(output_file, 'w') as ofile:
                ofile.write(logs)
        else:
            click.echo(logs)
    except docker.errors.APIError as e:
        click.echo(e)
    except docker.errors.ContainerError as e2:
        click.echo(e2)

if __name__ == "__main__":
    sqlcmd()
