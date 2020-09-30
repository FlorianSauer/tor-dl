FROM ubuntu:latest

ENV download_rate=""

RUN apt-get update && \
    apt-get install -y tor screen curl python3 python3-pip nano ffmpeg && \
    pip3 install youtube-dl && \
    mkdir -p /out && \
    sed -i s/#IsolatePID.*/IsolatePID\ 1/ /etc/tor/torsocks.conf

COPY ./entrypoint.sh /entrypoint.sh
COPY ./tor-dl-* /usr/bin/
COPY ./bash_rc_addendum.sh /tmp/

RUN chmod +x /entrypoint.sh && chmod +x /usr/bin/tor-dl-* && \
    cat /tmp/bash_rc_addendum.sh >> /etc/bash.bashrc && rm /tmp/bash_rc_addendum.sh

WORKDIR /out

#ENV URL ""

CMD /entrypoint.sh