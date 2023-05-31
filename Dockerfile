FROM golang:1.20.4-alpine3.18 AS build
WORKDIR $GOPATH/src/github.com/jskeates/dave/
COPY . .
RUN go build -o /go/bin/dave cmd/dave/main.go
RUN go build -o /go/bin/davecli cmd/davecli/main.go

FROM alpine:latest  
RUN adduser -S dave
COPY --from=build /go/bin/davecli /usr/local/bin
COPY --from=build /go/bin/dave /usr/local/bin
USER dave
ENTRYPOINT ["/usr/local/bin/dave"]
