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

マウントしたフォルダにAtom.ioなどの好きなエディタで開発をする
