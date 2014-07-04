# これは何

使い捨てのGoogle App Engine/Goの開発環境を目指すDockerfile

# 使い方

```bash
docker build -t mygodevenv .
```

```bash
docker run -d -v /root/work --name my-work -p 18080:8080 -p 1022:22 mygodevenv
docker run --rm -v /usr/local/bin/docker:/docker -v /var/run/docker.sock:/docker.sock svendowideit/samba my-work
```

表示されたメッセージに従いsambaのボリュームをローカルでマウントする

マウントしたフォルダにmyappというフォルダを作り、
ファイルを用意してAtom.ioなどの好きなエディタで開発をする

## ローカル（コンテナ内）での実行方法

### OSX以外

```bash
ssh root@localhost -p 1022
```

### OSX

```bash
boot2docker ip
```

以下の192.168.59.103の部分は上記のコマンドで表示されたIPアドレスを使用する。

```bash
ssh root@192.168.59.103 -p 1022
```

パスワードはgolang123

### GAEを動かす

```bash
/usr/local/go_appeinge serve --host 0.0.0.0 work/myapp/
```

OSXはboot2docker ipで表示されたIPアドレス:18080、他はlocalhost:18080を
ホスト側（dockerコマンドを実行している側）のブラウザで開く

## 終了

成果物をGithubにコミットするなり、外界に保存する。

```bash
docker stop my-work
docker rm my-work
```
