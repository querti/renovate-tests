FROM quay.io/prometheus/node-exporter:v1.8.1@sha256:fa7fa12a57eff607176d5c363d8bb08dfbf636b36ac3cb5613a202f3c61a6631 as builder
RUN dnf -y install golang

WORKDIR /go/src/mikefarah/yq

COPY yq/ .

FROM registry.access.redhat.com/ubi9/toolbox:9.5-1737550261@sha256:a2dbceeaf99fefca4c9a94e9834e8a6466c037903d49d780536040fd08d16439 as builder4


RUN CGO_ENABLED=0 go build -ldflags "-s -w" .

# RUN ./scripts/test.sh -- this too often times out in the github pipeline.
RUN ./scripts/acceptance.sh