FROM alpine:3.7

ARG AWS_DEFAULT_REGION=us-east-1
ARG AWSCLI_VER=1.14.61

ARG RUN_SCRIPT='/usr/local/bin/s3backup'

# need gnu date from coreutils
RUN apk add --no-cache --update \
    python3 \
    bash \
    && rm -rf /root/.cache

RUN pip3 install awscli=="${AWSCLI_VER}" --upgrade --no-cache-dir \
    && rm -rf /root/.cache

RUN adduser -S -D -h / -g "s3backup role user" s3backup
COPY scripts/s3backup "${RUN_SCRIPT}"
RUN chmod 0755 "${RUN_SCRIPT}"

USER s3backup
CMD  ["/usr/local/bin/s3backup"]
