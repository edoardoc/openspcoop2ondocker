#!/bin/sh
# this is a script that keeps checking if the db has been fully populated
export PGPASSWORD=openspcoop2
while true; do

        string="$(psql -h mydatabase -U openspcoop2 -d openspcoop2 -c 'SELECT login from users')"
        if [[ $string == *"amministratore"* ]]; then
                echo "It's there!";
                break;
        else
                echo "waiting..."
                sleep 2s;
        fi
done
/opt/jboss/wildfly/bin/standalone.sh -b 0.0.0.0
