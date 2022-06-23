# FROM node:16-alpine
# WORKDIR /usr/src/app
# RUN addgroup --system front-user \
# 	&& adduser -S -s /bin/false -G front-user front-user -D -H
# COPY --chown=front-user:front-user . .
# RUN npm install && npm install -g http-server && npm run build
# USER front-user
# EXPOSE 3543/tcp
# ENTRYPOINT ["http-server", "dist/frontend/", "-p", "3543", "--proxy", "http://sausage-backend:8080"] 

FROM node:16-alpine as builder
WORKDIR /usr/src/app
COPY . .
RUN npm install && npm run build

FROM nginxproxy/nginx-proxy
COPY --from=builder /usr/src/app/dist/frontend/*.* /usr/share/nginx/html/
COPY --from=builder /usr/src/app/nginx.tmpl /app/nginx.tmpl