FROM rockylinux:9

RUN dnf -y install socat

ADD entrypoint.sh .

ENTRYPOINT ["./entrypoint.sh"]

