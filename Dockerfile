FROM node:18
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]