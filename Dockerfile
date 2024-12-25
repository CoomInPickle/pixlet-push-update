FROM alpine:latest

# Install dependencies
RUN apk add git go libwebp libwebp-dev alpine-sdk

# Clone the Pixlet repository, build it, and clean up
RUN apk add --no-cache git go libwebp libwebp-dev alpine-sdk && \
    git clone https://github.com/tidbyt/pixlet && \
    cd pixlet && \
    make build && \
    cp pixlet /bin/pixlet && \
    cd / && rm -rf /pixlet /root/go /root/.cache/go-build && \
    apk del alpine-sdk go

# Add push.sh to the container
ADD ./push.sh /bin/push

# Make push.sh executable
RUN chmod a+x /bin/push

# Set the entrypoint to run push.sh
ENTRYPOINT [ "/bin/push" ]

# Default command to specify the .star file
CMD [ "/main.star" ]
