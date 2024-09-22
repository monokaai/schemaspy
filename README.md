# 使い方

## 事前準備

まず SchemaSpy の Docker イメージをビルドする。

```bash
docker build --no-cache -t schemaspy_jp .
```

テスト用の DB コンテナ群を立ち上げる。

- initdb 内のスクリプトが自動実行されてテストデータ挿入が完了する
- users テーブル自体と内部のカラムおよびコメントに日本語でコメントあり（文字化けチェック用）

```bash
docker-compose up -d
```

## ファイル出力

補足：
MySQL は`character_set_client`が`utf8`や`utf8mb4`でないと文字化けするので、コンテナ起動時に mysql/my.cnf で設定している（ログインしてセッション中のみ変更する方法は後述）

```bash
# いずれか選択
export TARGET_DB=mysql
export TARGET_DB=postgres
```

```bash
docker run \
    --rm \
    --net=host \
    -v $PWD/output:/output \
    -v $PWD/${TARGET_DB}/schemaspy.properties:/schemaspy.properties \
    schemaspy_jp:latest
```

Access Denied となって MySQL に接続できない場合、Docker ボリュームをリセットすると動作する場合がある。

```bash
docker-compose down -v
docker-compose up -d
```

## その他

### MySQL

ログイン

```bash
docker exec -it mysql mysql --user=user --password=password my_database
```

テーブル定義・コメント確認

```bash
SHOW CREATE TABLE users\G
```

カラム定義・コメント確認

```bash
SHOW COLUMNS FROM users;
```

文字セットの確認・変更

```bash
-- サーバーの文字セットを確認
SHOW VARIABLES LIKE 'character_set_server';

-- クライアント通信用の文字セットを確認
SHOW VARIABLES LIKE 'character_set_client';

-- セッション中のクライアント通信用文字セットを変更
SET character_set_database=utf8mb4;

-- データベースの文字セットを確認
SHOW VARIABLES LIKE 'character_set_database';

```

シェルログイン

```bash
docker exec -it mysql sh
```

## Postgres

ログイン

```bash
docker exec -it postgres psql -U root -d my_database
```

テーブル定義・コメント確認

```bash
\d+
```

カラム定義・コメント確認

```bash
\d+ <table_name>
```

文字セットの確認・変更

```bash
SELECT * FROM information_schema.character_sets;
```

シェルログイン

```bash
docker exec -it postgres sh
```

参考：

- [公式ドキュメント(Configuration)](https://schemaspy.readthedocs.io/en/v6.0.0/configuration.html)
- [m1 mac で schemaspy を docker compose で動かす](https://www.aipacommander.com/entry/2023/02/01/194152)
- [M1Mac × Docker × SchemaSpy × MySQL8.0 でテーブル定義書と ER 図を自動生成してみる](https://gmor-sys.com/2022/10/19/db-document-autocreation-tool/)
- [Docker で MySQL 起動時にデータの初期化を行う](https://qiita.com/moaikids/items/f7c0db2c98425094ef10)
