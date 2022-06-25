FROM golang:1.16 as builder

RUN mkdir -p /app
WORKDIR /app

COPY go.mod .

ENV GOPROXY https://proxy.golang.org,direct
ENV CGO_ENABLED=0

RUN go mod download

COPY . .

RUN GOOS=linux go build ./main.go

FROM scratch

WORKDIR /app

COPY --from=builder /app/main .

CMD ["/app/main"]