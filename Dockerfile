FROM golang:1.18.1-alpine3.15 as builder
# FROM golang:1.18.1 as builder

COPY go.mod go.sum /go/src/aphisiit/golang-aws-ecs/
WORKDIR /go/src/aphisiit/golang-aws-ecs
RUN go mod download
COPY . /go/src/aphisiit/golang-aws-ecs
RUN apk add git
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o build/golang-aws-ecs gitlab.com/aphisiit/golang-aws-ecs
# RUN go build -o build/golang-aws-ecs


FROM alpine

RUN apk add --no-cache ca-certificates && update-ca-certificates
COPY --from=builder /go/src/aphisiit/golang-aws-ecs/build/golang-aws-ecs /usr/bin/golang-aws-ecs

EXPOSE 8080 8080

ENTRYPOINT ["/usr/bin/golang-aws-ecs"]
