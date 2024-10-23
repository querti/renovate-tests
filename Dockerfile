FROM registry.access.redhat.com/ubi9/ubi@sha256:bc552efb4966aaa44b02532be3168ac1ff18e2af299d0fe89502a1d9fabafbc5 as builder3
RUN dnf -y install golang

WORKDIR /go/src/mikefarah/yq
COPY yq/ .


RUN CGO_ENABLED=0 go build -ldflags "-s -w" .

# RUN ./scripts/test.sh -- this too often times out in the github pipeline.
RUN ./scripts/acceptance.sh
