FROM golang:1.18.3-alpine as builder
WORKDIR /app
COPY ./hello.go .
RUN apk --no-cache add upx
RUN go build -ldflags="-s" hello.go \
    && upx --best --lzma hello 

FROM scratch
WORKDIR /app
COPY --from=builder /app/hello .

ENTRYPOINT [ "./hello" ]