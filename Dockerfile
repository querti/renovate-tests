FROM registry.access.redhat.com/ubi8/ubi:8.9@sha256:83068ea81dd02717b8e39b55cdeb2c1b2c9a3db260f01381b991755d44b15073 as builder
RUN dnf -y install golang

WORKDIR /go/src/mikefarah/yq

FROM registry.access.redhat.com/ubi8/ubi-minimal:latest@sha256:2fa47fa9df7b98e2776f447855699c01d06c3271b2d7259b8b314084580cf591 as builder2
COPY yq/ .

FROM registry.access.redhat.com/ubi9/ubi@sha256:b00d5990a00937bd1ef7f44547af6c7fd36e3fd410e2c89b5d2dfc1aff69fe99 as builder3
FROM registry.access.redhat.com/ubi9/ubi-minimal:9.3 as builder4


RUN CGO_ENABLED=0 go build -ldflags "-s -w" .

# RUN ./scripts/test.sh -- this too often times out in the github pipeline.
RUN ./scripts/acceptance.sh
