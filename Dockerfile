FROM registry.access.redhat.com/ubi9/ubi-minimal:9.4-1227.1726694542 as builder
RUN dnf -y install golang

WORKDIR /go/src/mikefarah/yq
COPY yq/ .

RUN CGO_ENABLED=0 go build -ldflags "-s -w" .

# RUN ./scripts/test.sh -- this too often times out in the github pipeline.
RUN ./scripts/acceptance.sh
