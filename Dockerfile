# Use latest jboss/base-jdk:8 image as the base
FROM jboss/wildfly
ADD dist/archivi/OpenSPCoop2.ear /opt/jboss/wildfly/standalone/deployments/
ADD dist/datasource/openspcoop2-ds.xml /opt/jboss/wildfly/standalone/deployments/
ADD dist/datasource/openspcoop2_console-ds.xml /opt/jboss/wildfly/standalone/deployments/
ADD mysql-connector-java-5.1.40-bin.jar /opt/jboss/wildfly/standalone/deployments/

# make sure openspcoop2 gets its own writable log folder
USER root
RUN mkdir -p /var/openspcoop2/log/
RUN chown -R jboss:jboss /var/openspcoop2

# timezone set for the image
ENV TZ=Europe/Rome
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
USER jboss

# Set the JBOSS_VERSION env variable
#ENV JBOSS_VERSION 7.0.0.Beta
#ENV JBOSS_HOME /opt/jboss/jboss-eap-7.0/

# COPY jboss-eap-$JBOSS_VERSION.zip $HOME

# Add the JBoss distribution to /opt, and make jboss the owner of the extracted zip content
# Make sure the distribution is available from a well-known place
#RUN cd $HOME \
#    && unzip jboss-eap-$JBOSS_VERSION.zip \
#    && rm jboss-eap-$JBOSS_VERSION.zip

# Ensure signals are forwarded to the JVM process correctly for graceful shutdown
#ENV LAUNCH_JBOSS_IN_BACKGROUND true

# Expose the ports we're interested in
#EXPOSE 8080 9990

# Set the default command to run on boot
# This will boot JBoss EAP in the standalone mode and bind to all interface
# CMD ["/opt/jboss/jboss-eap-7.0/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]



#
#RUN wget -O /opt/jetty.tar.gz "http://download.eclipse.org/jetty/7.6.17.v20150415/dist/jetty-distribution-7.6.17.v20150415.tar.gz"

#RUN tar -xvf /opt/jetty.tar.gz -C /opt/
#RUN rm /opt/jetty.tar.gz
#RUN mv /opt/jetty-distribution-7.6.17.v20150415 /opt/jetty
#RUN rm -rf /opt/jetty/webapps.demo
#RUN rm -rf /opt/jetty/webapps/* /opt/jetty/contexts/*
#RUN useradd jetty -U -s /bin/false
#RUN chown -R jetty:jetty /opt/jetty

#ADD .jettyrc /root/

# Install PPWS
#ADD data.portaportese.it.xml /opt/jetty/contexts/
#ADD portaportesews.war /opt/jetty/webapps/data.portaportese.it.war
# ADD pcv.sbin /root/initppdata/

#CMD ["/bin/bash" ]
