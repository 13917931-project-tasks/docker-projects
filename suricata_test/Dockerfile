#Importing databases
FROM alpine:3.20.1

FROM python:3.11

# Installing dependencies
RUN apt-get install software-properties-common
RUN add-apt-repository ppa:oisf/suricata-stable
RUN apt update
#Installing Suricata
RUN apt install -y suricata jq

#Copying modified rules into the container
COPY /local.rules /usr/share/suricata/rules/

