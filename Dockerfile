# Build Stage
FROM --platform=linux/amd64 ubuntu:20.04 as builder
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y make gcc nasm

ADD . /SmallerC
WORKDIR /SmallerC
RUN ./configure
RUN make 

RUN mkdir -p /deps
RUN ldd /SmallerC/smlrc | tr -s '[:blank:]' '\n' | grep '^/' | xargs -I % sh -c 'cp % /deps;'

FROM ubuntu:20.04

COPY --from=builder /deps /deps
COPY --from=builder /SmallerC/smlrc /SmallerC/smlrc
ENV LD_LIBRARY_PATH=/deps