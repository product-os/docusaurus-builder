FROM node:18

WORKDIR /app
COPY . .
ENTRYPOINT [ "/bin/bash", "/app/entrypoint.sh" ]