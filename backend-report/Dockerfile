FROM maven:3.8.2-openjdk-16-slim as builder
#Create build directory
ARG VERSION=${VERSION}
WORKDIR /usr/src/app
COPY . .
RUN curl https://storage.yandexcloud.net/cloud-certs/CA.pem -o YandexInternalRootCA.crt && \
    keytool -importcert -file YandexInternalRootCA.crt -alias yandex -cacerts -storepass changeit -noprompt && \
    rm -f YandexInternalRootCA.crt

FROM openjdk:16-jdk-alpine

ARG VERSION=${VERSION}
#Create app directory
WORKDIR /app

COPY ./sausage-store-report-${VERSION}/sausage-store-report-${VERSION}.jar sausage-store-report.jar

EXPOSE 8081
ENTRYPOINT ["java", "-jar", "-Dmyserver.bindPort=8081", "./sausage-store-report.jar"]