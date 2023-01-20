FROM node:18-buster-slim

ENV DEV=false

WORKDIR /app
COPY . .
RUN npm ci
ENTRYPOINT [ "/bin/bash", "/app/entrypoint.sh" ]