#Importing databases
FROM alpine:3.20.1

#FROM ubuntu

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
COPY /emerging.rules.tar.gz /
RUN tar xzvf /emerging.rules.tar.gz && cp -r /rules/* /usr/share/suricata/rules/ 
RUN cp -r /suricata-7.0.6/suricata.yaml /etc/suricata/
RUN cp -r /suricata-7.0.6/threshold.config /etc/suricata
RUN cp -r /usr/share/suricata/reference.config /etc/suricata
RUN cp -r /usr/share/suricata/classification.config /etc/suricata

RUN rm -rf /usr/lib/suricata/python/suricata/update/configs/update.yaml
COPY update.yaml /etc/suricata
RUN cd /var/log && mkdir suricata

#disabling rules that can generate false positives
RUN echo " " >> /usr/lib/suricata/python/suricata/update/configs/disable.conf
RUN echo 1000013 >> /usr/lib/suricata/python/suricata/update/configs/disable.conf
RUN echo 2231000 >> /usr/lib/suricata/python/suricata/update/configs/disable.conf
RUN echo 2100528 >> /usr/lib/suricata/python/suricata/update/configs/disable.conf
RUN echo 2400021 >> /usr/lib/suricata/python/suricata/update/configs/disable.conf
RUN echo 2400015 >> /usr/lib/suricata/python/suricata/update/configs/disable.conf
RUN echo 2400002 >> /usr/lib/suricata/python/suricata/update/configs/disable.conf
RUN echo 2010935 >> /usr/lib/suricata/python/suricata/update/configs/disable.conf
RUN echo 2010939 >> /usr/lib/suricata/python/suricata/update/configs/disable.conf
RUN echo 2010936 >> /usr/lib/suricata/python/suricata/update/configs/disable.conf
RUN echo 2010936 >> /usr/lib/suricata/python/suricata/update/configs/disable.conf
RUN echo 2002911 >> /usr/lib/suricata/python/suricata/update/configs/disable.conf
RUN echo 2010937 >> /usr/lib/suricata/python/suricata/update/configs/disable.conf
RUN echo 2002910 >> /usr/lib/suricata/python/suricata/update/configs/disable.conf
#maybe disable this one --> RUN echo 2100366 >> /usr/lib/suricata/python/suricata/update/configs/disable.conf

#setting guradian
COPY guardian-1.7 /guardian-1.7
RUN cd guardian-1.7/ && cp guardian.conf /etc/ 
#defining the suricata file which will be analyzed by guardian
RUN sed -i 's@/var/adm/secure@/var/log/suricata/eve.json@g' /etc/guardian.conf
#defining controller's IP
RUN sed -i 's@X.X.X.X@127.0.0.1@g' /etc/guardian.conf 
#defining the interface which will be analyzed
RUN sed -i 's/Interface       eth0/Interface       nettap1-eth2/' /etc/guardian.conf
#configuring the files which will be used by guardian to block and unblock hosts
RUN cd guardian-1.7 && cp guardian.pl /usr/local/bin/ && cp scripts/sdnips_block.sh /usr/local/bin/guardian_block.sh && cp scripts/sdnips_unblock.sh /usr/local/bin/guardian_unblock.sh 
##TODO: configure HostIPaddr in guardian.conf

#activate guardian
#/usr/local/bin/guardian.pl -c /etc/guardian.conf 
#see guardian's logs
#tail /var/log/guardian.log 

RUN sed -i '/^af-packet:/ {n; s/^/#/;}' /etc/suricata/suricata.yaml
#comment the default interface for af-packet
RUN sed -i '/^pcap:/ {n; s/^/#/;}' /etc/suricata/suricata.yaml
#comment the default interface for pcap
RUN sed -i '/^af-packet:/a\#my_example' /etc/suricata/suricata.yaml
#creates a variable used to add new interfaces
RUN sed -i '/^pcap:/a\#my_example' /etc/suricata/suricata.yaml
#creates a variable used to add new interfaces
RUN sed -i '/^#my_example/a\  - inteface: nettap1-eth2' /etc/suricata/suricata.yaml
#adding a new interface to suricata
RUN sed -i '/address-groups:/ {n; s/^/#/;}' /etc/suricata/suricata.yaml
#comment the default HOME_NET
RUN sed -i '/address-groups:/a\    HOME_NET: "[10.0.0.0/24]"' /etc/suricata/suricata.yaml
#adds a new HOME_NET
RUN suricata-update
#creates suricata.rules file

#CMD ["/etc/suricata/suricata.yaml"]

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


