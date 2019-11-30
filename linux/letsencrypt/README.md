需要安装jq,  
ubuntu:
```
sudo apt install -y jq
```

当前目录一个文件夹代表一个支持的dns服务商，  
使用add.sh添加域名对应的服务商，  
```
./add.sh aoeiuv020.com aliyun
```

key.sh保存dns服务商的accessToken相关，
```
cp -i key-example.sh key.sh
```

certbot自动续签使用certbot-renew-hook.sh
```
certbot-auto renew --manual-auth-hook certbot-renew-hook.sh ./key.sh
```

