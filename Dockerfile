FROM golang:alpine3.18 AS go-build

WORKDIR build
ADD . .

RUN go mod init github.com/coyove/goflyway
RUN go mod tidy
RUN go build ./cmd/goflyway
