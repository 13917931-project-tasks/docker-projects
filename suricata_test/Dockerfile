#Importing databases
FROM alpine:3.20.1

FROM python:3.11

# Installing dependencies
RUN apt-get update
RUN apt-get install -y launchpadlib
RUN apt-get install -y software-properties-common
# The -y parameter is used to skip confirmations
RUN add-apt-repository -y ppa:oisf/suricata-stable
RUN apt-get update
#Installing Suricata
RUN apt install -y suricata jq

#Copying custom and community created rules into the container
COPY /local.rules /usr/share/suricata/rules/
COPY /nmap-scans.rules /usr/share/suricata/rules/
