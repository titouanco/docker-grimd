FROM golang:1.9-alpine3.7 as builder
LABEL maintainer "Titouan Condé <eownis+docker@titouan.co>"

ARG GRIMD_VERSION=master

RUN apk add --no-cache git
RUN mkdir -p $GOPATH/src/github.com/looterz
RUN git clone --depth 1 --branch $GRIMD_VERSION https://github.com/looterz/grimd.git $GOPATH/src/github.com/looterz/grimd
RUN cd $GOPATH/src/github.com/looterz/grimd && go get -v && go build -v

FROM alpine:3.7
LABEL org.label-schema.name="grimd" \
      org.label-schema.vcs-url="https://git.titouan.co/eownis/docker-grimd"

ENV UID="991" \
    GID="991"

COPY --from=builder /go/src/github.com/looterz/grimd/grimd /usr/local/bin/grimd
COPY start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh

COPY grimd.toml /grimd.toml

RUN apk add --no-cache libcap runit tini \
    && setcap cap_net_bind_service=+eip /usr/local/bin/grimd \
    && apk del libcap

VOLUME /config
EXPOSE 53/udp 53/tcp 8080/tcp

WORKDIR /config
CMD ["/sbin/tini","--","/usr/local/bin/start.sh"]
