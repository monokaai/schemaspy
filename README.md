# 使い方

schemaspy の Docker イメージをビルド

```
docker build -t schemaspy/japanese:ipaex00401 .
```

テスト用の MySQL コンテナを立ち上げる
※initdb.d 内のスクリプトが自動実行してテストデータ挿入が完了する

```
docker-compose up -d
```

schemaspy のコンテナを立ち上げて MySQL コンテナに接続し、DB 情報を出力する

```
docker run \
    --rm \
    --net=host \
    -v $PWD/output:/output \
    -v $PWD/properties/mysql.properties:/schemaspy.properties \
    schemaspy/japanese:ipaex00401
```

Access Denied となって接続できない場合、Docker ボリュームをリセットすると動作する場合がある。

```
docker-compose down -v
docker-compose up -d
```

# その他

DB ログイン

```
docker exec -it testdb mysql -u user -ppassword my_database
```

テーブルのコメント確認

```
show create table users\G
```

シェルログイン

```
docker exec -it testdb sh
```

参考：

- [SchemaSpy で日本語カラム名を含むデータベースから ER 図を作成](https://dev.classmethod.jp/articles/schemaspy-docker-localize-jp/#toc-2)
- [M1Mac × Docker × SchemaSpy × MySQL8.0 でテーブル定義書と ER 図を自動生成してみる](https://gmor-sys.com/2022/10/19/db-document-autocreation-tool/)
- [Docker で MySQL 起動時にデータの初期化を行う](https://qiita.com/moaikids/items/f7c0db2c98425094ef10)
