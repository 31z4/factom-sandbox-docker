FROM debian:8.2
MAINTAINER Elisey Zanko <elisey.zanko@gmail.com>

# Install Supervisor
RUN apt-get update && apt-get install -y supervisor

# Install Factom
ADD http://factom.org/downloads/factom.deb ./
RUN dpkg --force-architecture -i factom.deb && rm factom.deb

# Copy configs
COPY factomd.conf /root/.factom/
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 8088 8089 8090
CMD ["/usr/bin/supervisord"]
