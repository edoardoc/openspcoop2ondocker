FROM jboss/wildfly
ADD dist/archivi/OpenSPCoop2.ear /opt/jboss/wildfly/standalone/deployments/
ADD dist/datasource/openspcoop2-ds.xml /opt/jboss/wildfly/standalone/deployments/
ADD dist/datasource/openspcoop2_console-ds.xml /opt/jboss/wildfly/standalone/deployments/
ADD drivers/postgresql-9.4.1212.jre7.jar /opt/jboss/wildfly/standalone/deployments/
ADD check-and-start.sh /opt/jboss/

# make sure openspcoop2 gets its own writable log folder
USER root
RUN mkdir -p /var/openspcoop2/log/
RUN chown -R jboss:jboss /var/openspcoop2
RUN chown jboss:jboss /opt/jboss/check-and-start.sh
RUN chmod +x /opt/jboss/check-and-start.sh

# need postgres client library (psql)
RUN yum install postgresql -y
RUN yum install lynx -y

# timezone set for the image
ENV TZ=Europe/Rome
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

USER jboss
# Expose the ports we're interested in
EXPOSE 8080
EXPOSE 9990
CMD ["/opt/jboss/check-and-start.sh"]
