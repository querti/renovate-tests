FROM registry.access.redhat.com/ubi9/ubi:9.3@sha256:66233eebd72bb5baa25190d4f55e1dc3fff3a9b77186c1f91a0abdb274452072 as builder
RUN dnf -y install golang

WORKDIR /go/src/mikefarah/yq

FROM registry.access.redhat.com/ubi9/ubi:latest@sha256:b00d5990a00937bd1ef7f44547af6c7fd36e3fd410e2c89b5d2dfc1aff69fe99 as builder2
COPY yq/ .

FROM registry.access.redhat.com/ubi9/ubi@sha256:b00d5990a00937bd1ef7f44547af6c7fd36e3fd410e2c89b5d2dfc1aff69fe99 as builder3

FROM registry.access.redhat.com/ubi9/ubi-minimal:9.3 as builder4

FROM registry.access.redhat.com/ubi9/ubi:9.4-1194 as builder5

RUN CGO_ENABLED=0 go build -ldflags "-s -w" .

# RUN ./scripts/test.sh -- this too often times out in the github pipeline.
RUN ./scripts/acceptance.sh
