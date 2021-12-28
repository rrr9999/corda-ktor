# Corda with Ktor template
## Prerequisites of Corda version 4

* Java 1.8.0_252([Azul Zulu 8u252](https://www.azul.com/downloads/azure-only/?version=java-8-lts&architecture=x86-64-bit&package=jdk&show-old-builds=true))
* PostgreSQL 11
* (optional)[IntelliJ IDEA 2020.3.4](https://www.jetbrains.com/ja-jp/idea/download/other.html)

If we use Corda version 4 or above, we must use Java 8. other versions of Java aren't able to use with Corda 4. Corda 5, next major platform version, will support Java 11, but the release date is undecided. 

In development using Corda 4 and IntelliJ 2021, there is a bug that code completion does not work. This seems to be caused by incompatibility with the latest version of Kotlin plugins.
The bug is expected to be resolved in Corda 5. reference: [Intellij having trouble with code completion under Kotlin 1.2](https://stackoverflow.com/questions/69684997/intellij-having-trouble-with-code-completion-under-kotlin-1-2)

## Setup
### start up with docker engine and docker-compose
run 3 corda nodes(include a notary) and client server of party_a 
```
docker-compose up
```

```
docker-compose down --rmi all --volumes --remove-orphans
```

### manual start up 
set up PostgreSQL with Docker.

```
docker run --name corda-ktor -e POSTGRES_PASSWORD=test -d -p 5432:5432 postgres:11.5
cat config.sql | docker exec -i corda-ktor psql -h localhost -p 5432 -U postgres
```

after start PostgreSQL server, build CorDapps.
```
./gradlew clean deployNodes
```

start 3corda nodes
```
./build/nodes/runnodes
```
after start corda nodes, run client applications
```
./gradlew runPartyAServer
./gradlew runPartyBServer
```

## when devMode=false in configuration file "node.conf"
When devMode is false in configuration file "node.conf", we must sign the cordapps, workflows-1.0.jar and contracts-1.0.jar.

key
