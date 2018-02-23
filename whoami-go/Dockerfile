FROM golang:alpine

COPY app.go /go/app.go

RUN apk update && apk add git
RUN go get github.com/gorilla/websocket

WORKDIR /go
RUN go build -o whoami .
CMD ["/go/whoami"]
