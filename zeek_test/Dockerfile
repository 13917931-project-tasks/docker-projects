FROM alpine:3.20.1

FROM python:3.11

RUN mkdir /DNSAnomalies

COPY /DNSAnomalies /DNSAnomalies

# Installing Zeek dependencies
RUN echo 'deb http://download.opensuse.org/repositories/security:/zeek/xUbuntu_22.04/ /' | tee /etc/apt/sources.list.d/security:zeek.list
RUN curl -fsSL https://download.opensuse.org/repositories/security:zeek/xUbuntu_22.04/Release.key | gpg --dearmor | tee /etc/apt/trusted.gpg.d/security_zeek.gpg > /dev/null
RUN apt update
# The usage of "-y paramater promotes the skipping of confirmations"
RUN apt install -y zeek-6.0

RUN mkdir /opt/zeek/share/zeek/policy/protocols/dnstunnel

COPY /main.zeek /opt/zeek/share/zeek/policy/protocols/dnstunnel

EXPOSE 2752