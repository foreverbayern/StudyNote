## mysql 安装/卸载
mysql 安装  
```
查看有没有安装mysql
dpkg -l | grep mysql  
```
安装
```

   sudo apt-get install mysql-server -y
   sudo apt install mysql-client  -y
   sudo apt install libmysqlclient-dev -y
//查看检查是否安装成功
netstat -tap | grep mysql
```  

查看mysql服务运行是否正常
```
systemctl status mysql
```  
mysql查看权限表
```
use mysql;
select host,user,authentication_string,plugin from user;

//添加远程访问账号
create user 'phdb_user'@'%' identified by '123456';
grant all privileges on *.* to 'phdb_user'@'%';
alter user 'phdb_user'@'%' identified with mysql_native_password by '123456';
flush privileges;
```

配置mysql允许远程访问
```
vim /etc/mysql/mysql.conf.d/mysqld.cnf  
注释掉bing-address 那行,保存退出

重启服务
service mysql restart
```
mysql 卸载
```
apt purge mysql-*;
rm -rf /etc/mysql /var/lib/mysql
apt autoremove
apt autoclean
```