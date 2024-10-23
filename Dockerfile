FROM registry.access.redhat.com/ubi8/ubi:8.9@sha256:83068ea81dd02717b8e39b55cdeb2c1b2c9a3db260f01381b991755d44b15073 as builder
RUN dnf -y install golang

WORKDIR /go/src/mikefarah/yq

FROM registry.access.redhat.com/ubi8/ubi-minimal:latest@sha256:2fa47fa9df7b98e2776f447855699c01d06c3271b2d7259b8b314084580cf591 as builder2
COPY yq/ .

FROM registry.access.redhat.com/ubi9/ubi@sha256:bc552efb4966aaa44b02532be3168ac1ff18e2af299d0fe89502a1d9fabafbc5 as builder3

FROM registry.access.redhat.com/ubi9/ubi-minimal:9.3 as builder4

FROM registry.access.redhat.com/ubi8/openjdk-8:latest as builder5

RUN CGO_ENABLED=0 go build -ldflags "-s -w" .

# RUN ./scripts/test.sh -- this too often times out in the github pipeline.
RUN ./scripts/acceptance.sh
