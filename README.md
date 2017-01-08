# Wildfly OpenSPCoop2 application running with PostgreSQL on Docker
This is a Docker compose framework to run a basic installation of OpenSPCoop2.
OpenSPCoop2 is an open source e-government solution available at http://www.openspcoop.org/
it comes with a java installer and extensive guide.

This project aims to follow the installation guide building a docker framework to run the platform.
File "OpenSPCoop2 install.log" shows the choices that were taken to create the dist/ folder.

## Usage
First clone this repository.

    git clone https://github.com/edoardoc/openspcoop2ondocker

Then enter the command:

	docker-compose up

There is a small script that starts everything recreating the images and pulling new versions..

    build_all.sh

> Doing this will start the Wildfly server, trying to deploy OpenSPCoop2.
> At the same time a postgres db will start which will deploy openspcoop2 standard database on start.
> during the first startup the main service will wait for postgres to finish using a bash script.

If everything goes well http://127.0.0.1:8080/pddConsole/ will show the admin console

## Structure
This image has the following structure:

1. openspcoop2img/dist/

    it's the folder output from the install.sh of the OpenSPCoop2 - during the installation all basic choices were made: Wildfly AS, PostgreSQL db, default username and passwords (check "OpenSPCoop2 install.log" for further details)

2. openspcoop2img/drivers/

    this folder contains the correct driver jar to have openspcoop connect to postgres

3. openspcoop2img/check-and-start.sh

	this is a script that the main service will use to delay the startup of Wildfly until the database is ready.

4. openspcoop2img/Dockerfile

    Wildfly Dockerfile that will host the openspcoop2 EAR.

5. docker-compose.yml

	Is the file that contains the service definitions of this project (mainly the service host and the database host)


## Links and References
Following a list of Webpages of all used software and knowledge resources used to build this example.

[OpenSPCoop2 installation guide](http://www.openspcoop.org/openspcoop/doc-file/?guida=installazione&rel=2.3&id=index.html)

[Official Wildfly Docker Image](https://hub.docker.com/r/jboss/wildfly/)

[Docker Reference](https://docs.docker.com/engine/reference/builder/)

[Compose File Reference](https://docs.docker.com/compose/compose-file/)

[Best practices for writing Dockerfiles](https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices/)
