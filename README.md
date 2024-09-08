# 使い方

まず schemaspy の Docker イメージをビルドする。

```
docker build --no-cache -t schemaspy/japanese .
```

テスト用の MySQL コンテナを立ち上げる。

- initdb.d 内のスクリプトが自動実行してテストデータ挿入が完了する
- users テーブル自体と内部のカラムおよびコメントに日本語でコメントあり（文字化けチェック用）
- MySQL の`character_set_client`が`utf8`や`utf8mb4`でないと文字化けするので、コンテナ起動時に mysql/my.cnf で設定

```
docker-compose up -d
```

schemaspy のコンテナを一時的に立ち上げて 先ほど起動した MySQL に接続し、ER 図やテーブル定義を出力する。

```
docker run \
    --rm \
    --net=host \
    -v $PWD/output:/output \
    -v $PWD/mysql/schemaspy.properties:/schemaspy.properties \
    schemaspy/japanese:latest
```

Access Denied となって MySQL に接続できない場合、Docker ボリュームをリセットすると動作する場合がある。

```
docker-compose down -v
docker-compose up -d
```

# その他

DB ログイン

```
docker exec -it testdb mysql -u root -proot my_database
```

テーブル定義・コメント確認

```
show create table users\G
```

カラム定義・コメント確認

```
show columns from users
```

DB の文字セット確認

```
-- サーバーのデフォルト文字セットを確認
SHOW VARIABLES LIKE 'character_set_server';

-- デフォルトのクライアント文字セットを確認
SHOW VARIABLES LIKE 'character_set_client';

-- デフォルトのデータベース文字セットを確認
SHOW VARIABLES LIKE 'character_set_database';

```

MySQL シェルログイン

```
docker exec -it testdb sh
```

参考：

- [公式ドキュメント(Configuration)](https://schemaspy.readthedocs.io/en/v6.0.0/configuration.html)
- [m1 mac で schemaspy を docker compose で動かす](https://www.aipacommander.com/entry/2023/02/01/194152)
- [M1Mac × Docker × SchemaSpy × MySQL8.0 でテーブル定義書と ER 図を自動生成してみる](https://gmor-sys.com/2022/10/19/db-document-autocreation-tool/)
- [Docker で MySQL 起動時にデータの初期化を行う](https://qiita.com/moaikids/items/f7c0db2c98425094ef10)
