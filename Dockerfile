FROM node:18-buster-slim

ENV DEV=false

WORKDIR /app

COPY package* ./
RUN npm ci

COPY . .
ENTRYPOINT [ "/bin/bash", "/app/entrypoint.sh" ]