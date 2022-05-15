# Build Stage
FROM --platform=linux/amd64 ubuntu:20.04
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y make gcc nasm

ADD . /SmallerC
WORKDIR /SmallerC
RUN ./configure
RUN make 
