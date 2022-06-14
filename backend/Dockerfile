# build
FROM maven:3.8.2-openjdk-16-slim as builder
LABEL stage=builder
# задаём переменную VERSION, которая будет использоваться для сборки проекта
ARG VERSION=${VERSION}
WORKDIR /usr/src/app
COPY . .
# копируем CA-сертификат Яндекса в образ
RUN curl https://storage.yandexcloud.net/cloud-certs/CA.pem -o YandexInternalRootCA.crt

# release
FROM openjdk:16-jdk-alpine
ARG VERSION=${VERSION}
WORKDIR /app
COPY --from=builder /usr/src/app/YandexInternalRootCA.crt .
# подкидываем CA-сертификат Яндекса в хранилище сертификатов для Java
# создаём пользователя jaruser
RUN keytool -importcert -file YandexInternalRootCA.crt \
	-alias yandex -cacerts -storepass changeit -noprompt \
	&& rm -rf YandexInternalRootCA.crt \
	&& addgroup --system jaruser \
	&& adduser -S -s /bin/false -G jaruser jaruser -D -H \
	&& apk add --no-cache dumb-init==1.2.5-r0
COPY --chown=jaruser:jaruser \
	./sausage-store-${VERSION}.jar ./sausage-store.jar
EXPOSE 8080
# приложение будет запускаться под пользователем jaruser
USER jaruser
ENTRYPOINT ["dumb-init", "java", "-Dmyserver.bindAddr=172.18.0.2", "-Dmyserver.bindPort=8080", "-jar", "./sausage-store.jar"]