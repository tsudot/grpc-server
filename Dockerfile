FROM golang:1.7

MAINTAINER tsudot <kunal.kerkar@grofer.com>

RUN apt-get update && apt-get -y install unzip && apt-get clean


# install protobuf
RUN mkdir -p /tmp/protoc && \
    curl -L https://github.com/google/protobuf/releases/download/v3.0.0/protoc-3.0.0-linux-x86_64.zip > /tmp/protoc/protoc.zip && \
    cd /tmp/protoc && \
    unzip protoc.zip && \
    cp /tmp/protoc/bin/protoc /usr/local/bin && \
    chmod go+rx /usr/local/bin/protoc && \
    cd /tmp && \
    rm -r /tmp/protoc


# Get the source from GitHub
RUN go get google.golang.org/grpc


# Install protoc-gen-go
RUN go get github.com/golang/protobuf/protoc-gen-go

ADD . /go/src/github.com/tsudot/grpc-server

RUN go install github.com/tsudot/grpc-server

ENTRYPOINT /go/bin/grpc-server

EXPOSE 50035
