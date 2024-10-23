FROM registry.access.redhat.com/ubi8/ubi:8.10@sha256:a965f33ee4ee57dc8e40a1f9350ddf28ed0727b6cf80db46cdad0486a7580f9d as builder
RUN dnf -y install golang

WORKDIR /go/src/mikefarah/yq

FROM registry.access.redhat.com/ubi8/ubi-minimal:latest@sha256:2fa47fa9df7b98e2776f447855699c01d06c3271b2d7259b8b314084580cf591 as builder2
COPY yq/ .

FROM registry.access.redhat.com/ubi9/ubi@sha256:bc552efb4966aaa44b02532be3168ac1ff18e2af299d0fe89502a1d9fabafbc5 as builder3
FROM registry.access.redhat.com/ubi9/ubi-minimal:9.3 as builder4


RUN CGO_ENABLED=0 go build -ldflags "-s -w" .

# RUN ./scripts/test.sh -- this too often times out in the github pipeline.
RUN ./scripts/acceptance.sh
