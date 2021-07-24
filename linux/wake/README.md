# 禁止特定设备唤醒电脑

先运行脚本./product，会列出所有usb设备id和名称，名称通常包含设备品牌，找到需要禁止的设备id，比如，  
> 1-7 -> Rapoo 2.4G Wireless Device

这个设备对应的id为“1-7”  

然后执行./mkln复制systemctl配置文件到系统里，  
之后就可以配置自动禁止唤醒了，
```shell
# 上面得到的id，
id=1-7
# 开机自动禁止，
sudo systemctl enable disable-wake@$id
# 立即禁止，
sudo systemctl start disable-wake@$id
```
