FROM golang:latest as build

WORKDIR /src

COPY go.mod ./
COPY go.sum ./
RUN go mod download

COPY publisher.go /src

RUN go build -o publisher publisher.go

CMD [ "./publisher" ]