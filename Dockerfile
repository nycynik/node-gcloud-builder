# Build a Docker image with Node.js, Google Cloud SDK, pnpm, and Firebase CLI

FROM node:24-alpine

# Set environment variables for non-interactive installs
ENV CLOUDSDK_INSTALL_DIR=/usr/local/google-cloud-sdk
ENV PATH="$PATH:/usr/local/google-cloud-sdk/bin"

# Combine installs into one layer to keep the image small
RUN apk add --no-cache \
    bash \
    python3 \
    py3-crcmod \
    gcompat \
    openssl \
    ca-certificates \
    curl \
    git \
    unzip \
    && curl -sSL https://sdk.cloud.google.com | bash -s -- --disable-prompts --install-dir=/usr/local \
    && ln -sf /usr/local/google-cloud-sdk/bin/gcloud /usr/local/bin/gcloud \
    && npm install -g pnpm@9 firebase-tools

# Set the working directory
WORKDIR /app
