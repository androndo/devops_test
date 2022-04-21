#todo: base arg
FROM golang:1.16-alpine3.14 AS builder

WORKDIR /workspace

COPY ./go.mod ./go.sum ./

RUN go mod download

COPY *.go .

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 GO111MODULE=on go build -a -o app main.go

FROM gcr.io/distroless/static:nonroot
WORKDIR /
COPY --from=builder /workspace/app .
USER 65532:65532

ENV REDIS_ADDR="localhost:6793"

ENTRYPOINT ["/app"]
