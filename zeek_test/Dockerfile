# Importing databases
FROM alpine:3.20.1

FROM python:3.11

# Creating a folder to host the custom analyzer
RUN mkdir /DNSAnomalies

# Copying the custom analyzer into the docker container
COPY /DNSAnomalies /DNSAnomalies

# Installing Zeek dependencies
RUN echo 'deb http://download.opensuse.org/repositories/security:/zeek/xUbuntu_22.04/ /' | tee /etc/apt/sources.list.d/security:zeek.list
RUN curl -fsSL https://download.opensuse.org/repositories/security:zeek/xUbuntu_22.04/Release.key | gpg --dearmor | tee /etc/apt/trusted.gpg.d/security_zeek.gpg > /dev/null
RUN apt update
# The usage of "-y paramater promotes the skipping of confirmations"
RUN apt install -y zeek-6.0

# Creating a folder to host the custom script
RUN mkdir /opt/zeek/share/zeek/policy/protocols/dnstunnel

# moving the custom script into the container
COPY /main.zeek /opt/zeek/share/zeek/policy/protocols/dnstunnel

# TODO: Write code to install the analyzer and to enable the custom script using echo

RUN /opt/zeek/bin/zkg install /DNSAnomalies
RUN echo "@load protocols/dnstunnel/main" >> /opt/zeek/share/zeek/site/local.zeek

# Informs Docker that a specific port is used by the application running inside the container
EXPOSE 2752
