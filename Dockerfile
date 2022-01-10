FROM --platform=$BUILDPLATFORM golang:alpine as builder
COPY compose/ /go/compose
WORKDIR /go/compose/cmd
# macos
RUN GOOS=darwin GOARCH=arm64 go build -o /go/bin/linux/arm64/docker-compose2 .
# rpi3+
RUN GOOS=linux GOARCH=arm GOARM=7 go build -o /go/bin/linux/arm/v7/docker-compose2 .
# rpi
RUN GOOS=linux GOARCH=arm GOARM=6 go build -o /go/bin/linux/arm/v6/docker-compose2 .
# linux
RUN GOOS=linux GOARCH=amd64 go build -o /go/bin/linux/amd64/docker-compose2 .

# now build the multiplatform
FROM --platform=$TARGETPLATFORM alpine
ARG TARGETPLATFORM
COPY --from=builder /go/bin/${TARGETPLATFORM}/docker-compose2 /usr/local/bin/docker-compose2
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]


# "linux/arm/v7,linux/arm/v6,linux/amd64,linux/arm64/v8"