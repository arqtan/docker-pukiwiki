FROM alpine:3.19 AS builder

ARG tag="r1_5_4"

RUN apk update && apk add curl
RUN curl -LO "https://github.com/pukiwiki/pukiwiki/archive/refs/tags/$tag.tar.gz"
RUN tar zxf "$tag.tar.gz"
RUN mv "pukiwiki-$tag" pukiwiki

WORKDIR /pukiwiki
RUN rm -f *.txt *.tar.gz
RUN mkdir -p .orig/conf .orig/data
RUN for i in `find * -maxdepth 0 -name '*.ini.php'`; do mv $i .orig/conf/; ln -s /ext/conf/$i; done
RUN for i in `find * -maxdepth 0 -type d -perm 2777`; do mv $i .orig/data/; ln -s /ext/data/$i; done


FROM alpine:3.19
LABEL org.opencontainers.image.authors="arqtan <arq@asaasa.tk>" \
    org.opencontainers.image.source="https://github.com/arqtan/docker-pukiwiki"

RUN apk add --no-cache \
            h2o \
            perl \
            php82-cgi

COPY --from=builder /pukiwiki /var/www
COPY rootfs /

VOLUME /ext
EXPOSE 80

CMD ["/etc/rc.entry"]
