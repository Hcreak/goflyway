FROM golang:alpine3.18 AS go-build

WORKDIR /build
ADD . .

RUN go mod init github.com/coyove/goflyway
RUN go mod tidy
RUN go build ./cmd/goflyway

FROM alpine:3.18

WORKDIR /opt
COPY --from=go-build /build/goflyway .
ADD chinalist.txt .
ADD run.sh .

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN chmod +x run.sh

EXPOSE 1081
EXPOSE 1091
CMD ["./run.sh"]
