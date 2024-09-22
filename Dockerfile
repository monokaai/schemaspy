FROM arm64v8/openjdk:23-ea-17-slim-bullseye

ENV MYSQL_DRIVER_URL=https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-j-9.0.0.tar.gz
ENV POSTGRES_DRIVER_URL=https://jdbc.postgresql.org/download/postgresql-42.7.4.jar
ENV APP_URL=https://github.com/schemaspy/schemaspy/releases/download/v6.2.4/schemaspy-6.2.4.jar

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    tzdata \
    fonts-dejavu \
    libfreetype6 \
    fontconfig \
    && rm -rf /var/lib/apt/lists/* \
    && cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime \
    # Download and setup JDBC drivers
    && mkdir /drivers \
    ## MySQL
    && wget -O /drivers/mysql-connector-java.tar.gz ${MYSQL_DRIVER_URL} \
    && tar -xzf /drivers/mysql-connector-java.tar.gz -C /drivers \
    && mv /drivers/mysql-connector-j-9.0.0/mysql-connector-j-9.0.0.jar /drivers/mysql-connector-java.jar \
    && rm /drivers/mysql-connector-java.tar.gz \
    && rm -r /drivers/mysql-connector-j-9.0.0 \
    ## PostgreSQL
    && wget -O /drivers/postgresql.jar ${POSTGRES_DRIVER_URL} \
    ## Install app
    && wget -O schemaspy.jar ${APP_URL} \
    ## Cleanup
    && apt-get purge -y --auto-remove wget \
    && fc-cache -f -v

ENTRYPOINT ["java", "-jar", "schemaspy.jar", "-configFile", "/schemaspy.properties", "-vizjs"]