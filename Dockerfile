FROM golang
WORKDIR /app
COPY . /app
RUN go mod download && CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app .

FROM scratch
COPY --from=0 /app/app /bin/openvpn_exporter
ENTRYPOINT ["/bin/openvpn_exporter"]
CMD [ "-h" ]
