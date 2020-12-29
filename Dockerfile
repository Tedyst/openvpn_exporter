FROM golang
WORKDIR /app
COPY . /app
RUN go mod download && CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app .

FROM scratch
LABEL org.opencontainers.image.source https://github.com/Tedyst/openvpn_exporter
COPY --from=0 /app/app /bin/openvpn_exporter
ENTRYPOINT ["/bin/openvpn_exporter"]
CMD [ "-h" ]
