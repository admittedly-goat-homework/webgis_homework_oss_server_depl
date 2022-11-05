FROM ubuntu:20.04
RUN apt update
RUN DEBIAN_FRONTEND=noninteractive apt install -y qgis-server
RUN DEBIAN_FRONTEND=noninteractive apt install -y apache2 libapache2-mod-fcgid
RUN apt install wget
RUN mkdir /home/qgis
RUN mkdir /home/qgis/projects
# == START == Download the example qgis project to /home/qgis/projects/
WORKDIR /home/qgis/projects
COPY ./qgis_project/ .
# == END ==
WORKDIR /
RUN apt install apache2 libapache2-mod-fcgid
COPY ./apache_config/qgis.demo.conf /etc/apache2/sites-available
RUN mkdir -p /var/log/qgis/
RUN chown www-data:www-data /var/log/qgis
RUN mkdir -p /home/qgis/qgisserverdb
RUN chown www-data:www-data /home/qgis/qgisserverdb
RUN a2enmod fcgid
RUN a2ensite qgis.demo
EXPOSE 80
EXPOSE 443
RUN service apache2 start && service apache2 reload && service apache2 stop
CMD service apache2 start && tail -f /dev/null