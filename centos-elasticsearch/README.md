# Elasticsearch on CentOS

Elasticsearch 2.3.x on CentOS 7.2 Docker image. 

## Usage

Running a standalone node is as easy as typing:

````
docker run -p 9200:9200 -v /host/data/path:/var/lib/elasticsearch macedigital/elasticsearch
````

The above command exposes the Elasticsearch HTTP interface on port 9200 and uses the host's filesystem to store persistent data. 

## Configuration

There are a number of runtime environment variables with which you can configure Elasticsearch.

`CLUSTER`: Set custom cluster name, default is 'elasticsearch'. 

`CLUSTER_FROM`: Migrate data between clusters, ignored if `CLUSTER` is empty.

`NODE_NAME`: Set node name, a random name will be chosen if left empty.

`MULTICAST`: Host(s) for multi-casting. Will install `discovery-multicast` plugin if set.

`UNICAST_HOSTS`: Host(s) for unicasting to form a cluster.

`PUBLISH_AS`: Host+IP setting for using custom transport communication between nodes.

`PLUGINS`: Comma-separated list of plugins to install on node.

### Volumes

`/usr/share/elasticsearch/conf`:

Override the configuration to you liking by mounting a directory which contains `elasticsearch.yml` and/or other configuration files.

`/var/lib/elasticsearch/data`:

Data will be saved in this folder, so you can bind custom volumes for persistence.

## Example

The following `docker-compose.yml` example illustrates how to create a Elaticsearch cluster on the same host:
 
````yml
version: '2'
services:
  master:
    image: macedigital/elasticsearch
    environment:
      - NODE_NAME=es_master
      - PLUGINS=lmenezes/elasticsearch-kopf
    ports:
      - 9200:9200
    container_name: es_master
    volumes:
      - /var/lib/elasticsearch

  node:
    image: macedigital/elasticsearch
    environment:
      - UNICAST_HOSTS=es_master
    links:
      - master
    volumes_from:
      - master
````

## Issues

Feel free to create a ticket in the github issue tracker for this repo. Please add the **elasticsearch** tag when doing so.

Pull requests are always welcome :)
