# poc-neo4j


## Clone
```
https://github.com/dszortyka/poc-neo4j.git
cd poc-neo4j/image
```


## Build docker image
```
docker image build -t neo4j . --no-cache
```

## Run container
```
docker run -d -p 7474:7474 -p 7687:7687 --name neo4j neo4j
```


## Start neo4j
```
docker exec -it neo4j /bin/bash
/app/neo4j/neo4j-community-4.4.11/bin/neo4j start
```

## Change Default password
* Open http://127.0.0.1:7474
* Change the default password (user: __neo4j__ , pass: __neo4j__)


## Copy files from data folder to Neo4j import folder
```
cd poc-neo4j/data

docker cp USERS.csv neo4j:/app/neo4j/neo4j-community-4.4.11/import/
docker cp PROJECTS.csv neo4j:/app/neo4j/neo4j-community-4.4.11/import/
docker cp REPOSITORIES.csv neo4j:/app/neo4j/neo4j-community-4.4.11/import/
docker cp BRANCHES.csv neo4j:/app/neo4j/neo4j-community-4.4.11/import/
docker cp COMMITS.csv neo4j:/app/neo4j/neo4j-community-4.4.11/import/
```

## Open Cypher-shell
```
docker exec -it neo4j /bin/bash

cd /app/neo4j/neo4j-community-4.4.11/bin/
./cypher-shell
```
* You'll be prompted to authenticate in Neo4j.


## Play with data
* Open file 


_All data contained in the .CSV file were created using Mockaroo_