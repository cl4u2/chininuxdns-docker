FROM python:2.7.12-alpine
ENV CHININUXPATH /root/chininux

RUN apk --no-cache add dnsmasq
RUN apk --no-cache add git

RUN git clone https://github.com/ninuxorg/chininux $CHININUXPATH
RUN cd $CHININUXPATH; git submodule init; git submodule update
RUN pip install -r $CHININUXPATH/requirements.txt
COPY settings.py $CHININUXPATH/

COPY dnsmasq.conf /etc/dnsmasq.conf
# the contents of this directory are read automatically by dnsmasq
RUN mkdir -p /etc/chosts

# put the script in the crontab
COPY chininuxhostscript /etc/periodic/hourly/chininuxhostscript
RUN chmod +x /etc/periodic/hourly/chininuxhostscript
# and run it once
RUN /etc/periodic/hourly/chininuxhostscript

EXPOSE 53/udp 53/udp

ENTRYPOINT ["dnsmasq", "-d", "--hostsdir=/etc/chosts/", "-C", "/etc/dnsmasq.conf"]

