FROM golang:1.18.3-alpine as builder
WORKDIR /app
COPY ./hello.go .
RUN apk --no-cache add upx
RUN go build -ldflags="-s" hello.go \
    && upx --best --lzma hello 

FROM alpine:3.16
WORKDIR /app
COPY --from=builder /app/hello .

ENTRYPOINT [ "./hello" ]