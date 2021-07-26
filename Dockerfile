FROM rust:1.53.0


ENV NODE_VERSION=14.17.3
ENV PATH="/root/.local/share/solana/install/active_release/bin:${PATH}"

RUN apt-get update && \
    apt install -y curl

RUN sh -c "$(curl -sSfL https://release.solana.com/v1.6.8/install)"

RUN solana config set --url https://api.devnet.solana.com


RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash
ENV NVM_DIR=/root/.nvm
RUN . "$NVM_DIR/nvm.sh" && nvm install ${NODE_VERSION}
RUN . "$NVM_DIR/nvm.sh" && nvm use v${NODE_VERSION}
RUN . "$NVM_DIR/nvm.sh" && nvm alias default v${NODE_VERSION}
ENV PATH="/root/.nvm/versions/node/v${NODE_VERSION}/bin/:${PATH}"
RUN node --version
RUN npm --version

RUN npm install -g yarn