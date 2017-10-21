#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""

This is a awesome python script!

"""

import click
import docker
import os

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
def sqlcmd():
    pass

@sqlcmd.command('pull-image')
def pull():
    client = docker.from_env()
    if not client.images.list(name = image_name):
        clickecho("Pulling " + container_image + " docker image, this may take a while...")
        client.images.pull(image_name, tag = "latest")
        click.echo("Done")
    else:
        click.echo("Skipped: image exists")

@sqlcmd.command('query')
@click.option('--password', '-p',
	     type = str,
	     envvar = 'SQL_SERVER_PASSWORD',
	     required = True)
@click.option('--query-string', '-q', type = str, default = None, required = False)
@click.option('--output-file', '-o', type = str, default = None, required = False)
@click.option('--prune/--no-prune', default=True, required = False)
@click.argument('sql-file', type = str, default = None, required = False)
def query_anpr(query_string, output_file, sql_file, password, prune):
    client = docker.from_env()
    if query_string:
        query = query_string
    elif sql_file:
        with open(sql_file, "r") as ifile:
            query = ifile.read()
    else:
        click.echo("You must specify a query either through " +
                    "the -q option or by passing the path to a " +
                    "file containing a sql query (see directory queries). " +
                    "Run again with --help for usage.")
        return
    try:
        logs = client.containers.run(image = image_name,
                                     remove = True,
                                     command = [
                                          "-U", "sa",
                                          "-P", password,
                                          "-S", "172.17.0.2,1433",
                                          "-W", "-s", ",",
                                          "-Q", query])
	# Remove 1st and 3rd lines ("Using DB context blabla" and header separator: a dashed line)
        if prune:
            lines = logs.split("\n")
	    logs = lines[0] + lines[2:(len(lines)-1)]
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
