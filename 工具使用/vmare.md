### 问题解决
1. win10蓝屏
vmare虚拟机虚拟硬件时，将声卡、打印机这些移除，即可解决.
2. 静态IP配置
首先配置NAT，然后进入配置文件目录
```bash
cd /etc/netplan/ && ls 01-network-manager-all.yaml

network:
  version: 2
  renderer: NetworkManager
  ethernets:
    ens33:
      addresses: [192.168.30.30/24]
      dhcp4: no
      optional: true
      gateway4: 192.168.30.2
      nameservers:
        addresses: [8.8.8.8,8.8.4.4]
```
接着让配置生效
```
sudo netplan apply
```
然后再看ip addr 看生效没

