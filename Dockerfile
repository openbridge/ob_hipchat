FROM alpine:edge

COPY hipchat /usr/bin/hippy
RUN echo "@community http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
    && apk update \
    && apk add --no-cache --update --virtual \
        bash \
        curl \
    && chmod +x /usr/bin/hippy \
    && rm -Rf /tmp/*
CMD [""]
