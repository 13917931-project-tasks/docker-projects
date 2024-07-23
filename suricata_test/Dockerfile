#Importing databases
#FROM alpine:3.20.1

FROM ubuntu

FROM python:3.11

# Installing dependencies
RUN apt-get update
RUN pip install launchpadlib
RUN apt-get install -y software-properties-common
# The -y parameter is used to skip confirmations
#RUN add-apt-repository -y ppa:oisf/suricata-stable
RUN apt-get install -y autoconf automake build-essential cargo cbindgen libjansson-dev libpcap-dev libpcre2-dev libtool libyaml-dev make pkg-config rustc zlib1g-dev
#Installing Suricata
COPY /suricata-7.0.6.tar.gz /
#RUN curl -o suricata-7.0.6.tar.gz https://www.openinfosecfoundation.org/download/suricata-7.0.6.tar.gz
RUN tar xzvf suricata-7.0.6.tar.gz
RUN cd suricata-7.0.6 && ./configure --prefix=/usr/ --sysconfdir=/etc --localstatedir=/var && make && make install

#Copying custom and community created rules into the container
COPY /local.rules /usr/share/suricata/rules/
COPY /nmap-scans.rules /usr/share/suricata/rules/

#put commands to copy the files to the correct direcories
# write a command "suricata-update" in order to generate the suricata.rules file

#files to put in /etc/suricata
# classification.config  drop.conf    modify.conf       suricata.yaml            threshold.config
# disable.conf           enable.conf  reference.config  suricata.yaml.dpkg-dist  update.yaml


#root@f1891ea6a3b6:/# find / -name "disable.conf" 
#/usr/local/lib/suricata/python/suricata/update/configs/disable.conf
#/suricata-7.0.6/suricata-update/suricata/update/configs/disable.conf

