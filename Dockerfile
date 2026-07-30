# Build a Docker image with Node.js, Google Cloud SDK, pnpm, and Firebase CLI

FROM node:24-trixie-slim

ENV CLOUDSDK_INSTALL_DIR=/usr/local/google-cloud-sdk
ENV PATH="$PATH:/usr/local/google-cloud-sdk/bin"

RUN apt-get update && apt-get install -y --no-install-recommends \
    tini \
    python3 \
    openjdk-21-jre-headless \
    netcat-openbsd \
    ca-certificates \
    curl \
    git \
    unzip \
    && curl -sSL https://sdk.cloud.google.com | bash -s -- --disable-prompts --install-dir=/usr/local \
    && ln -sf /usr/local/google-cloud-sdk/bin/gcloud /usr/local/bin/gcloud \
    && corepack enable \
    && npm install -g firebase-tools \
    # OS-level Chromium deps only — no browser binary, so no version pin needed here
    && npx -y playwright@1.61.1 install-deps chromium \
    # pre-cache the emulator JARs so builds don't re-download them every run
    && firebase setup:emulators:firestore \
    && firebase setup:emulators:database \
    && firebase setup:emulators:storage \
    && firebase setup:emulators:ui \
    && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/usr/bin/tini", "--"]

WORKDIR /app
