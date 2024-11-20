FROM registry.access.redhat.com/ubi8/ubi:8.10@sha256:d497966ce214138de5271eef321680639e18daf105ae94a6bff54247d8a191a3 as builder
RUN dnf -y install golang

WORKDIR /go/src/mikefarah/yq

COPY yq/ .


RUN CGO_ENABLED=0 go build -ldflags "-s -w" .

# RUN ./scripts/test.sh -- this too often times out in the github pipeline.
RUN ./scripts/acceptance.sh
