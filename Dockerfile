FROM node:20-buster-slim@sha256:b5c14e85662c43b8c86a3a88259a34f0071474ad0a029ecb4ec39bbea588b030

ENV DEV=false

WORKDIR /app

COPY package* ./
RUN npm ci

COPY . .
ENTRYPOINT [ "/bin/bash", "/app/entrypoint.sh" ]