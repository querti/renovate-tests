FROM registry.access.redhat.com/ubi9/ubi:latest@sha256:b00d5990a00937bd1ef7f44547af6c7fd36e3fd410e2c89b5d2dfc1aff69fe99 as builder2
RUN dnf -y install golang

WORKDIR /go/src/mikefarah/yq

COPY yq/ .

RUN CGO_ENABLED=0 go build -ldflags "-s -w" .

# RUN ./scripts/test.sh -- this too often times out in the github pipeline.
RUN ./scripts/acceptance.sh
