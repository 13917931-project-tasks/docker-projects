#!/bin/sh

suricata-update
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
RUN sed -i '/address-groups:/a\    HOME_NET="[10.0.0.0/24]"' /etc/suricata/suricata.yaml
#adds a new HOME_NET
## TODO: add suricata-udpate (using RUN or ENTRYPOINT)
#find / -name "suricata.rules"
