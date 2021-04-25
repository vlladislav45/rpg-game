# JRPG Game server

### Back end: 
* Java JDK 15.0.2
* database: PostgreSQL
* Docker

##For contributors/developers
###Quick start:
 ```
// Create a local .env file for basic configuration
cp .env.dist .env

// Start the stack of Docker containers in a terminal
docker-compose up

/// Maven lifecycle setup
$ mvn clean install
```

###Full guide:
 ```
// Create a local .env file for basic configuration
$ cp .env.dist .env

// Start the stack of Docker containers in a terminal
$ docker-compose up
```
* With this command lifts the database(PostgreSQL) container
and if you wish you can remove the comments to install for you
OpenJDK 15.0.2 

Note: The docker-compose up command aggregates the output of each container
(essentially running docker-compose logs --follow ). 
When the command exits, all containers are stopped.

* After containers are lifted you can install a server using maven
through some IDE or to setup maven. Use ```$ mvn install```

Note: Apache Maven is a popular build tool, that takes your project’s Java source code, compiles it, tests it and converts it into an executable Java program: either a .jar or a .war file.

### Maven lifecycle setup
After you have maven just type:
```$ mvn clean install```
You are using the clean command, which will delete all previously compiled Java .class files and resources (like .properties) in your project. Your build will start from a clean slate.

* After all the gymnastics you can easily extract a .zip file from the target
  directory and run one of the both scripts:
  ####1. jrpgcli.bat -> Windows
  ####2. jrpgcli.sh -> for Linux & MacOS

###JRPG Game Server CLI commands
* database(db), install(i), -sql, -u, -p, -url
```aidl
 // Default installation
 $ db i -sql [dir]
```
* Properties can be easily changed from config/gama-server.properties or through CLI
    