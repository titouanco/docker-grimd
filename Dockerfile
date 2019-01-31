FROM golang:1.11-alpine3.8 as builder

ARG GRIMD_VERSION=master

RUN apk add --no-cache git
RUN mkdir -p $GOPATH/src/github.com/looterz
RUN git clone --depth 1 --branch $GRIMD_VERSION https://github.com/looterz/grimd.git $GOPATH/src/github.com/looterz/grimd

WORKDIR $GOPATH/src/github.com/looterz/grimd

RUN go get -v
RUN go build -v -ldflags="-s -w"

FROM alpine:3.9
LABEL maintainer "Titouan Condé <hi+docker@titouan.co>"
LABEL org.label-schema.name="grimd" \
      org.label-schema.vcs-url="https://code.titouan.co/titouan/docker-grimd"

ENV UID="991" \
    GID="991"

COPY --from=builder /go/src/github.com/looterz/grimd/grimd /usr/local/bin/grimd
COPY start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh

COPY grimd.toml /grimd.toml

RUN apk add --no-cache libcap runit tini ca-certificates \
    && setcap cap_net_bind_service=+eip /usr/local/bin/grimd \
    && apk del libcap

VOLUME /config
EXPOSE 53/udp 53/tcp 8080/tcp

WORKDIR /config
CMD ["/sbin/tini","--","/usr/local/bin/start.sh"]
