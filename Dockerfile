ARG OS=linux
ARG ARCH=amd64

FROM golang:1.19.3-alpine3.15 as builder

WORKDIR /go/src/github.com/eko/pihole-exporter
COPY . .

RUN apk --no-cache add git alpine-sdk

RUN GO111MODULE=on go mod vendor
RUN CGO_ENABLED=0 GOOS=$OS GOARCH=$ARCH go build -ldflags '-s -w' -o /pihole-exporter ./
LABEL name="pihole-exporter"
CMD ["/pihole-exporter"]
