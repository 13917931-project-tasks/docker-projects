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
#RUN cd suricata-7.0.6 && ./configure && make && make install
RUN apt-get install && pip install pyyaml
#Copying custom and community created rules into the container
COPY /local.rules /usr/share/suricata/rules
COPY /nmap-scans.rules /usr/share/suricata/rules/

RUN cd /etc && mkdir suricata
COPY /rules /usr/share/suricata/rules/
RUN cp -r /suricata-7.0.6/suricata.yaml /etc/suricata/
RUN cp -r /suricata-7.0.6/threshold.config /etc/suricata
RUN cp -r /usr/share/suricata/reference.config /etc/suricata
RUN cp -r /usr/share/suricata/classification.config /etc/suricata

RUN rm -rf /usr/lib/suricata/python/suricata/update/configs/update.yaml
COPY update.yaml /etc/suricata
RUN cd /var/log && mkdir suricata
#RUN suricata-udpate
# modbus and dnp3 between the lines 1120 and 1160 -> turn to yes
#RUN suricata -T

#put commands to copy the files to the correct direcories
# write a command "suricata-update" in order to generate the suricata.rules file

#files to put in /etc/suricata
# classification.config  drop.conf    modify.conf       suricata.yaml            threshold.config
# disable.conf           enable.conf  reference.config  suricata.yaml.dpkg-dist  update.yaml


#root@f1891ea6a3b6:/# find / -name "disable.conf" 
#/usr/local/lib/suricata/python/suricata/update/configs/disable.conf
#/suricata-7.0.6/suricata-update/suricata/update/configs/disable.conf

# cp -r /usr/share/suricata/reference.config /etc/suricata

# cp -r /suricata-7.0.6/suricata.yaml /etc/suricata

# cp -r /usr/share/suricata/classification.config /etc/suricata


