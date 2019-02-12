FROM swift:latest

WORKDIR /swift/Sources/Handler

RUN mkdir -p /app
WORKDIR /app
COPY . .
RUN swift build
RUN cp ./.build/x86_64*/debug/Handler ./Handler
RUN chmod +x ./Handler

RUN curl -sSL https://github.com/openfaas/faas/releases/download/0.8.0/fwatchdog > ./fwatchdog
RUN chmod +x ./fwatchdog

ENV fprocess="./Handler"

HEALTHCHECK --interval=2s CMD [ -e /tmp/.lock ] || exit 1

CMD ["./fwatchdog"]
