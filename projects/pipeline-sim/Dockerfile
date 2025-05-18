FROM alpine:latest
RUN apk add --no-cache bash git tar openssh
WORKDIR /pipeline
RUN mkdir -p ~/.ssh && \
    ssh-keyscan github.com >> ~/.ssh/known_hosts
COPY pipeline.sh .
RUN chmod +x pipeline.sh
RUN git config --global --add safe.directory /pipeline
CMD ["./pipeline.sh"]