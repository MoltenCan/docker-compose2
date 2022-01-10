FROM --platform=$BUILDPLATFORM golang:alpine as builder
COPY compose/ /go/compose
WORKDIR /go/compose/cmd
RUN go build -o /go/bin/docker-compose2 .

# now build the multiplatform
FROM --platform=$BUILDPLATFORM alpine
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM" > /log
COPY --from=builder /go/bin/docker-compose2 /usr/local/bin/docker-compose
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
