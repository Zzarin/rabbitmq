FROM golang:1.14-alpine as build

WORKDIR /src

COPY go.mod ./
COPY go.sum ./
RUN go mod download

COPY consumer.go /src

RUN go build -o consumer consumer.go

CMD [ "./consumer" ]