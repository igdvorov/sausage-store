FROM node:16-alpine
WORKDIR /usr/src/app
RUN addgroup --system front-user \
	&& adduser -S -s /bin/false -G front-user front-user -D -H
COPY --chown=front-user:front-user . .
RUN npm install && npm install -g http-server && npm run build
EXPOSE 3543/tcp
USER front-user
ENTRYPOINT ["http-server", "dist/frontend/", "-p", "3543", "--proxy", "http://backend:8080"] 
