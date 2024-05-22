FROM rockylinux:9

RUN dnf -y install \
    socat \
    iputils \
    telnet \
    nc \
    net-tools \
    procps-ng \
    iproute

ADD entrypoint.sh .

ENTRYPOINT ["./entrypoint.sh"]

