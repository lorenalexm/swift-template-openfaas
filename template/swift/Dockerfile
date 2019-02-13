FROM swift:latest

WORKDIR /swift/Sources/Handler

RUN mkdir -p /app
WORKDIR /app
COPY . .
RUN mv ./function/Package.swift ./Package.swift
RUN mv ./function/Handler.swift ./Sources/Handler/Handler.swift
RUN swift build
RUN chmod +x ./.build/x86_64-unknown-linux/debug/Handler

RUN curl -sSL https://github.com/openfaas/faas/releases/download/0.8.0/fwatchdog > ./fwatchdog
RUN chmod +x ./fwatchdog

ENV fprocess="./.build/x86_64-unknown-linux/debug/Handler"

HEALTHCHECK --interval=2s CMD [ -e /tmp/.lock ] || exit 1

CMD ["./fwatchdog"]
