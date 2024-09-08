FROM --platform=linux/arm64 schemaspy/schemaspy:snapshot

# 環境変数設定
ENV DEBCONF_NOWARNINGS yes
ENV LANG=ja_JP.UTF-8
ENV LC_ALL=ja_JP.UTF-8

USER root

# 必要なパッケージをインストール
RUN apt-get update && \
    apt-get install -y curl fontconfig unzip udev fonts-noto-cjk


# MySQL Connector/Jのダウンロード
RUN mkdir -p /drivers && curl -o /drivers/mysql-connector-java-8.0.30.jar https://repo1.maven.org/maven2/mysql/mysql-connector-java/8.0.30/mysql-connector-java-8.0.30.jar
