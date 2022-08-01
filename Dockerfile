FROM busybox AS builder

ARG dir="77082"
ARG name="pukiwiki-1.5.4_utf8"

RUN wget "http://iij.dl.osdn.jp/pukiwiki/$dir/$name.zip"
RUN unzip "$name.zip"
RUN mv ${name} pukiwiki

WORKDIR /pukiwiki
RUN rm -f *.txt *.zip
RUN mkdir -p .orig/conf .orig/data
RUN for i in `find * -maxdepth 0 -name '*.ini.php'`; do mv $i .orig/conf/; ln -s /ext/conf/$i; done
RUN for i in `find * -maxdepth 0 -type d -perm 2777`; do mv $i .orig/data/; ln -s /ext/data/$i; done


FROM alpine:latest
LABEL org.opencontainers.image.authors="arqtan <arq@asaasa.tk>" \
    org.opencontainers.image.source="https://github.com/arqtan/docker-pukiwiki"

RUN apk add --no-cache \
            h2o \
            perl \
            php8-cgi

COPY --from=builder /pukiwiki /var/www
COPY rootfs /

VOLUME /ext
EXPOSE 80

CMD ["/etc/rc.entry"]
