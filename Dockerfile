FROM openjdk:8u212-jdk-alpine

ENV DRIVER_URL https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-j-9.0.0.tar.gz
ENV APP_URL https://github.com/schemaspy/schemaspy/releases/download/v6.2.4/schemaspy-6.2.4.jar

WORKDIR /app

RUN apk --update add graphviz ttf-dejavu && \
    apk --update add --virtual .builddep tzdata wget libressl tar && \
    cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \
    mkdir /drivers && \
    wget -O /drivers/mysql-connector-java.tar.gz ${DRIVER_URL} && \
    tar -xzf /drivers/mysql-connector-java.tar.gz -C /drivers && \
    mv /drivers/mysql-connector-j-9.0.0/mysql-connector-j-9.0.0.jar /drivers/mysql-connector-java.jar && \
    wget -O schemaspy.jar ${APP_URL} && \
    apk del .builddep && \
    rm -rf /var/cache/apk/*


ENTRYPOINT ["java", "-jar", "schemaspy.jar", "-configFile", "/schemaspy.properties"]