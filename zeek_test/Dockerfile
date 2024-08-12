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

RUN apt-get update && apt-get install -y cmake 
RUN pip install --upgrade pip
RUN python3.11 -m pip install GitPython semantic-version

#installing the custom analyzer
RUN /opt/zeek/bin/zkg install --force DNSAnomalies/
#configuring zeek to recognize the custom script
RUN echo " " >> /opt/zeek/share/zeek/site/local.zeek
RUN echo "@load protocols/dnstunnel/main" >> /opt/zeek/share/zeek/site/local.zeek

RUN export PATH=/opt/zeek/bin:$PATH && cd /DNSAnomalies/analyzer && rm -rf dnsanomalies.hlto && /opt/zeek/bin/spicyz -o dnsanomalies.hlto dnsanomalies.spicy dnsanomalies.evt 

#configuring the interface
RUN sed -i 's/^interface=eth0/interface=nettap1-eth2/' /opt/zeek/etc/node.cfg

#RUN zkg install /DNSAnomalies
# Informs Docker that a specific port is used by the application running inside the container
#EXPOSE 2752
