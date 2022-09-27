#!/bin/bash
set -m

docker exec -it neo4j /bin/bash -c "/app/neo4j/neo4j-community-4.4.11/bin/neo4j start"

#/app/neo4j/neo4j-community-4.4.11/bin/neo4j start
#tail -f /dev/null