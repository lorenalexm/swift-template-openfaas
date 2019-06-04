FROM swift:4.2.4

RUN useradd -rm --shell /bin/bash swiftfunc
WORKDIR /home/swiftfunc
COPY . .

RUN mv ./function/Package.swift ./Package.swift && \
  mv ./function/*.swift ./Sources/Handler/. && \
  swift build && \
  chmod +x ./.build/x86_64-unknown-linux/debug/Handler && \
  curl -sSL https://github.com/openfaas/faas/releases/download/0.8.0/fwatchdog > ./fwatchdog && \
  chmod +x ./fwatchdog

ENV fprocess="./.build/x86_64-unknown-linux/debug/Handler"

HEALTHCHECK --interval=2s CMD [ -e /tmp/.lock ] || exit 1

CMD ["./fwatchdog"]
