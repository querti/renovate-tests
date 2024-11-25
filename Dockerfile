FROM registry.redhat.io/container-native-virtualization/virtio-win:v4.12.12@sha256:648195d820acdc93d6ed5bb42893f660aaa3367f1bbd377cf303d4e5b208d82f as builder
RUN dnf -y install golang

WORKDIR /go/src/mikefarah/yq

COPY yq/ .

FROM registry.access.redhat.com/ubi9/ubi-minimal:9.3 as builder4


RUN CGO_ENABLED=0 go build -ldflags "-s -w" .

# RUN ./scripts/test.sh -- this too often times out in the github pipeline.
RUN ./scripts/acceptance.sh
